var Cryptr = require('cryptr');
cryptr = new Cryptr('myTotalySecretKey');

var connection = require('./../config');
module.exports.authenticate = function(req, res) {
  var username = req.body.username;
  var password = req.body.password;

  connection.query(
    'SELECT * FROM accounts WHERE username = ?',
    [username],
    function(error, results, fields) {
      if (error) {
        return res.status(500).json({
          status: false,
          message: 'there are some error with query'
        });
      } else {
        if (results.length > 0) {
          decryptedString = cryptr.decrypt(results[0].password);
          if (password == decryptedString) {
            return res.status(200).json({
              status: true,
              message: 'successfully authenticated'
            });
          } else {
            return res.status(403).json({
              status: false,
              message: 'Username and password does not match'
            });
          }
        } else {
          return res.status(403).res.json({
            status: false,
            message: 'Username does not exits'
          });
        }
      }
    }
  );
};
