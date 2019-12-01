module.exports = function(){
	var express = require('express');
	var router = express.Router();

	// route to render the home page
	router.get('/', function(request, response){
		var userId = request.query.userId;
		var mysql = request.app.get('mysql');
		
		// Attempt to find user info and then render the user home page.
		module.exports.getUserInfo(userId, mysql, function(err, userInfo) {
			var context = {};
			// Check if an error or no information was found when using
			// the given userId to search for user info.
			if (err || userInfo[0] == null) {
				context.errorMessage = "Unable to find user information. Please try again.";
				response.render('error', context);
			// Attempt to render the page using the user info.
			} else {
				context.userId = userId;
				context.username = userInfo[0].username;
				
				// Try to render the home page.
				module.exports.renderHome(userId, context, response);
			}
		});
	});
  
	return router;
}();

/***************************************************************************************************
** Function name: getUserInfo
** Description: This function retrieves user information using a provided userId.
***************************************************************************************************/
module.exports.getUserInfo = function getUserInfo(userId, mysql, callback) {
	var sql = "SELECT username FROM user WHERE id= ?";
	var inserts = [userId];

	mysql.pool.query(sql, inserts, function(error, results, fields){
		if(error){
			callback(error, null);
			return;
		}
		callback(null, results);
	});
};

/***************************************************************************************************
** Function name: renderHome
** Description: This function renders the page using the user info contained in the context object.
***************************************************************************************************/
module.exports.renderHome = function renderHome(userId, context, response) {
	response.render('home', context);
};