var mysql = require('mysql');
// create connection to database
var connection = mysql.createConnection({
  host: 'classmysql.engr.oregonstate.edu',
  user: 'cs361_claymana',
  password: '2032',
  database: 'cs361_claymana'
});

connection.connect(function(err) {
  if (err) {
    return console.error('error: ' + err.message);
  }

  console.log('Connected to the MySQL server.');
});
module.exports = connection;
