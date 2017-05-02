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
function compareTokens (req) {
    //Name Parameters
    var token = req.body.token;
    var email = req.body.email;

    //Find user by emai
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






module.exports = {
    compareTokens:compareTokens
}

