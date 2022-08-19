const mongoose = require('mongoose')

//creating table for customers
const checkoutSchema = new mongoose.Schema({
    userid : {type:String,default:null}, 
    price :{type:String, default:null},
    creditcarddetails :{type:String,default:null},
    address:{type:String,default:null},
})

//exporting customer from db
module.exports = mongoose.model('Checkouttable',checkoutSchema)