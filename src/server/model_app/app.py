from tensorflow.keras.models import load_model
from scipy.io import loadmat
import numpy as np
import pandas as pd
import joblib
import io
import os
import sys
from dotenv import load_dotenv
import traceback

load_dotenv()

rnn_model_path = os.getenv('rnn_model_path')
lr_model_path = os.getenv('lr_model_path')
rnn2_model_path = os.getenv('rnn2_model_path')
lr2_model_path = os.getenv('lr2_model_path')

file_path = "./files/" + sys.argv[1]
model_type = sys.argv[2]
headset_type = sys.argv[3]

# Load the models - first the models which classify stress or no stress
# next load the models which classify low stress or high stress
rnn_model = load_model(rnn_model_path)
lr_model = joblib.load(lr_model_path)
rnn2_model = load_model(rnn2_model_path)
lr2_model = joblib.load(lr2_model_path)


# filetype input should be either ".csv" or ".mat"

# Method for model inference
def perform_model_inference(eeg_sample, model_type):
    # Make predictions using the selected model - first stress or no stress
    if model_type == 'rnn':
        prediction1 = np.round(rnn_model.predict(np.expand_dims(eeg_sample, axis=0)))
        mode_prediction1 = prediction1[0][0]
    elif model_type == 'lr':
        prediction1 = np.round(lr_model.predict(np.expand_dims(eeg_sample.flatten(), axis=0)))
        mode_prediction1 = prediction1[0]
    else:
        return "Error: Invalid model type selected"

    if mode_prediction1 == 1:  # if stress feed into second model which classifies low or high stress

        if model_type == 'rnn':
            prediction2 = np.round(rnn2_model.predict(np.expand_dims(eeg_sample, axis=0)))
            mode_prediction2 = prediction2[0][0]

        elif model_type == 'lr':
            prediction2 = np.round(lr2_model.predict(np.expand_dims(eeg_sample.flatten(), axis=0)))
            mode_prediction2 = prediction2[0]

        if mode_prediction2 == 1:
            return "High Stress"
        else:
            return "Low Stress"
    else:
        return "No Stress"


# filetype input should be either ".csv" or ".mat"
# if user selects Emotiv headset -> .mat file expected, if Muse headset -> .csv file expected
# expected filetype is derived from headset selection
def upload_file(file_path, model_type, headset_type):
    file_name = os.path.basename(file_path)  # Get the filename from the file path
    filetype_validate = os.path.splitext(file_name)  # to check if the right filetype was uploaded
    eeg_data = 0
    try:

        if filetype_validate[1] == '.mat' and headset_type == 'emotiv':
            # For .mat files
            mat_data = loadmat(file_path)  # Load the .mat file directly using the path
            eeg_data = find_eeg_array(mat_data)

            validated_eeg_data = validate_mat_file(eeg_data)

            # if validated_eeg_data == [[-1, -1, -1]]:
            #     return "result: Unexpected number of channels. Please ensure you have the 32 channels used in the Emotiv headset."
            # elif validated_eeg_data == [[-2, -2, -2]]:
            #     return "result: Error: Insufficient number of time samples. Your sample should have at least 3200 time samples."
            # else:
            processed_eeg_data = process_mat_file(validated_eeg_data)
            result = perform_model_inference(processed_eeg_data, model_type)
            return "result: " + result

        elif filetype_validate[1] == '.csv' and headset_type == 'muse':
            # For .csv files
            csv_data = pd.read_csv(file_path, header=0)
            validated_eeg_data = validate_csv_file(csv_data)

            if validated_eeg_data.equals(pd.DataFrame(np.full((188, 39), -1))):
                return "result: Unexpected sample dimensions. Please ensure you have the original 39 columns' data from the Muse SDK."
            elif validated_eeg_data.equals(pd.DataFrame(np.full((188, 39), -2))):
                return "result: Error: Insufficient number of time samples. Your sample should have at least 188 time samples."
            else:
                processed_eeg_data = process_csv_file(validated_eeg_data)
                result = perform_model_inference(processed_eeg_data, model_type)
                return "result: " + result

        else:
            return "result: Please reupload the file. Make sure you have selected a file with the specified file format."
    except ValueError as e:
        return f"result: ErrorEEEE: {str(e)}"
    except Exception as e:
        error_message = str(e)
        traceback_str = traceback.format_exc()
        return "result: Error:" + error_message + "\nERROR MESSAGE: " + traceback_str



def find_eeg_array(mat_data):
    # Iterate over keys to find an array suitable for EEG data
    for key in mat_data:
        if isinstance(mat_data[key], np.ndarray):
            return mat_data[key]

    return None


