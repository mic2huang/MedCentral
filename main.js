/***************************************************************************
**  CS361: MedCentral Database
**  Contributors: Adam Clayman, Ricardo Cousins, Thuong Michelle Huynh
**                Rachel Schlick, and Hao-yuan Tung 
**  Date: November 26, 2019
****************************************************************************/

var express = require('express');
var mysql = require('./dbcon.js');

var app = express();
app.use(express.static(__dirname + '/public'));
var handlebars = require('express-handlebars').create({defaultLayout:'main'});
var bodyParser = require('body-parser');

app.use(bodyParser.urlencoded({ extended:false }));
app.use(bodyParser.json());

app.engine('handlebars', handlebars.engine);
app.set('view engine', 'handlebars');
app.set('port', process.argv[2]);
app.set('mysql', mysql);

/*****************************************************************************
**  List here the pages that will require js
*****************************************************************************/

app.get('/', function(req,res){
	res.render('/Login/login');
});



/******************************************************************************
**  Errors
******************************************************************************/

	
app.use(function(req,res){
	res.status(404);
	res.render('404');
});

app.use(function(err, req, res, next){
	console.error(err.stack);
	res.status(500);
	res.render('500');
});

/******************************************************************************
**  Console logs
******************************************************************************/

app.listen(app.get('port'), function(){
	console.log('Express started on http://flip3.engr.oregonstate.edu:' + app.get('port') + '; press Ctrl-C to terminate.');
});
