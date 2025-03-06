const express = require('express');
const router = express.Router();
const tenantController = require('../controllers/tenantController'); 


// Define routes
router.get('/getTenants', tenantController.getTenants);

module.exports = router;
