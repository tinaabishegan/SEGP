// Importing necessary modules
const db = require('../database/connection'); // Adjust path as needed
const bcrypt = require('bcrypt');

// Exporting an asynchronous function named login which takes req (request) and res (response) objects
module.exports = async function login(req, res) {
    // Extracting userEmail and userPassword from request body
    const { userEmail, userPassword } = req.body;

    // Query to find user by email
    const query = 'SELECT * FROM user WHERE userEmail = ?';

    // Executing database query to find user by email
    await db.query(query, [userEmail], async (err, result) => {
        if (err) {
            // Handling database error
            res.status(500).send({ message: 'Error in database operation', error: err });
        } else {
            if (result.length > 0) {
                // If user with the given email found in database
                const match = await bcrypt.compare(userPassword, result[0].userPassword);
                if (match) {
                    // If password matches, create a session and store user details
                    req.session.user = {
                        userId: result[0].userId,
                        userName: result[0].userName
                    };
                    res.status(200).send({ message: 'Login successful' });
                } else {
                    // If password doesn't match, send error message
                    res.status(201).send({ message: 'Invalid credentials' });
                }
            } else {
                // If user with the given email not found, send error message
                res.status(401).send({ message: 'User not found' });
            }
        }
    });
}
