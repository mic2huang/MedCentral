var express = require('express');
var bodyParser = require('body-parser');

var connection = require('./config');
var app = express();
//app.use(express.static('.'));

var authenticateController = require('./controllers/authenticate-controller');
var registerController = require('./controllers/register-controller');

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.get('/', function(req, res) {
  res.sendFile(__dirname + '/' + 'views/index.html');
});

app.get('/login', function(req, res) {
  res.sendFile(__dirname + '/' + 'views/index.html');
});

/* route to handle login and registration */
app.post('/api/register', registerController.register);
app.post('/api/authenticate', authenticateController.authenticate);

app.post('/register', registerController.register);
app.post('/authenticate', authenticateController.authenticate);
app.listen(3000);
