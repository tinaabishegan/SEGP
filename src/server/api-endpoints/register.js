// Importing necessary modules
const db = require('../database/connection'); // Adjust path as needed
const bcrypt = require('bcrypt');

// Exporting a function named register which takes req (request) and res (response) objects
module.exports = function register(req, res) {
    // Extracting user details from request body
    const { userName, userId, userEmail, userPassword, userBirthDate } = req.body;

    // Validate userBirthDate format (YYYY-MM-DD)
    const dateRegex = /^\d{4}-\d{2}-\d{2}$/;
    if (!dateRegex.test(userBirthDate)) {
        return res.status(400).send({ message: 'Invalid date format. Please use YYYY-MM-DD.' });
    }

    // Check if userEmail or userId already exists in the database
    const checkQuery = 'SELECT * FROM user WHERE userEmail = ? OR userId = ?';
    db.query(checkQuery, [userEmail, userId], (checkErr, checkResult) => {
        if (checkErr) {
            // Handling database error during user existence check
            return res.status(500).send({ message: 'Error in database operation', error: checkErr });
        }

        if (checkResult.length > 0) {
            // If userEmail or userId already exists, send an error message
            return res.status(209).send({ message: 'User with the same email or ID already exists' });
        }

        // If userEmail or userId doesn't exist, proceed with hashing password and inserting into the database
        bcrypt.hash(userPassword, 12, async (hashErr, hashedPassword) => {
            if (hashErr) {
                // Handling error in password hashing
                return res.status(500).send({ message: 'Error in password hashing', error: hashErr });
            }

            // Query to insert a new user into the database
            const insertQuery = 'INSERT INTO user (userName, userId, userEmail, userPassword, userBirthDate) VALUES (?, ?, ?, ?, ?)';

            // Execute the query to insert the new user
            db.query(insertQuery, [userName, userId, userEmail, hashedPassword, userBirthDate], (insertErr, result) => {
                if (insertErr) {
                    // Handling database error during user insertion
                    return res.status(500).send({ message: 'Error in database operation', error: insertErr });
                }
                
                // Send success message after user registration
                res.status(201).send({ message: 'User registered successfully' });
            });
        });
    });
};
