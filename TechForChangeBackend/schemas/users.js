var mongoose = require('mongoose');
var Schema = mongoose.Schema;
var user = new Schema({
    _id: mongoose.Schema.Types.ObjectId,
    verify: Boolean,
    email: String,
    pass: String,
    name: String,
    age:  { type: Number, default: 0 },
    gender:  { type: String, default: 'Not Specified' },
    phone:  { type: String, default: 'Not Specified' }
});

module.exports = mongoose.model('User', user);