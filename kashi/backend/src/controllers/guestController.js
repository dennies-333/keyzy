const fs = require('fs');
const path = require('path');

// File paths
const guestsFilePath = path.join(__dirname, '../data/guests.json');
const usersFilePath = path.join(__dirname, '../data/users.json');

// Gate status variable
let gateStatus = 'closed';

// Helper: Get today's date (YYYY-MM-DD)
const getCurrentDate = () => new Date().toISOString().split('T')[0];

// Load users
const getUsers = () => {
  try {
    const data = fs.readFileSync(usersFilePath, 'utf8');
    return JSON.parse(data);
  } catch (error) {
    console.error('Error reading users.json:', error.message);
    return [];
  }
};

// Load guests
const getGuests = () => {
  try {
    const data = fs.readFileSync(guestsFilePath, 'utf8');
    return JSON.parse(data); // Assumes the file contains an array of guests
  } catch (error) {
    console.error('Error reading guests.json:', error.message);
    return []; // Return an empty array if file is missing or invalid
  }
};

// Save guests
const saveGuests = (guests) => {
  try {
    fs.writeFileSync(guestsFilePath, JSON.stringify(guests, null, 2));
    console.log('Guests data saved successfully.');
  } catch (error) {
    console.error('Error saving guests.json:', error.message);
  }
};

// Clear guests with past dates at midnight
const clearPastGuestsTask = () => {
  setInterval(() => {
    const now = new Date();
    if (now.getHours() === 0 && now.getMinutes() === 0) {
      console.log(`[${now.toISOString()}] Running daily guest cleanup...`);

      let guests = getGuests();
      const today = new Date().toISOString().split('T')[0]; // Get current date in 'YYYY-MM-DD' format

      const pastGuests = guests.filter(guest => guest.day < today); // Identify guests to be removed
      guests = guests.filter(guest => guest.day >= today);

      saveGuests(guests);

      console.log(`[${now.toISOString()}] Cleared ${pastGuests.length} past guests.`);
      console.log('Remaining guests:', guests);
    }
  }, 60000); // Check every minute
};

// Clear guests with past dates at midnight
// const clearPastGuestsTask = () => {
//   setInterval(() => {
//     const now = new Date()
//     console.log(`[${now.toISOString()}] Running daily guest cleanup...`);

//     let guests = getGuests();
//     const today = new Date().toISOString().split('T')[0]; // Get current date in 'YYYY-MM-DD' format

//     const pastGuests = guests.filter(guest => guest.day < today); // Identify guests to be removed
//     guests = guests.filter(guest => guest.day >= today);

//     saveGuests(guests);

//     console.log(`[${now.toISOString()}] Cleared ${pastGuests.length} past guests.`);
//     console.log('Remaining guests:', guests);
  
//   }, 60000); // Check every minute
// };

clearPastGuestsTask();


// Add a guest entry directly
exports.addGuest = (req, res) => {
  const { tenantId, name, vehicleType, vehicleNumber, day } = req.body;
  console.log('Guests data received:', req.body);

  // Validate request body
  if (!tenantId || !name || !vehicleType || !vehicleNumber || !day) {
    return res.status(400).json({ message: 'All fields are required' });
  }

  // Convert day to Date object and check if it's valid
  const currentDate = new Date();
  const guestDate = new Date(day);

  if (isNaN(guestDate.getTime())) {
    return res.status(400).json({ message: 'Invalid date format' });
  }

  if (guestDate < currentDate.setHours(0, 0, 0, 0)) {
    return res.status(400).json({ message: 'The day cannot be in the past' });
  }

  // Check if tenant exists and has the 'tenant' role
  const users = getUsers();
  const tenant = users.find(user => user.id === tenantId && user.role === 'tenant');

  if (!tenant) {
    return res.status(403).json({ message: 'Invalid tenant ID or unauthorized access' });
  }

  // Load current guests
  let guests = getGuests();
  if (!Array.isArray(guests)) {
    guests = [];
  }

  // Check for duplicate vehicleNumber
  const isDuplicateVehicle = guests.some(guest => guest.vehicleNumber === vehicleNumber);

  if (isDuplicateVehicle) {
    return res.status(400).json({ message: 'A guest with this vehicle number already exists' });
  }

  // Add new guest entry directly
  guests.push({ tenantId, name, vehicleType, vehicleNumber, day });
  saveGuests(guests);

  res.status(200).json({
    message: 'Guest added successfully',
    guest: { tenantId, name, vehicleType, vehicleNumber, day }
  });
};



// Get gate status
exports.getStatus = (req, res) => {
  res.status(200).json({ gateStatus });
};

// Update gate status
exports.setGateStatus = (req, res) => {
  const { status } = req.body;

  if (!['open', 'closed'].includes(status)) {
    return res.status(400).json({ message: 'Invalid gate status' });
  }

  gateStatus = status;
  res.status(200).json({ message: 'Gate status updated', gateStatus });
};
