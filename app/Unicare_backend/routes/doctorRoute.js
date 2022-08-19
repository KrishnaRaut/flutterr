//importing express
const express = require('express')

//bulk export of the route
const router = new express.Router()

const upload = require('../middleware/fileupload');

//importing require model
const Doctor = require('../models/doctorModel');

// user register
router.post('/doctor/register', upload.single('myfile'), function(req, res) {
    
    console.log(req.body);
    const doctorname = req.body.doctorname;
    const doctorspeciality = req.body.doctorspeciality;
    const doctorhospital = req.body.doctorhospital;
    const doctorimage = req.file.filename;
    console.log(req.file);
  
    console.log(req.body);
    // const userType = req.body.usertype;

    const data = new Doctor({doctorname: doctorname, doctorspeciality: doctorspeciality, doctorhospital:doctorhospital, doctorimage:doctorimage, 
    });
   data.save()
       .then(function (result) {
           res.send({ success: true, message: "Data Added Successfully" });

       })
       .catch(function (err) {
           res.status(500).json({ message: err, success: false })
       })

})

router.put('/doctor/update/:id', function(req, res) {
    const doctorid=req.params.id;
    console.log(req.body);
   
    const doctorname = req.body.doctorname;
    const doctorspeciality = req.body.doctorspeciality;
    const doctorhospital = req.body.doctorhospital;

  
    console.log(req.body);

    Doctor.updateOne({ _id: doctorid }, {doctorname: doctorname, doctorspeciality: doctorspeciality, doctorhospital:doctorhospital}) 
    .then(function (result) {
        res.status(201).json({ success: true, message: "Doctor updated successfully!" });

    })
    .catch(function (err) {
        res.status(500).json({ message: err })
    })
    // const userType = req.body.usertype;

})

router.get('/doctor/getall',  function (req, res) {
    Doctor.find()
        .then(function (data) {
            console.log(data)
            res.status(201).json({ data: data, success: true });
        })
        .catch(function (err) {
            res.status(500).json({ message: err })
        })
})

router.get('/doctor/show/:id',  function (req, res) {
    const doctorid = req.params.id;
    Doctor.findOne({_id: doctorid})
        .then(function (data) {
            console.log(data)
            res.status(201).json({ data: data, success: true });
        })
        .catch(function (err) {
            res.status(500).json({ message: err })
        })
})


router.delete('/doctor/remove/:id', function (req, res) {
    const id = req.params.id;
    Doctor.deleteOne({ _id: id })
        .then(function (result) {
            res.status(201).json({ message: "Doctor removed!", success: true });

        })
        .catch(function (err) {
            res.status(500).json({ message: err })
        })
})

module.exports = router;