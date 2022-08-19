//importing express
const express = require('express')

//bulk export of the route
const router = new express.Router()

// importing require libraries/files
const bcrypt = require("bcryptjs")
// const auth = require("../middleware/auth")
const jwt = require("jsonwebtoken")
const upload = require('../middleware/fileupload')

//importing require model
const User = require('../models/userModel')

// user register
router.post('/user/register', function(req, res) {
   
    const email = req.body.email;
    const username = req.body.username;
    const password = req.body.password;
    console.log(req.body);
    // const userType = req.body.usertype;

    bcrypt.hash(password, 10, function(err, hashPassword) {
        const data = new User({username:username,email:email, password:hashPassword})
        data.save()
            .then(function(result) {
                console.log(data)
                res.status(201).json({
                    success: true,
                    message: "Registered successfully",
                    data: data
                })
            })
            .catch(function(error) {
                res.status(500).json({
                    success: false,
                    message: "Invalid registration"
                })
            })
    })

})

//user login
router.post('/user/login', function(req, res) {
    console.log(req.body)
    const email = req.body.email;
    const password = req.body.password;
    User.findOne({
            email: email
        })
        .then(function(data) {    
            if (data === null) {         
                return res.status(403).json({
                    message: "Invalid Login", success: false
                })
            }
            bcrypt.compare(password, data.password, function(err, result) {       
                if (result === false) {           
                    return res.status(403).json({
                        success: false,
                        message: "Invalid login"
                    })
                }
        
                const token = jwt.sign({
                    YourId: data._id
                }, 'anysecretkey')
            
                res.status(200).json({
                    success:true,
                    userId: data._id
                })
            })
        })
    .catch(function(error) {
                res.status(500).json({
                    success: false,
                    message: "Error occoured"
                })
            })
})

router.get("/user/profile/:id", function (req, res) {
    const user_id = req.params.id;
    User
      .findOne({ _id: user_id })
      .then(function (data) {
          console.log(data)
        res.send({ data: data, success: true});
      })
      .catch(function (err) {
       
        res.status(500).json({ message: err });
      });
  });

module.exports = router