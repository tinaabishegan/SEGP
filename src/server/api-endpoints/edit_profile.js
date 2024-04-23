// Importing necessary modules
const db = require('../database/connection'); // Adjust path as needed
const bcrypt = require('bcrypt');
const fs = require('fs').promises;

// Exporting an asynchronous function named edit_profile which takes req (request) and res (response) objects
module.exports = async function edit_profile(req, res) {
    // Extracting userId and other data from request body
    const userId = req.session.user.userId;
    const { userName, userEmail, userBirthDate, userOldPassword, userNewPassword, userImage } = req.body;

    // Query to get the user's current profile
    const query = 'SELECT * FROM user WHERE userId = ?';

    // Executing database query to fetch user's current profile
    await db.query(query, [userId], async (err, result) => {
        if (err) {
            // Handling database error
            return res.status(500).send({ message: 'Error in database operation', error: err });
        } else {
            if (result.length > 0) {
                // If user found in database
                const user = {
                    userName: result[0].userName,
                    userId: result[0].userId,
                    userEmail: result[0].userEmail,
                    userPassword: result[0].userPassword,
                    userBirthDate: result[0].userBirthDate
                };

                // Checking old password if provided
                if (userOldPassword) {
                    const isPasswordMatch = await bcrypt.compare(userOldPassword, user.userPassword);
                    if (!isPasswordMatch) {
                        return res.status(201).send({ message: 'Old password does not match' });
                    }
                }

                // Checking if the new email already exists
                if (userEmail != null && userEmail != user.userEmail) {
                    const queryCheckEmail = 'SELECT * FROM user WHERE userEmail = ?';
                    await db.query(queryCheckEmail, [userEmail], async (err, result) => {
                        if (err) {
                            return res.status(500).send({ message: 'Error in database operation', error: err });
                        } else {
                            if (result.length > 0) {
                                return res.status(201).send({ message: 'Email already exists' });
                            }
                        }
                    });
                }

                // Update the user's profile with the filled fields
                const updateFields = {};
                if (userNewPassword) {
                    const hashedNewPassword = await bcrypt.hash(userNewPassword, 12);
                    updateFields.userPassword = hashedNewPassword;
                }
                if (userEmail) {
                    updateFields.userEmail = userEmail;
                }
                if (userBirthDate) {
                    updateFields.userBirthDate = userBirthDate;
                }

                if (Object.keys(updateFields).length > 0) {
                    const queryUpdateProfile = 'UPDATE user SET ? WHERE userId = ?';
                    try {
                        // Executing database query to update user's profile
                        await db.query(queryUpdateProfile, [updateFields, userId], async (err, result) => {
                            if (err) {
                                return res.status(201).send({ message: 'Profile update failed' });
                            }
                        });

                        // Writing user image file
                        await fs.writeFile('./userImage/' + userId + '.png', userImage, { encoding: 'base64' });
                        console.log('File created');
                        return res.status(200).send({ message: 'Profile updated successfully' });
                    } catch (err) {
                        console.error(err);
                        return res.status(201).send({ message: 'Profile update failed' });
                    }
                } else {
                    return res.status(201).send({ message: 'No fields to update' });
                }
            } else {
                return res.status(401).send({ message: 'User not found' });
            }
        }
    });
};
