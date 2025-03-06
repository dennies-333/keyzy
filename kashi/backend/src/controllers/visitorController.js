const fs = require('fs');
const path = require('path');
const { v4: uuidv4 } = require('uuid');


// File path for visitors
const visitorsFilePath = path.join(__dirname, '../data/visitors.json');

// Helper: Get current timestamp
const getCurrentTimestamp = () => new Date().toISOString();

// Load visitors from JSON file
const getVisitors = () => {
  try {
    const data = fs.readFileSync(visitorsFilePath, 'utf8');
    return JSON.parse(data);
  } catch (error) {
    console.error('Error reading visitors.json:', error.message);
    return [];
  }
};

// Save visitors to JSON file
const saveVisitors = (visitorData) => {
  try {
    fs.writeFileSync(visitorsFilePath, JSON.stringify(visitorData, null, 2));
    console.log(`[${getCurrentTimestamp()}] Visitors data saved.`);
  } catch (error) {
    console.error('Error saving visitors.json:', error.message);
  }
};

// POST: Add a visitor
exports.addVisitor = (req, res) => {
    const { tenantId, name, relationship } = req.body;
  
    if (!tenantId || !name || !relationship) {
      return res.status(400).json({ message: 'All fields (tenantId, name, relationship) are required.' });
    }
  
    const newVisitor = {
      visitorId: uuidv4(),
      tenantId,
      name,
      relationship,
      timestamp: getCurrentTimestamp(),
    };
  
    try {
      let visitors = getVisitors();
      visitors.push(newVisitor);
      saveVisitors(visitors);
  
      res.status(201).json({
        message: 'Visitor added successfully',
        visitor: newVisitor,
      });
    } catch (error) {
      console.error('Error adding visitor:', error.message);
      res.status(500).json({ message: 'Internal server error' });
    }
  };
  
  // DELETE: Remove a visitor by visitorId
  exports.deleteVisitor = (req, res) => {
    const { visitorId } = req.body;
  
    if (!visitorId) {
      return res.status(400).json({ message: 'Visitor ID is required.' });
    }
  
    try {
      let visitors = getVisitors();
      const filteredVisitors = visitors.filter(visitor => visitor.visitorId !== visitorId);
  
      if (visitors.length === filteredVisitors.length) {
        return res.status(404).json({ message: 'Visitor not found.' });
      }
  
      saveVisitors(filteredVisitors);
      res.status(200).json({ message: 'Visitor deleted successfully.' });
    } catch (error) {
      console.error('Error deleting visitor:', error.message);
      res.status(500).json({ message: 'Internal server error' });
    }
  };
  
// GET: Get all visitors
exports.getVisitors = (req, res) => {
  try {
    const visitors = getVisitors();
    res.status(200).json(visitors);
  } catch (error) {
    console.error('Error fetching visitors:', error.message);
    res.status(500).json({ message: 'Failed to fetch visitors' });
  }
};

// GET: Get visitors by tenantId
exports.getVisitorsByTenant = (req, res) => {
  const { tenantId } = req.params;

  if (!tenantId) {
    return res.status(400).json({ message: 'Tenant ID is required.' });
  }

  try {
    const visitors = getVisitors().filter(visitor => visitor.tenantId === tenantId);
    res.status(200).json(visitors);
  } catch (error) {
    console.error('Error fetching visitors by tenant:', error.message);
    res.status(500).json({ message: 'Failed to fetch visitors by tenant ID' });
  }
};

// Auto-delete visitors older than 30 minutes
const clearOldVisitorsTask = () => {
  setInterval(() => {
    try {
      let visitors = getVisitors();
      const now = new Date();

      visitors = visitors.filter(visitor => {
        const visitorTime = new Date(visitor.timestamp);
        return now - visitorTime < 30 * 60 * 1000; // Keep visitors added within last 30 minutes
      });

      saveVisitors(visitors);
      console.log(`[${getCurrentTimestamp()}] Old visitors cleared. Remaining visitors:`, visitors);
    } catch (error) {
      console.error('Error during cleanup task:', error.message);
    }
  }, 30 * 60 * 1000); // Runs every 30 minutes
};

// Start cleanup task
clearOldVisitorsTask();
