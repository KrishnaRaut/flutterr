const mongoose = require('mongoose')

//creating table for customers
const productSchema = new mongoose.Schema({
    productname : {type:String, default:null}, 
    productprice:{type:String, default:null},
    productimage:{type:String, default:null},
})

//exporting customer from db
module.exports = mongoose.model('Product', productSchema)