const mongoose = require('mongoose')

//creating table for customers
const doctorSchema = new mongoose.Schema({
    doctorname : {type:String,default:null}, 
    doctorspeciality:{type:String, default:null},
    doctorhospital:{type:String,default:null},
    doctorimage:{type:String,default:null},
})

//exporting customer from db
module.exports = mongoose.model('Doctor',doctorSchema)