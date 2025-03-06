const fs = require('fs');
const path = require('path');

// File path for users data
const usersFilePath = path.join(__dirname, '../data/users.json');

// Function to get all users with role 'tenant' and return selected fields
exports.getTenants = (req, res) => {
  try {
    const data = fs.readFileSync(usersFilePath, 'utf8');
    const users = JSON.parse(data);

    // Filter and map tenant users to only return specific fields
    const tenantUsers = users
      .filter(user => user.role === 'tenant')
      .map(({ id, email, phone, address, name, unit_number }) => ({
        id,
        email,
        phone,
        address,
        name,
        unit_number
      }));

    res.status(200).json(tenantUsers);
  } catch (error) {
    console.error('Error reading users.json:', error.message);
    res.status(500).json({ message: 'Internal server error' });
  }
};
