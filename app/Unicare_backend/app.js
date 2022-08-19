//to start a server we require express
const express = require ('express');
const cors = require ('cors');

const mongoose = require("mongoose");

// folder name and file name
require('./dbConnection/db')

// importing routes here
const userRoute = require('./routes/userRoute.js');
const doctorRoute = require('./routes/doctorRoute.js');
const productRoute = require('./routes/productRoute.js');
const addtocartRoute = require('./routes/addtocartRoute.js');
const appointmentRoute = require('./routes/appointmentRoute.js');
const checkoutRoute = require('./routes/checkoutRoute.js');


const path = require("path")
const bodyParser = require("body-parser");

//call express function
const app = express()
app.use(bodyParser.json());
app.use(express.static(path.join(__dirname,'files')));
app.use(bodyParser.urlencoded({extended: false}))

// Logger
app.use("/", function(req,res,next){
    console.log(req.method, req.url)
    next()
})
app.use(cors())
app.use(userRoute);
app.use(doctorRoute);
app.use(productRoute);
app.use(addtocartRoute);
app.use(appointmentRoute);
app.use(checkoutRoute);



//configuring the servers
app.listen(90,()=>{
    console.log("Server is started at: http://localhost:90/")
})

//final push api