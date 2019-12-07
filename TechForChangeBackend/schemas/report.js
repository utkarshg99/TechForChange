var mongoose = require('mongoose');
var Schema = mongoose.Schema;
var report = new Schema({
    _id: mongoose.Schema.Types.ObjectId,
    verify: Boolean,
    email: String,
    name: String,
    age:  { type: Number, default: 18 },
    gender:  { type: String, default: 'Not Specified' },

});

module.exports = mongoose.model('Report', report);