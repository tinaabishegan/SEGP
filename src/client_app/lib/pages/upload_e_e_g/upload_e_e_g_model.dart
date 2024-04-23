import 'package:file_picker/file_picker.dart';
import 'package:http_parser/http_parser.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'upload_e_e_g_widget.dart' show UploadEEGWidget;
import 'package:flutter/material.dart';
import 'package:food/dio.dart';
import 'package:dio/dio.dart';
import 'package:food/util.dart';

class UploadEEGModel extends FlutterFlowModel<UploadEEGWidget> {
  ///  Local state fields for this page.

  Dio dio = DioSingleton.getInstance();

  String modelType = 'LR';

  late String stressLevel;

  FilePickerResult? result;

  late BuildContext context;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  String dropDownValue = 'muse';
  FormFieldController<String>? dropDownValueController;
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    this.context = context;
  }

  @override
  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.

  Future<bool> authenticate() async {
    try {
      Response response = await dio.post('${getHost()}api/authenticate');

      if (response.statusCode == 200) {
        return true;
      }
      if (response.statusCode == 201) {
        return false;
      }
    } catch (error) {
      return false;
    }
    return false;
  }

  Future<bool> _upload_stress(String stressLevel) async {
    if (await authenticate()) {
      try {
        Response response = await dio.post('${getHost()}api/upload_stress',
            data: {'result': stressLevel.toLowerCase()});
        if (response.statusCode == 200) {
          return true;
        } else {
          print("db error---------------------------");
          return false;
        }
      } catch (error) {
        print('Error occurred: $error -----------------------------');
        return false;
      }
    } else {
      return true;
    }
  }

  Future<bool> _run_model(String filename, String model_type) async {
    try {
      print("tryna run------------------------------------------");
      Response response = await dio.post('${getHost()}api/run_model', data: {
        'filename': filename,
        'model_type': model_type.toLowerCase(),
        'headset_type': dropDownValue.toLowerCase(),
      });

      if (response.statusCode == 200) {
        String stressLevel = response.data['response'];
        print(stressLevel);

        if (stressLevel.endsWith("Stress")) {
          // Assuming you have named routes set up, replace 'destinationRouteName'
          // with the actual name of the route you want to navigate to.
          context.goNamed(
            'stressResult',
            queryParameters: {
              'stressResult': serializeParam(
                stressLevel,
                ParamType.String,
              ),
            }.withoutNulls,
          );
          return true; // Assuming navigation is a successful outcome.
        } else {
          // Show a Snackbar if the response does not end with "Stress".
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Received unexpected response: $stressLevel'),
              duration: Duration(seconds: 3),
            ),
          );
          return false; // Since this is not the expected outcome.
        }
      } else {
        print("model error---------------------------");
        return false;
      }
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> upload_file(Uint8List? bytes, String name) async {
    String extension = name.split(".").last;
    var formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(
        bytes!,
        filename: name,
        contentType: MediaType("File", extension),
      ),
    });

    try {
      Response response =
          await dio.post('${getHost()}api/upload_file', data: formData);

      if (response.statusCode == 200) {
        print('file uploaded successfully!-------------------------------');
        return await _run_model(name, modelType);
      } else {
        print('file uploaded NOOO!---------------------');
        return false;
      }
    } catch (error) {
      print('Error occurred: $error -------------------');
      return false;
    }
  }

  String? get radioButtonValue => radioButtonValueController?.value;
}
