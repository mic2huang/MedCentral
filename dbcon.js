var mysql = require('mysql');
var pool = mysql.createPool({
  connectionLimit : 10,
  host            : 'classmysql.engr.oregonstate.edu',
  user            : 'cs361_claymana',
  password        : '2032',
  database        : 'cs361_claymana'
});
module.exports.pool = pool;
