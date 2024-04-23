// Exporting an asynchronous function named authenticate which takes req (request) and res (response) objects
module.exports = async function authenticate(req, res) {
    try {
        // Checking if req.session.user is not null
        if (req.session.user != null) {
            // Checking if req.session.user.userId is not null
            if (req.session.user.userId != null) {
                // If userId is not null, user is logged in
                res.status(200).send({ message: 'User is currently logged in' });
            } else {
                // If userId is null, user is not logged in
                console.log("authjs not logged in");
                res.status(201).send({ message: 'User is not currently logged in' });
            }
        } else {
            // If req.session.user is null, session user is undefined
            console.log("user is undefined");
            res.status(401).send({ message: 'session user is undefined' });
        }
    } catch (error) {
        // Catching any errors that occur during authentication
        console.error("Error during authentication:", error);
        // Sending Internal Server Error status in case of error
        res.status(500).send({ message: 'Internal Server Error' });
    }
}
