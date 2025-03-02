const fs = require('fs');
const path = require('path');

// Updated path to the users.json file
const usersFilePath = path.join(__dirname, '../data/users.json');


// Function to read users from the JSON file
const getUsers = () => {
  try {
    console.log('Reading users data from:', usersFilePath); // Debug log
    const usersData = fs.readFileSync(usersFilePath);
    const parsedUsers = JSON.parse(usersData);
    console.log('Users data successfully loaded:', parsedUsers); // Debug log
    return parsedUsers;
  } catch (error) {
    console.error('Error reading or parsing users.json:', error); // Error log
    throw new Error('Could not read or parse users.json');
  }
};


// Single Sign-in Logic (Unified for all user types)
exports.signIn = (req, res) => {
  const { username, password } = req.body;

  console.log('Received sign-in request with username:', username); // Debug log

  try {
    // Fetch users from the JSON file
    const users = getUsers();

    // Find user by username
    const user = users.find(user => user.username === username);

    if (!user) {
      console.log(`User with username '${username}' not found.`); // Debug log
      return res.status(404).json({ message: 'User not found' });
    }

    // Check if password matches
    if (user.password !== password) {
      console.log(`Invalid password for user '${username}'.`); // Debug log
      return res.status(401).json({ message: 'Invalid password' });
    }

    // If authentication is successful, return the user details including the role
    console.log(`User '${username}' authenticated successfully.`); // Debug log
    return res.status(200).json({
      message: 'Sign-in successful',
      user: {
        id: user.id,
        username: user.username,
        role: user.role
      }
    });
  } catch (error) {
    console.error('Error in sign-in logic:', error); // Error log
    return res.status(500).json({ message: 'Internal server error' });
  }
};

// Get Details API - Fetch all details based on user ID
exports.getDetails = (req, res) => {
  const { id } = req.params;  // Assuming the ID is passed as a URL parameter

  console.log('Received request to get details for user with ID:', id); // Debug log

  try {
    // Fetch users from the JSON file
    const users = getUsers();

    // Find user by ID
    const user = users.find(user => user.id === id);

    if (!user) {
      console.log(`User with ID '${id}' not found.`); // Debug log
      return res.status(404).json({ message: 'User not found' });
    }

    // Check role and return appropriate data
    if (user.role === 'tenant') {
      // For tenants, return full details
      console.log(`Tenant details for user with ID '${id}' fetched successfully.`); // Debug log
      return res.status(200).json(user); // You can modify this to return only the tenant-specific fields if needed
    }

    if (user.role === 'admin' || user.role === 'security') {
      console.log(`Admin/Security details for user with ID '${id}' fetched successfully.`); // Debug log
      const { id, username, role } = user; // Return only necessary details for admin/security
      return res.status(200).json({ id, username, role });
    }

    // If the role is not recognized
    return res.status(400).json({ message: 'Role not recognized' });
  } catch (error) {
    console.error('Error in getDetails logic:', error); // Error log
    return res.status(500).json({ message: 'Internal server error' });
  }
};
