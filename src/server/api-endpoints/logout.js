// Exporting an asynchronous function named logout which takes req (request) and res (response) objects
module.exports = async function logout(req, res){
    // Destroying the session
    await req.session.destroy(err => {
        if (err) {
            // Handling error if session destruction fails
            return res.status(500).json({ success: false, message: 'Error logging out!', error: err });
        }
        // Sending success message if session is destroyed successfully
        return res.status(200).json({ success: true, message: 'Logout successful!' });
    });
    // Console log session if needed
    // console.log(req.session);
}
