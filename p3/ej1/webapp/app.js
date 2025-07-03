const express = require('express');
const mysql = require('mysql');
const path = require('path');
const app = express();

app.use(express.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, 'public')));
app.set('view engine', 'pug');
app.set('views', path.join(__dirname, 'views'));

app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'views', 'index.html'));
});

app.post('/db', (req, res) => {
    const username = req.body.username;
    const hostname = req.body.hostname;
    const password = req.body.password;
    const database = req.body.database;
    const userId = req.body.userId;
    const courseId = req.body.courseId;
    const db_uri = "mysql://"+username+"@"+hostname+":3306/"+database;

    var connection = mysql.createConnection({
      host     : hostname,
      user     : username,
      password : password,
      database : database
    });

    connection.connect(function(error) {
        const data = {
            courseId: courseId,
            height: "475px",
            dburi: db_uri,
            result: " FAILED",
            color: "red",
            username: connection.config.user,
            userId: userId
        };
    
        if(!error) {
	        data.result = " OK";
	        data.color = "green";
        } else {
            data.result = " FAILED ("+error+")";
        }
        
        connection.end();
	    res.render('db', data);
    });
});

app.listen(80, function () {
    console.log('Node.js webapp listening on port 80!');
});
