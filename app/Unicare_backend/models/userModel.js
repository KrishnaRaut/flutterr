const mongoose = require('mongoose')

//creating table for customers
const userSchema = new mongoose.Schema({
    username : {type:String, default:null}, 
    email :{type:String, default:null,
    required: 'Email address is required',
    match: [/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/, 'Please fill a valid email address']},
    password:{type:String, default:null},

   
})

//exporting customer from db
module.exports = mongoose.model('User',userSchema)