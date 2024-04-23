const router = require('express').Router();
const files = require('../multer-config');
const { login, logout, authenticate, register, profile, edit_profile, run_model, upload_file, upload_stress } = require('../api-endpoints');

// All API Endpoints go here
router.post('/authenticate', authenticate);
router.post('/register', register);
router.post('/login', login);
router.post('/logout', logout);
router.post('/profile', profile);
router.post('/edit_profile', edit_profile);
router.post('/run_model', run_model);
router.post('/upload_file', files.single('file'), upload_file);
router.post('/upload_stress', upload_stress);

module.exports = router;