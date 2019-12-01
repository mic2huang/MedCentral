var Cryptr = require('cryptr');
var express = require('express');
var connection = require('./../dbcon');
// cryptr = new Cryptr('myTotalySecretKey');

module.exports.register = function(req, res) {
  var username = req.body.username;
  connection.query(
    'SELECT * FROM accounts WHERE username = ?',
    username,
    function(error, rows) {
      if (error) {
        return res.status(500).json({
          message: 'there are some error with query'
        });
      }
      if (!rows.length) {
        var encryptedString = cryptr.encrypt(req.body.password);
        var user = {
          username: req.body.username,
          email: req.body.email,
          password: encryptedString,
          type: req.body.type
        };
        connection.query('INSERT INTO accounts SET ?', user, function(
          error,
          results,
          fields
        ) {
          if (error) {
            return res.status(500).json({
              message: 'there are some error with query'
            });
          } else {
            return res.status(200).res.json({
              username: user.username,
              email: user.email,
              type: user.type,
              message: 'user registered sucessfully'
            });
          }
        });
      } else {
        connection.end();
        return res.status(400).send('Username already exists');
      }
    }
  );
};
