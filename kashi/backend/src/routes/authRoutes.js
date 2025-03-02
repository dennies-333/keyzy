const express = require('express');
const router = express.Router();
const { signIn, getDetails} = require('../controllers/authController'); // Import signIn function

// POST route for sign-in
router.post('/signin', signIn);
router.get('/users/:id', getDetails);

module.exports = router;
