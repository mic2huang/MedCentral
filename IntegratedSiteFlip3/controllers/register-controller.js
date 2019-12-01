//var Cryptr = require('cryptr');
var express = require('express');
var connection = require('./../config');
// cryptr = new Cryptr('myTotalySecretKey');

module.exports.register = function (req, res) {
  var username = req.body.username;
  connection.query('SELECT * FROM user WHERE username = ?', username, function (
    error,
    rows
  ) {
    if (error) {
      return res.status(500).json({
        message: 'there are some error with query'
      });
    }
    if (rows.length <= 0) {
      //var encryptedString = cryptr.encrypt(req.body.password);
      var user = {
        username: req.body.username,
        email: req.body.email,
        //password: encryptedString,
        password: password,
        type: req.body.type
      };
      connection.query('INSERT INTO user SET ?', user, function (
        error,
        results,
        fields
      ) {
        if (error) {
          return res.status(500).json({
            message: 'there are some error with query'
          });
        } else {
          return res.status(200).json({
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
  });
};
