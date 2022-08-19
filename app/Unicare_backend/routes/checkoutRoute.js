const express = require('express')

//bulk export of the route
const router = new express.Router()


//importing require model
const checkout= require('../models/checkoutModel')


router.post('/checkout/details/register', function(req, res) {
    console.log(req.body);
            const userid = req.body.userid;
            const price = req.body.price;
            const creditcarddetails = req.body.creditcarddetails;
            const address = req.body.address;
          
            console.log(req.body);
            // const userType = req.body.usertype;
        
            const data = new checkout({userid: userid, price: price, creditcarddetails:creditcarddetails, address:address, 
            });
           data.save()
               .then(function (result) {
                   res.send({ success: true, message: "Data Added Successfully" });
        
               })
               .catch(function (err) {
                   res.status(500).json({ message: err, success: false })
               })
        
        })

  module.exports=router;