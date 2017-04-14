// config/auth.js

// expose our config directly to our application using module.exports so we can use it!
module.exports = {

    //Need to write a function to offer different callbackURL based on dev environment (testing vs. production)
    'facebookAuth' : {
        'clientID'      : '1920729421510515', // FB App ID
        'clientSecret'  : '4466085a1dd8fa99d46a8a02d20a424a', // FB App Secret
        'callbackURL'   : 'https://mavryc.herokuapp.com/auth/facebook/callback'
    }
};


