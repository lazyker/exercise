var mongoose = require('mongoose');
var Schema = mongoose.Schema;
var autuIncrement = require('mongoose-auto-increment');

var BoardSchema = new Schema({
    title : String,
    content : String,
    creted_at : {
        type : Date,
        default : Date.now()
    }
});

BoardSchema.plugin(autuIncrement.plugin, {model : 'board', field : 'id', startAt : 1});
module.exports = mongoose.model('board', BoardSchema);