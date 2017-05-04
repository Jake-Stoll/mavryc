// app/models/user.js
// load the things we need
var mongoose = require('mongoose');
var bcrypt   = require('bcrypt-nodejs');

// define the schema for our user model -- This schema will change after authenticion is complete*******
var userSchema = mongoose.Schema({

    local              : {
        firstname      : String,
        lastname       : String,
        email          : String,
        password       : String,
        phone          : Number,
        birthday       : Date,
        facebookid     : String,
        facebooktoken  : String,
        token          : Object,
        favoriteFlights: Array,
        dateCreate     : Date,
    },
});

// methods ======================
// generating a hash
userSchema.methods.generateHash = function(password) {
    return bcrypt.hashSync(password, bcrypt.genSaltSync(8), null);
};

// checking if password is valid
userSchema.methods.validPassword = function(password) {
    return bcrypt.compareSync(password, this.local.password);
};

// create the model for users and expose it to our app
module.exports = mongoose.model('User', userSchema);
