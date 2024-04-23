// Importing the fs module for file system operations
const fs = require('fs');

// Exporting an asynchronous function named upload_file which takes req (request) and res (response) objects
module.exports = async function upload_file(req, res) {
    try {
        // Extracting file metadata (originalname) and file buffer from the request file
        const { originalname, buffer } = req.file;

        // Specify the path where you want to save the file on the server
        const filePath = `./files/${originalname}`;  // You can customize the path as needed

        // Write the buffer to the file
        fs.writeFileSync(filePath, buffer);

        // Logging message indicating successful upload
        console.log("File upload done");

        // Sending a success response
        res.status(200).send({ response: 'done' });
    } catch (error) {
        // Handling errors that occur during file upload
        console.error(error);

        // Sending an error response with details of the error
        res.status(500).send({ response: 'Error occurred', error: error.message });
    }
};
