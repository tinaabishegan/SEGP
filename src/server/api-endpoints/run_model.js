// Importing necessary modules
const { config } = require('dotenv'); // dotenv for environment variables
// Destructuring parsed object from dotenv config
const { parsed } = config();
const spawn = require("child_process").spawn; // Child process for spawning Python process

// Exporting an asynchronous function named run_model which takes req (request) and res (response) objects
module.exports = async function run_model(req, res) {
    // Extracting filename, model_type, and headset_type from request body
    const { filename, model_type, headset_type } = req.body;

    // Spawning a Python process
    const pythonProcess = spawn('python', [parsed.app_path, filename, model_type, headset_type]);

    let output = ''; // Accumulator for stdout data
    let errorOutput = ''; // Accumulator for stderr data

    // Listening for data events on stdout
    pythonProcess.stdout.on('data', (data) => {
        output += data.toString(); // Accumulating stdout data
    });

    // Listening for data events on stderr
    pythonProcess.stderr.on('data', (data) => {
        errorOutput += data.toString(); // Accumulating stderr data
    });

    // Listening for close event on the Python process
    pythonProcess.on('close', (code) => {
        const resultPrefix = "result:";
        const startIndex = output.indexOf(resultPrefix);

        let result = "No result found";
        if (startIndex !== -1) {
            result = output.substring(startIndex + resultPrefix.length).trim(); // Extracting result from output
        }

        console.log(result); // Logging the result

        // Check if there's successful output despite warnings or errors
        if (output) {
            console.log("Output received, sending successful response.");
            // Sending successful response with result and any warnings
            res.status(200).send({ response: result, warnings: errorOutput });
        } else if (errorOutput) { // If there's no successful output but there are errors
            console.error("Error with no successful output.");
            console.log(errorOutput); // Logging the errors
            // Sending error response with error details
            res.status(400).send({ response: 'Data unsuccessful', error: errorOutput });
        } else { // No output and no errors (unlikely, but as a fallback)
            console.log("No output and no identifiable errors.");
            // Sending error response indicating unknown error
            res.status(400).send({ response: 'No data returned', error: 'Unknown error' });
        }
    });
};
