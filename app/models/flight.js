// app/models/flight.js
// load the things we need
var mongoose = require('mongoose');


// define the schema for our flight model
var flightSchema = mongoose.Schema({

    flight              : {
        past            : Boolean,
        route           : {
            origin          : {
                city        : String,
                state       : String,
                zipcode     : String,
                airportcode : String
            },
            destination     : {
                city        : String,
                state       : String,
                zipcode     : String,
                airportcode : String
            },
            distance        : Number,
        },
        departuretime   : String,
        arrivaltime     : String,
        cost            : Number
    },
});


// create the model for users and expose it to our app
module.exports = mongoose.model('Flight', flightSchema);
