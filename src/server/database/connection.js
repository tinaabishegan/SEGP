const mysql = require('mysql');

// Create a connection pool
const pool = mysql.createPool({
  connectionLimit: 10, // adjust the limit based on your requirements
  host: 'localhost',
  database: 'zen_app',
  user: 'abi',
  password: 'Lol@1234',
  timezone: 'Asia/Kuala_Lumpur'
});

// Export the pool for reuse in other modules
module.exports = pool;
