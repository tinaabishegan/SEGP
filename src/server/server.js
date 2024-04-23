const express = require('express');
const { config } = require('dotenv');
const { parsed } = config();
const appRoutes = require('./routes/routes.js');
const cors = require('cors');
const session = require('express-session');
const { NIL } = require('uuid');
const multer  = require('multer');  
const bodyParser = require('body-parser');

const app = express();

// Parsing JSON bodies (as sent by API clients)
app.use(express.json());


app.use(cors({
    origin: 'http://localhost:8000',
    methods: 'GET,HEAD,PUT,PATCH,POST,DELETE',
    allowedHeaders: ['Content-Type', 'Authorization'],
    credentials: true
  }));

// Session configuration
app.use(session({
  secret: 'your-secret-key', // replace with your secret key
  resave: false,
  saveUninitialized: true,
  cookie: { secure: false } // use secure: true for HTTPS, false for HTTP
}));

app.use((req, res, next) => {
  // Check if the user object is not set in the session
  if (!req.session.user) {
    // Set default user object with empty userName and userId
    req.session.user = {
      userName : null,
      userId : null,
    };
  }

  next();
});


app.use('/api', appRoutes);

app.use('/images', express.static('images'));


app.listen(parsed.PORT_SERVER, () => {
    console.log(`Server started on http://${parsed.HOST}:${parsed.PORT_SERVER}`);
});