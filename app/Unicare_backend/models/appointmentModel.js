const mongoose = require('mongoose')

//creating table for customers
const appointmentSchema = new mongoose.Schema({
    userid:{type:String},
    doctorid : {type:String}, 
    appointmentname :{type:String,default:null},
    appointmenttime :{type:String, default:null},
    appointmentdate :{type:String, default:null},
})

//exporting customer from db
module.exports = mongoose.model('appointment',appointmentSchema);