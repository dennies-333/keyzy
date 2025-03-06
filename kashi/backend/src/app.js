const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const authRoutes = require('./routes/authRoutes'); // Importing the auth routes
const guestRoutes = require('./routes/guestRoutes'); // Importing the auth routes
const visitorRoutes = require('./routes/visitorRoutes'); // Importing the auth routes
const tenantRoutes = require('./routes/tenantRoutes'); // Importing the auth routes


const app = express();
const port = process.env.PORT || 5000;

// Middleware
app.use(cors()); // Enable cross-origin requests
app.use(bodyParser.json()); // Parse JSON bodies

// Routes
app.use('/api/auth', authRoutes); // Use the authRoutes for the /api/auth path
app.use('/api/guest', guestRoutes); // Use the authRoutes for the /api/auth path
app.use('/api/visitors', visitorRoutes);
app.use('/api/tenant', tenantRoutes);

// Basic route to test server
app.get('/', (req, res) => {
  res.send('Welcome to the authentication service!');
});

// Start the server
app.listen(port, '0.0.0.0', () => {
  console.log(`Server running at http://0.0.0.0:${port}`);
});
