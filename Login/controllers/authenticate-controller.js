//var Cryptr = require('cryptr');
//cryptr = new Cryptr('myTotalySecretKey');

var connection = require('./../config');
module.exports.authenticate = function(req, res) {
  var username = req.body.username;
  var password = req.body.password;

  connection.query(
    'SELECT * FROM user WHERE username = ?',
    [username],
    function(error, results, fields) {
      if (error) {
        return res.status(500).json({
          message: 'there are some error with query'
        });
      } else {
        if (results && results.length > 0) {
          //decryptedString = cryptr.decrypt(results[0].password);
          //if (password == decryptedString) {
          if (password == results[0].password) {
            return res.status(200).json({
              message: 'successfully authenticated'
            });
          } else {
            return res.status(403).json({
              message: 'Username and password does not match'
            });
          }
        } else {
          connection.end();
          return res.status(403).json({
            message: 'Username does not exits'
          });
        }
      }
    }
  );
};
