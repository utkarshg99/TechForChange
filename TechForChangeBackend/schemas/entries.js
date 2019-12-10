var mongoose = require('mongoose');
var Schema = mongoose.Schema;
var entry = new Schema({
    _id: mongoose.Schema.Types.ObjectId,
    status: Boolean,
    fname: String,
    uid: String,
    uidx: String,
    dest: String,
    gender: String,
    weight: Number,
    height: Number,
    symptoms: {type: String, default: ""},
    remarks: {type: String, default: ""},
    date: String,
    final: {type: String, default: ""},
    bmi: Number
});

module.exports = mongoose.model('Entry', entry);