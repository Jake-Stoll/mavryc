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
  app.listen(3000, () => {
    console.log('listening on 3000')
  })
})

//Function to use body parser to gain values from forms. 
app.use(bodyParser.urlencoded({extended: true}))

//Sets Routing for Server

//Get Functions
/////////////////////////////////////////
//Function to load homepage
app.get('/', (req, res) => {
    db.collection('users').find().toArray((err, result) => {
        if (err) return console.log(err)
        // renders index.ejs
        res.render('index.ejs', {users: result})
    })
})


//Post Functions
/////////////////////////////////////////
//Function to post new user
app.post('/users', (req, res) => {
  db.collection('users').save(req.body, (err, result) => {
    if (err) return console.log(err)

    console.log('saved to database')
    res.redirect('/')
  })
})
