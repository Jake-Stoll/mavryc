// config/auth.js

// expose our config directly to our application using module.exports so we can use it!
module.exports = {

    'facebookAuth' : {
        'clientID'      : '1920729421510515', // FB App ID
        'clientSecret'  : '4466085a1dd8fa99d46a8a02d20a424a', // FB App Secret
        'callbackURL'   : 'http://localhost:3000/auth/facebook/callback'
    }
};
