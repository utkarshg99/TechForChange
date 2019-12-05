var mongoose = require('mongoose');
var Schema = mongoose.Schema;
var user = new Schema({
    _id: mongoose.Schema.Types.ObjectId,
    verify: Boolean,
    email: String,
    pass: String,
    name: String
});

module.exports = mongoose.model('User', user);