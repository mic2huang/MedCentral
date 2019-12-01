/***************************************************************************
**  CS361: MedCentral Database
**  Contributors: Adam Clayman, Ricardo Cousins, Thuong Michelle Huynh
**                Rachel Schlick, and Hao-yuan Tung 
**  Date: November 26, 2019
****************************************************************************/

var express = require('express');
var path = require('path');
var mysql = require('./dbcon.js');

var app = express();
app.use(express.static(__dirname + '/public'));
var handlebars = require('express-handlebars').create({defaultLayout:'main'});
var bodyParser = require('body-parser');

var authenticateController = require('./controllers/authenticate-controller');
var registerController = require('./controllers/register-controller');

app.use(bodyParser.urlencoded({ extended:false }));
app.use(bodyParser.json());

app.set('views', path.join(__dirname, 'views'));
app.engine('handlebars', handlebars.engine);
app.set('view engine', 'handlebars');
app.set('port', 4174);
app.set('mysql', mysql);

// Render handlebar for the website landing page (the login page).
app.get('/', function(req,res){
	res.sendFile(__dirname + '/' + 'index.html');
});

// Render handlebar for the website logout page.
app.get('/logout', function(req,res){
	res.render('logout');
});



/*****************************************************************************
**  List here the pages that will require js
*****************************************************************************/
app.use('/home', require('./home.js'));

/******************************************************************************
**  Errors
******************************************************************************/

// Render the 404 page if status is 404.
app.use(function(req,res){
	res.status(404);
	res.render('404');
});

// Render the 500 page if status is 500.
app.use(function(err, req, res, next){
	console.error(err.stack);
	res.status(500);
	res.render('500');
});

/* route to handle login and registration */
app.post('/api/register', registerController.register);
app.post('/api/authenticate', authenticateController.authenticate);

app.post('/register', registerController.register);
app.post('/authenticate', authenticateController.authenticate);

/******************************************************************************
**  Console logs
******************************************************************************/

app.listen(app.get('port'), function(){
	console.log('Express started on http://flip3.engr.oregonstate.edu:' + app.get('port') + '; press Ctrl-C to terminate.');
});
