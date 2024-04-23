// Importing necessary modules
const db = require('../database/connection');
const fs = require('fs');
const path = require('path');

// Exporting an asynchronous function named profile which takes req (request) and res (response) objects
module.exports = async function profile(req, res) {
    // Extracting userId from session
    const userId = req.session.user.userId;

    // Query to get user profile and stress level data by userId
    const query = `
        SELECT u.userName, u.userId, u.userEmail, u.userPassword, u.userBirthDate, s.date_tested, s.stress_level
        FROM user u
        LEFT JOIN stress_level s ON u.userId = s.userId
        WHERE u.userId = ?
    `;

    // Executing database query to fetch user profile data
    await db.query(query, [userId], async (err, result) => {
        if (err) {
            // Handling database error
            res.status(500).send({ message: 'Error in database operation', error: err });
        } else {
            if (result.length > 0) {
                // If user profile data found in database
                const userProfile = {
                    userName: result[0].userName,
                    userId: result[0].userId,
                    userEmail: result[0].userEmail,
                    userPassword: result[0].userPassword,
                    userBirthDate: result[0].userBirthDate,
                    stressData: result.map(row => ({
                        date_tested: row.date_tested,
                        stress_level: row.stress_level
                    }))
                };

                // Check if the image file exists
                const imagePath = path.join(__dirname, `../userImage/${userId}.png`);
                const defaultImagePath = path.join(__dirname, `../userImage/defaultImage.png`);
                if (fs.existsSync(imagePath)) {
                    // If user image exists, read the image file and encode it as base64
                    const imageBuffer = fs.readFileSync(imagePath);
                    const base64Image = imageBuffer.toString('base64');
                    userProfile.userImage = base64Image;
                } else {
                    // If user image does not exist, use default image
                    const imageBuffer = fs.readFileSync(defaultImagePath);
                    const base64Image = imageBuffer.toString('base64');
                    userProfile.userImage = base64Image;
                }

                // Send user profile data in the response
                res.status(200).send({ user: userProfile });
            } else {
                // If user profile data not found in database, send error message
                console.log("unknown bro");
                res.status(404).send({ message: 'User not found' });
            }
        }
    });
};