def get_freq_bands(eeg_signal):  # takes in one channel of data, splits into 5 frequency bands
    # define sampling rate
    sampling_rate = 128  # for the Emotiv headset from SAM-40 headset
    frequency_bands = {
        'delta': (0.5, 4),
        'theta': (4, 8),
        'alpha': (8, 13),
        'beta': (13, 30),
        'gamma': (30, 100)
    }

    # perform FFT
    fft_result = np.fft.fft(eeg_signal)

    # calculating frequency values
    freqs = np.fft.fftfreq(len(eeg_signal), 1 / sampling_rate)

    # initialize arrays to store power in each band
    band_powers = {band: np.zeros_like(eeg_signal, dtype=float) for band in frequency_bands}

    # iterate over the frequency bands and calculate each power
    for band, (low, high) in frequency_bands.items():
        band_mask = np.logical_and(freqs >= low, freqs <= high)
        band_indices = np.where(band_mask)
        band_powers[band] = np.abs(fft_result)[band_indices]
    return band_powers


def validate_mat_file(eeg_data):
    num_channels = eeg_data.shape[0]
    if num_channels != 32:
        raise ValueError("Unexpected number of channels. Please ensure you have the 32 channels used in the Emotiv headset.")
    # if 32 channels, continue
    num_samples = eeg_data.shape[1]
    if num_samples < 3200:
        raise ValueError("Insufficient number of time samples. Your sample should have at least 3200 time samples.")
    elif num_samples > 3200:  # Trim to the first 3200 samples
        eeg_data = eeg_data[:, :3200]
    return eeg_data


def validate_csv_file(eeg_data):  # ideal shape: (188,39) (samples, columns)

    # filter out empty rows (due to eye blinks/jaw clenches) before checking number of samples
    eeg_data = eeg_data.dropna(subset=[eeg_data.columns[1]])
    num_columns = eeg_data.shape[1]
    if num_columns != 39:  # the Muse headset directly provides 39 columns of data, which includes raw and filtered EEG data.
        return pd.DataFrame(
            np.full((188, 39), -1))  # if file does not have original 39 columns, channel extraction becomes ambiguous.
    # if has all 39 columns, continue
    num_samples = eeg_data.shape[0]
    if num_samples > 188:  # if greater than 188 samples, trim so that the array only has first 188 time samples
        eeg_data = eeg_data.head(188)
    elif num_samples < 188:
        return pd.DataFrame(np.full((188, 39), -2))
    return eeg_data


def process_mat_file(eeg_data):  # get the whole numpy array eeg_data as a parameter
    optimal_Channel_indices = [2, 31]
    # flatten input data along channel axis
    selected_data = eeg_data[optimal_Channel_indices, :]
    eeg_channel_Fp1 = selected_data[0]
    eeg_channel_Fp2 = selected_data[1]

    band_powers1_dict = get_freq_bands(eeg_channel_Fp1)
    band_powers2_dict = get_freq_bands(eeg_channel_Fp2)

    # trim features section to fit the models expected shape
    trim_num1 = len(band_powers1_dict['delta']) + len(band_powers1_dict['theta']) + len(
        band_powers1_dict['alpha']) + len(band_powers1_dict['beta']) + len(band_powers1_dict['gamma']) - 940
    trim_num2 = len(band_powers2_dict['delta']) + len(band_powers2_dict['theta']) + len(
        band_powers2_dict['alpha']) + len(band_powers2_dict['beta']) + len(band_powers2_dict['gamma']) - 940

    # trim gamma features for fitting - gamma features reach over 800 sometimes, information loss is negligible.
    band_powers1_gamma_trimmed = band_powers1_dict['gamma'][:-trim_num1]
    band_powers2_gamma_trimmed = band_powers2_dict['gamma'][:-trim_num2]

    # concatenate band powers for channel Fp1
    fp1_band_powers = np.concatenate((band_powers1_dict['delta'],
                                      band_powers1_dict['theta'],
                                      band_powers1_dict['alpha'],
                                      band_powers1_dict['beta'],
                                      band_powers1_gamma_trimmed), axis=0)

    # concatenate band powers for channel Fp2
    fp2_band_powers = np.concatenate((band_powers2_dict['delta'],
                                      band_powers2_dict['theta'],
                                      band_powers2_dict['alpha'],
                                      band_powers2_dict['beta'],
                                      band_powers2_gamma_trimmed), axis=0)

    selected_data = np.zeros((2, len(fp1_band_powers)))

    selected_data[0] = fp1_band_powers
    selected_data[1] = fp2_band_powers
    input_for_model1 = selected_data

    return input_for_model1


def process_csv_file(eeg_data):
    # extracting the five frequency bands for the two optimal channels AF7 and AF8
    AF7_band_powers = eeg_data.iloc[:, [2, 6, 10, 14, 18]]
    AF8_band_powers = eeg_data.iloc[:, [3, 7, 11, 15, 19]]

    AF7_band_powers = AF7_band_powers.values.flatten()
    AF8_band_powers = AF8_band_powers.values.flatten()

    input_for_model = np.zeros((2, len(AF7_band_powers)))
    input_for_model[0] = AF7_band_powers
    input_for_model[1] = AF8_band_powers

    return input_for_model


if __name__ == '__main__':
    ans = upload_file(file_path, model_type, headset_type)
    print(ans)
    sys.stdout.flush()