const multer = require('multer');

// Configure Multer for file uploads
const storage = multer.memoryStorage();

const files = multer({ storage: storage });

module.exports = files;