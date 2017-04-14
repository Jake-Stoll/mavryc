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


function viewallFlights() {
    Flight.find({ 'flight.route.origin.city': origin }, function (err, flight) {
        if (err) return handleError(err);
        console.log(flight)
        return flight
    })
}


function searchFlights(req) {
    //Define param variables we will use for searching
    var origin = req.body.origincity
    var destination = req.body.destinationcity
    var min = req.body.min
    var max = req.body.max

    //Search for flights only by Origin City
     if (destination == '' & min == '' & max == ''){
        Flight.find({ 'flight.route.origin.city': origin }, function (err, flight) {
            if (err) return handleError(err);
        console.log(flight)
        return flight
        })
     }
     //Search for flights only by Destination City
     if (origin == '' & min == '' & max == ''){
        Flight.find({ 'flight.route.destination.city': destination }, function (err, flight) {
            if (err) return handleError(err);
        console.log(flight)
        return flight
        })
     }
     //Search for flights only by min Price
    if (destination == '' & origin == '' & max == ''){
        Flight.find({ 'flight.cost': { $gt: min} }, function (err, flight) {
            if (err) return handleError(err);
        console.log(flight)
        return flight
        })
    }
    //Search for flights only by max Price
     if (destination == '' & min == '' & origin == ''){
         Flight.find({ 'flight.cost': { $lt: max} }, function (err, flight) {
            if (err) return handleError(err);
        console.log(flight)
        return flight
        })
     }
    //Search for Flights by Origin and Destination
     if(min == '' & max == ''){
         Flight.find({ 'flight.route.origin.city': origin, 'flight.route.destination.city': destination }, function (err, flight) {
            if (err) return handleError(err);
        console.log(flight)
        return flight
        })
     }
    //Search for Flights by Origin and Min
     if(destination == '' & max == ''){
         Flight.find({ 'flight.route.origin.city': origin, 'flight.cost': { $gt: min} }, function (err, flight) {
            if (err) return handleError(err);
            console.log(flight)
            return flight
        })
     }
    //Search for Flights by Origin and max
     if(destination == '' & min == ''){
         Flight.find({ 'flight.route.origin.city': origin, 'flight.cost': { $lt: max} }, function (err, flight) {
            if (err) return handleError(err);
            console.log(flight)
            return flight
        })
     }
    //Search for Flight by Destination and Min
     if(origin == '' & max == ''){
       Flight.find({ 'flight.route.destination.city': destination, 'flight.cost': { $gt: min} }, function (err, flight) {
            if (err) return handleError(err);
            console.log(flight)
            return flight
        })  
     }
    //Search for flight by Destination and max
     if(origin == '' & min == ''){
         Flight.find({ 'flight.route.destination.city': destination, 'flight.cost': { $lt: max} }, function (err, flight) {
            if (err) return handleError(err);
            console.log(flight)
            return flight
        })  
     }
    //Search for flight by Min and Max
     if(origin == '' & destination == ''){
         Flight.find({ 'flight.cost': { $lt: max}, 'flight.cost': { $lt: max} }, function (err, flight) {
            if (err) return handleError(err);
            console.log(flight)
            return flight
        })  
     }
}



module.exports = {
    createFlight:createFlight,
    searchFlights:searchFlights
}

