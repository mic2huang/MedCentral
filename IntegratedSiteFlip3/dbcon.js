var mysql = require('mysql');
var pool = mysql.createPool({
  connectionLimit : 10,
  host            : 'classmysql.engr.oregonstate.edu',
  user            : 'cs361_cousinsr',
  password        : 'KXKQipIlOoJTdp67',
  database        : 'cs361_cousinsr'
});

module.exports.pool = pool;
