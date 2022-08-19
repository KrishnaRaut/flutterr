//importing express
const express = require('express')

//bulk export of the route
const router = new express.Router()

const upload = require('../middleware/fileupload')

//importing require model
const product = require('../models/productModel')

// user register
router.post('/product/register', upload.single("myfile"), function(req, res) {
   
    const productname = req.body.productname;
    const productprice = req.body.productprice;
    const productimage = req.file.filename;
    console.log(req.body);
    // const userType = req.body.usertype;

    const data = new product({productname: productname, productprice: productprice, productimage:productimage, 
    });
   data.save()
       .then(function (result) {
           res.send({ success: true, message: "Data Added Successfully" });

       })
       .catch(function (err) {
           res.status(500).json({ message: err, success: false })
       })

})

router.get('/product/getall',  function (req, res) {
    product.find()
        .then(function (data) {
            console.log(data)
            res.status(201).json({ data: data, success: true });
        })
        .catch(function (err) {
            res.status(500).json({ message: err })
        })
})

router.get('/product/show/:id',  function (req, res) {
    const productid = req.params.id;
    product.findOne({_id: productid})
        .then(function (data) {
            console.log(data)
            res.status(201).json({ data: data, success: true });
        })
        .catch(function (err) {
            res.status(500).json({ message: err })
        })
})

router.delete('/product/remove/:id', function (req, res) {
    const id = req.params.id;
    product.deleteOne({ _id: id })
        .then(function (result) {
            res.status(201).json({ message: "product removed!", success: true });

        })
        .catch(function (err) {
            res.status(500).json({ message: err })
        })
})


module.exports = router;