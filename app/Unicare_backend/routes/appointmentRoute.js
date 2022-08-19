// /importing express
const express = require('express')

//bulk export of the route
const router = new express.Router()


//importing require model
const appointment= require('../models/appointmentModel')

router.post(
    "/appointment/register",
    async (req, res) => {
      console.log(req.body);
    
      const appointmentname = req.body.appointmentname;
      const appointmenttime = req.body.appointmenttime;
      const appointmentdate = req.body.appointmentdate;
      const doctorid = req.body.doctorid;
      const userid =req.body.userid
      try {
        const appointmenttest = await appointment.findOne({ doctorid: doctorid, userid:userid });
        console.log(appointmenttest);
        if (appointmenttest){
            console.log("fhgurshgu");
        
            res.json({ success: false, message: "Already in appointment list" });
        }
        else{
            const data = new appointment({ appointmentname: appointmentname, appointmenttime:appointmenttime, appointmentdate:appointmentdate, doctorid:doctorid, userid:userid
            });
            data.save()
        .then(function (result) {
            console.log('heel')
            res.status(201).json({ success: true, message: "Added to appointment list" });

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

router.get('/appointment/getall/:id',  function (req, res) {
    const userid=req.params.id
    appointment.find({userid: userid})
        .then(function (data) {
            console.log(data)
            res.status(201).json({ data: data, success: true });
        })
        .catch(function (err) {
            res.status(500).json({ message: err })
        })
})

router.delete('/appointment/remove/:id', function (req, res) {
    const id = req.params.id;
    appointment.deleteOne({ _id: id })
        .then(function (result) {
            console.log("feaf");
            res.status(201).json({ message: "appointment removed!", success: true });

        })
        .catch(function (err) {
            res.status(500).json({ message: err })
        })
})
module.exports = router