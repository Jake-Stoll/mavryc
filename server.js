var express = require('express')
const bodyParser= require('body-parser')
var app = express()

app.use(bodyParser.urlencoded({extended: true}))


//Server Handlers 
app.get('/', (req, res) => {
    res.sendFile(__dirname + '/index.html')
})

app.post('/users', (req, res) => {
  db.collection('users').save(req.body, (err, result) => {
    if (err) return console.log(err)

    console.log('saved to database')
    res.redirect('/')
  })
})


const MongoClient = require('mongodb').MongoClient

var db

MongoClient.connect('mongodb://jake.stoll:mavryc@ds131340.mlab.com:31340/heroku_212w40nv', (err, database) => {
  if (err) return console.log(err)
  db = database
  app.listen(3000, () => {
    console.log('listening on localhost:3000. May the Node be with you!')
  })
})