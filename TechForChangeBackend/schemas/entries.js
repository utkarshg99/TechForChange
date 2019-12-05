var mongoose = require('mongoose');
var Schema = mongoose.Schema;
var entry = new Schema({
    _id: mongoose.Schema.Types.ObjectId,
    status: Boolean,
    fname: String,
    uid: String,
    dest: String
});

module.exports = mongoose.model('Entry', entry);