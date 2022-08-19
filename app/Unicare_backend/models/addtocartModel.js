const mongoose = require('mongoose')

//creating table for customers
const addtocartSchema = new mongoose.Schema({
    userid : {type:String}, 
    productid :{type:String},
})

//exporting customer from db
module.exports = mongoose.model('Addtocart',addtocartSchema);