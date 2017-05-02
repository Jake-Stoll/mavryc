//Get all the stuff we nedd 
//Get access to the flight model
var User = require('../../models/user');
var jwt = require('jwt-simple');
//Variables required for token decoding
var decodesecret = 'alwaysflyukko';


//---------------------------------------------------
//Methods
//---------------------------------------------------


//Function to compare client token with server token for authenticated calls
function compareTokens (email, token) {
    //Name Parameters
    var token = token;
    var email = email;

    //Find user by email
    User.findOne({ 'local.email' :  email }, function(err, user) {
        // if there are any errors, return the error
            if (err)
                return(err);

            // Find user with that email
            if (user) {
               //Place code here to check if decoded token matched user stored tokens
                //decode token passed back from client
                var decodedToken = jwt.decode(token, decodesecret);
            
                //Find Users token 
                var userToken = user.local.token
                

                //Compare tokens
                console.log(userToken, decodedToken)
                if ( decodedtoken == userToken){
                    console.log("authentication success")
                    return(success)
                } else {
                    console.log("Token Auth Failed")
                    return(req.flash('failled', 'Token Authentication Failed'));
                }
                
            } else {
                console.log("No user with that email")
                return(req.flash('failled', 'That user does not exist'));
            }
    })
}

//Function to add Favorite flight
function addFlightFavorites(req) {
    var originCity = req.body.originCity
    var destinationCity = req.body.destinationCity
    var email = req.body.email

    //Verify the user has a token
    function getFlightFavorites(req) {


    User.findOne({ 'local.email' :  email }, function(err, user) {
        if (err)
            return(err)
        // Find user with that email
            if (user) {
               //Get their current fav object
                if (user.local.favoriteFlights != undefined){
                    flightFavorites = user.local.favoriteFlights
                    //Add new flight to flight favorites
                    flightFavorites.push({ originCity: originCity, destinationCity: destinationCity });
                    user.save(function(err) {
                        console.log("About to save")
                        if (err)
                            throw err;
                    });
                    console.log("Added flight to favorite flights array")
                } else {
                    flightFavorites = []
                    //Add new flight to flight favorites
                    flightFavorites.push({ originCity: originCity, destinationCity: destinationCity });
                    console.log("Added flight to favorite flights array")
                }
            } else {
                console.log("No user with that email")
                return("Failed!!!!! No User with that email");
            }
    })
    console.log("FInished adding new flight to favorites.")
}

function getFlightFavorites(req) {
    //Get the data from the req and save it for what we need it.
    var email = req.body.email
    var token = req.body.token

    //Verify that the User has Token Authentication
    compareTokens(email, token)

    //Get the favorite flight array of objects
    User.findOne({ 'local.email' :  email }, function(err, user) {
        if (err)
            return(err)
        // Find user with that email
            if (user) {
               //Get their current fav object
                if (user.local.favoriteFlights != undefined){
                    var flightFavorites = user.local.favoriteFlights
                    console.log(flightFavorites)
                    return(flightFavorites)
                } else {
                    console.log("NOt finiding their object")
                    var flightFavorites = []
                    console.log(flightFavorites)
                    return(flightFavorites)
                }
            } else {
                console.log("No user with that email")
                return("Failed!!!!! No User with that email");
            }
    })



}





module.exports = {
    compareTokens:compareTokens,
    addFlightFavorites:addFlightFavorites,
    getFlightFavorites:getFlightFavorites
}

