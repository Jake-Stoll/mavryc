const express = require('express')
const bodyParser= require('body-parser')
const app = express()
const passport = require('passport')
const LocalStrategy = require('passport-local').Strategy
const MongoClient = require('mongodb').MongoClient

//Use EJS
app.set('view engine', 'ejs')


//Connect to MongoDB
var db

MongoClient.connect('mongodb://stja1102:jake0201@ds145329.mlab.com:45329/mavryc', (err, database) => {
  if (err) return console.log(err)
  db = database
  //Creates Connection to Server at Port 3000
  var port = process.env.PORT || 3000;
  app.listen(port, () => {
    console.log('listening on 3000')
  })
})
//Function to use body parser to gain values from forms. 
app.use(bodyParser.urlencoded({extended: true}))

//Sets Routing for Server

//Get Functions to Render Files
///////////////////////////////////////////////////////
//Function to Get EJS Page to add new Users
app.get('/create-user-page', (req, res) => {
  res.render('submit-user.ejs')
})
//Function to Get EJS Page to add new FLights
app.get('/create-flight-page', (req, res) => {
  res.render('submit-flight.ejs')
})
//Function to get EJS Page to search for user
app.get('/search', (req, res) => {
  res.render('search.ejs')
})
//Function to get EJS Page to delete for user
app.get('/delete-user', (req, res) => {
  res.render('delete-user.ejs')
})
//Function to get EJS Page to Update User 
app.get('/update-user', (req, res) => {
  res.render('update-user.ejs')
})
//FUnction to get EJS Page to Search for flights
app.get('/search-flights', (req, res) => {
  res.render('search-flights.ejs')
})
//FUnction to get EJS Page to Search for flights
app.get('/flights', (req, res) => {
  res.render('flight-search.ejs')
})
//Functon to get EJS page to login
app.get('/login', (req, res) => {
  res.render('login.ejs')
})



//Get Functions to Get Data
///////////////////////////////////////////////////////
//Function to Get Users Data
app.get('/get-user', (req, res) => {
    db.collection('users').find().toArray((err, result) => {
        if (err) return console.log(err)
        // renders index.ejs
        res.send(result[0]);
        console.log("Just sent data")    
    })
})

//Fuction to get Flight Data
app.get('/get-flight', (req, res) => {
    db.collection('flights').find().toArray((err, result) => {
        if (err) return console.log(err)
        // renders index.ejs
        res.send(result[0]);
        console.log("Just sent data")    
    })
})



//Post Functions to add Data
/////////////////////////////////////////
//Function to post new user
app.post('/add-user', (req, res) => {
  db.collection('users').save(req.body, (err, result) => {
    if (err) return console.log(err)
    console.log('saved to database')
  })
  var email = req.body
    email = email.email
    console.log(email)
    db.collection('users').find({"email": email}).toArray((err, result) => {
        if (err) return console.log(err)
        var result = res.send(result);
        console.log(result)
    })
})
//Functon to post a new flights
app.post('/add-flight', (req, res) => {
  db.collection('flights').save(req.body, (err, result) => {
    if (err) return console.log(err)
    console.log('saved to database')
  })
})



//
//Function to find Individual User
app.post('/find-user', (req, res) => {
    var email = req.body
    email = email.email
    console.log(email)
    db.collection('users').find({"email": email}).toArray((err, result) => {
        if (err) return console.log(err)
        var result = res.send(result);
        console.log(result)
    })
})



//Function to Delete Individual User
app.post('/delete-user', (req, res) => {
    var email = req.body
    email = email.email
    console.log(email)
    db.collection('users').remove({"email": email})
    console.log("User Deleted")
})

//Function Search for User and Update
app.post('/find-user', (req, res) => {
    var email = req.body
    email = email.email
    console.log(email)
    db.collection('users').find({"email": email}).toArray((err, result) => {
        if (err) return console.log(err)
        var result = res.send(result);
        console.log(result)
    })
    
})



//Flight Searches

//Function to search for flights based on Origin City
app.post('/find-flight-origin', (req, res) => {
    var origin = req.body.origin
    db.collection('flights').find({"origin": origin}).toArray((err, result) => {
        if (err) return console.log(err)
        var result = res.send(result);
        console.log(result)
    })
})

//Function to search for flights based on Destination City
app.post('/find-flight-destination', (req, res) => {
    var destination = req.body.destination
    db.collection('flights').find({"destination": destination}).toArray((err, result) => {
        if (err) return console.log(err)
        var result = res.send(result);
        console.log(result)
    })
})

//Function to search for flights based on Price
app.post('/find-flight-price', (req, res) => {
    var min = req.body.min
    var max = req.body.max
    db.collection('flights').find( { $and: [ { "cost": { $gte: min } }, { "cost": { $lte: max } } ] }).toArray((err, result) => {
        if (err) return console.log(err)
        var result = res.send(result);
        console.log(result)
    })
})



//Flight Search
app.post('/flight-search', (req, res) => {
     var origin = req.body.origin
     var destination = req.body.destination
     var min = req.body.min
     var max = req.body.max
     
     //Search for flights only by Origin City
     if (destination == '' & min == '' & max == ''){
         console.log("Search for flights only by Origin City")
     }
     //Search for flights only by Destination City
     if (origin == '' & min == '' & max == ''){
         console.log("Search for flights only by Destination City")
     }
     //Search for flights only by min Price
     if (destination == '' & origin == '' & max == ''){
         console.log("Search for flights only by Min Price")
     }
     //Search for flights only by max Price
     if (destination == '' & min == '' & origin == ''){
         console.log("Search for flights only by max price")
     }
     //Search for Flights by Origin and Destination
     if(min == '' & max == ''){
         console.log("Search for flights by Origin City and Destination City")
     }
     //Search for Flights by Origin and Min
     if(destination == '' & max == ''){
         console.log("Search for Flights by Origin and Min")
     }
     //Search for Flights by Origin and max
     if(destination == '' & min == ''){
         console.log("Search for Flights by Origin and Max")
     }
     //Search for Flight by Destination and Min
     if(origin == '' & max == ''){
         console.log("Search for Flight by Destination and Min")
     }
     //Search for flight by Destination and max
     if(origin == '' & min == ''){
         console.log("Search for Flight by Destination and Max")
     }
     //Search for flight by Min and Max
     if(origin == '' & destination == ''){
         console.log("Search for Flight by Destination and Origin")
     }
})




app.post('/login', (req, res) => {
    var email = req.body.email
    var pass = req.body.password
    // passport/login.js
    passport.use('login', new LocalStrategy({
        passReqToCallback : true
    },
    function(req, username, password, done) { 
        // check in mongo if a user with username exists or not
        User.findOne({ 'email' :  email }, 
        function(err, user) {
            // In case of any error, return using the done method
            if (err)
            return done(err);
            // Username does not exist, log error & redirect back
            if (!user){
            console.log('User Not Found with username '+email);
            return done(null, false, 
                    req.flash('message', 'User Not found.'));                 
            }
            // User exists but wrong password, log the error 
            if (!isValidPassword(user, password)){
            console.log('Invalid Password');
            return done(null, false, 
                req.flash('message', 'Invalid Password'));
            }
            // User and password both match, return user from 
            // done method which will be treated like success
            return done(null, user);
        }
        );
    }));
    
})



//Authentication 

// app.post('/login',
//   passport.authenticate('local'),
//   function(req, res) {
//     // If this function gets called, authentication was successful.
//     // `req.user` contains the authenticated user.
//     res.redirect('/users/' + req.user.username);
//   });



