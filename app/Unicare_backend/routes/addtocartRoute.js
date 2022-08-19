// /importing express
const express = require('express')

//bulk export of the route
const router = new express.Router()

// importing require libraries/files
const bcrypt = require("bcryptjs")
// const auth = require("../middleware/auth")
const jwt = require("jsonwebtoken")
const upload = require('../middleware/fileupload')

//importing require model
const addtocart= require('../models/addtocartModel')

router.post(
    "/product/addtocart",
    async (req, res) => {
      console.log(req.body);
      const userid = req.body.userid;
      const productid = req.body.productid;
      try {
        const product = await addtocart.findOne({userid:userid, productid: productid });
        if (product){
            console.log("feaf");
            res.json({ success: false, message: "Already in addtocart list" });
        }
        else{
            const data = new addtocart({userid:userid, productid : productid
            });
            data.save()
        .then(function (result) {
        
            res.status(201).json({ success: true, message: "Added to cart list" });

        })
        .catch(function (err) {
            res.status(500).json({ message: err })
        })
        }
      }
    catch{

    }
    }
  );

router.get('/product/getall/:id',  function (req, res) {
    const userid=req.params.id
    addtocart.find({userid: userid})
        .then(function (data) {
            console.log(data)
            res.status(201).json({ data: data, success: true });
        })
        .catch(function (err) {
            res.status(500).json({ message: err })
        })
})

router.delete('/addtocart/remove/:id', function (req, res) {
    const id = req.params.id;
    addtocart.deleteOne({ _id: id })
        .then(function (result) {
            console.log("feaf");
            res.status(201).json({ message: "Product removed!", success: true });

        })
        .catch(function (err) {
            res.status(500).json({ message: err })
        })
})
module.exports = router