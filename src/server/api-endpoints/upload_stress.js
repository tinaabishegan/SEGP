// Importing necessary modules
const { time } = require('console');
const db = require('../database/connection');
const fs = require('fs');
const { config } = require('dotenv');
const { parsed } = config();
const moment = require('../momentTz'); 

// Exporting an asynchronous function named upload_stress which takes req (request) and res (response) objects
module.exports = async function upload_stress(req, res) {
    try {
        // Checking if user session exists
        if (req.session.user != null) {
            const { result } = req.body; // Extracting stress result from request body

            // Getting current date and formatting it according to the provided time_path format in environment variables
            const currentDate = moment().format(process.env.time_path);
            const formattedDateTime = currentDate;

            // Extracting userId from session
            const userId = req.session.user.userId;

            // Query to insert stress data into the database
            const insertQuery = 'INSERT INTO `stress_level`(`userId`, `date_tested`, `stress_level`) VALUES (?,?,?)';

            // Execute the query to insert stress data
            await db.query(insertQuery, [userId, formattedDateTime, result], (err, result) => {
                if (err) {
                    // If an error occurs during database operation
                    console.log("Error during stress data upload:", err);
                    res.status(500).send({ message: 'Error in database operation', error: err });
                } else {
                    // If stress data is successfully uploaded
                    console.log("Stress data uploaded successfully");
                    res.status(200).send({ message: 'Stress Data Uploaded Successfully!' });
                }
            });
        } else {
            // If user session is undefined
            console.log("User session is undefined");
            res.status(401).send({ message: 'session user is undefined' });
        }
    } catch (error) {
        // Catching any other errors that occur during stress data upload
        console.error("Error during stress data upload:", error);
        res.status(500).send({ message: 'Internal Server Error' });
    }
};
