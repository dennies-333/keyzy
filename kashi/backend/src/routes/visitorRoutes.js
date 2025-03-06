const express = require('express');
const router = express.Router();
const visitorController = require('../controllers/visitorController'); 



// Visitor routes
router.post('/addVisitor', visitorController.addVisitor);
router.get('/getVisitors', visitorController.getVisitors);
router.get('/getVisitors/:tenantId', visitorController.getVisitorsByTenant);
router.post('/deleteVisitor', visitorController.deleteVisitor);

module.exports = router;
