const moment = require('moment-timezone');
const { config } = require('dotenv');

config(); // Load environment variables

const targetTimezone = 'Asia/Kuala_Lumpur'; // Replace with your desired timezone
moment.tz.setDefault(targetTimezone);


module.exports = moment;
