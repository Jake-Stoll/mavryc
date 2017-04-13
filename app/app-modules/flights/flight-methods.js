//Get all the stuff we nedd 
//Get access to the flight model
var Flight = require('../../models/flight');

//---------------------------------------------------
//Methods
//---------------------------------------------------
function createFlight(req) {
    var newFlight = new Flight();
    console.log(newFlight.flight)
    // set the user's local credentials
    newFlight.flight.past = req.body.past
    newFlight.flight.route.origin.city = req.body.flightorigincity;
    newFlight.flight.route.origin.state = req.body.flightoriginstate;
    newFlight.flight.route.origin.zipcode = req.body.flightoriginzipcode;
    newFlight.flight.route.origin.airportcode = req.body.flightoriginairportcode;
    newFlight.flight.route.destination.city = req.body.flightdestinationcity
    newFlight.flight.route.destination.state = req.body.flightdestinationstate
    newFlight.flight.route.destination.zipcode = req.body.flightdestinationzipcode
    newFlight.flight.route.destination.airportcode = req.body.flightdestinationairportcode
    newFlight.flight.route.distance = req.body.flightdistance
    newFlight.flight.departuretime = req.body.departuretime
    newFlight.flight.arrivaltime = req.body.arrivaltime
    newFlight.flight.cost = req.body.cost


    // save the user
    newFlight.save(function(err) {
        console.log("About to save")
        if (err)
            throw err;
        return done(null, newFlight);
    });
}



module.exports = {
    createFlight:createFlight
}

