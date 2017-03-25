const express = require('express')
const bodyParser= require('body-parser')
const app = express()
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

//Get Functions
/////////////////////////////////////////
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

//Post Functions
/////////////////////////////////////////
//Function to post new user
app.post('/add-user', (req, res) => {
  db.collection('users').save(req.body, (err, result) => {
    if (err) return console.log(err)
    console.log('saved to database')
  })
})


//Functon to post a new flights
app.post('/add-flight', (req, res) => {
  db.collection('flights').save(req.body, (err, result) => {
    if (err) return console.log(err)
    console.log('saved to database')
  })
})



//Put Functions
/////////////////////////////////////////
//Function to edit user data 
app.put('/edit-user', function (req, res) {
  var query = { "name" : "Juni" }
  var change = { "cuisine": "American (New)" }
  db.collection('users').update(
    query,
    {
      $set: change
    }
  )
})

app.put('/edit-flights', function (req, res) {
  var query = { "name" : "Juni" }
  var change = { "cuisine": "American (New)" }
  db.collection('users').update(
    query,
    {
      $set: change
    }
  )
})





//Function to edit flight data


