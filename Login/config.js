var mysql = require('mysql');
// create connection to database
var connection = mysql.createConnection({
  host: 'classmysql.engr.oregonstate.edu',
  user: 'cs361_huynhthu',
  password: '5705',
  database: 'cs361_huynhthu'
});

connection.connect(function(err) {
  if (err) {
    return console.error('error: ' + err.message);
  }

  console.log('Connected to the MySQL server.');
});
module.exports = connection;
