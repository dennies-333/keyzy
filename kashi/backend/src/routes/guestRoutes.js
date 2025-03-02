const express = require('express');
const router = express.Router();
const guestController = require('../controllers/guestController'); 

// Define routes
router.get('/gateStatus', guestController.getStatus);
router.post('/addGuest', guestController.addGuest);

module.exports = router;
