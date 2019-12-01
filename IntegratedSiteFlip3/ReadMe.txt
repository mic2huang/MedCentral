Helpful webpages for a review of key material from CS 290 and/or CS340 to help get this web application built, and up and running using the steps below:
http://eecs.oregonstate.edu/ecampus-video/CS290/core-content/tools-and-overview/Using-Node-on-the-Engineering-Servers.html

http://eecs.oregonstate.edu/ecampus-video/CS290/core-content/hello-node/hello-node.html
More specifically:
http://eecs.oregonstate.edu/ecampus-video/CS290/core-content/hello-node/welcome-to-node.html



Steps to run this test version of MedCentral are below. This test version of MedCentral connects to the mysql database instance assigned to cousinsr. Credentials for that database are in the dbcon.js file.

NOTE: This test version of MedCentral uses a hardcoded port number that is specified in line 26 of the main.js file. If someone already started a process for this web application using that port (4174), then you may get an error when trying to use the same port number. In that case, update the hardcoded value to use a different port number and use an appropriate site URL (step 7) with that port number.



Step 1:
Connect to OSU VPN.


Step 2:
Copy all files in this folder to a folder in OSU Flip 3 (you can use other OSU Flip servers, but note that the website address must be modified accordingly).


Step 3:
SSH into OSU Flip 3 command prompt


Step 4:
Change the directory to the folder you created in step 2.


Step 5:
Type and enter the following command to install the required NPM modules:
npm install

After you run the command, wait for a moment to let the NPM modules truly finish installing. This step may not be required and is a suggestion to avoid strange behavior. For the first time NPM modules are installed, you may notice that the node_modules folder appears to be empty even though installation was successful. Sometimes it takes a little while for that folder to be filled.


Step 6:
To start and run this website forever, use the following command:
./node_modules/forever/bin/forever start main.js

To start and run this website as a temporary process (exists only as long as you are SSHed into OSU Flip), use the following command:
node main.js


Step 7:
Assuming the site process started without issue, use the URLs below to access the pages of the website.
If you used a different port number as mentioned in the note above, then make sure you update the port number used in the URLs mentioned below.

The landing page (the login page)
http://flip3.engr.oregonstate.edu:4174/

If the login page does not work (it did not as of 11/29/2019), use the following URL to reach a home page in the site. Change the userId value in the URL to see the homepage for different users.
http://flip3.engr.oregonstate.edu:4174/home?userId=1
