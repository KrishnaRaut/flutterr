import 'dart:convert';
import 'dart:io';

import 'package:app/ApiServices/adminServices.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import 'AdminDashboard.dart';

class AddDoctor extends StatefulWidget {
  const AddDoctor({Key? key}) : super(key: key);

  @override
  _AddDoctorState createState() => _AddDoctorState();
}

class _AddDoctorState extends State<AddDoctor> {
  final doctornameController = TextEditingController();
  final doctorSpecialityController = TextEditingController();
  final doctorhospitalController = TextEditingController();

  String doctorname = "";
  String doctorspeciality = "";
  String doctorhospital = "";
  File? imageFile;

  adddoctorData() async {
    try {
      var body = {
        "doctorname": doctorname,
        "doctorspeciality": doctorspeciality,
        "doctorhospital": doctorhospital,
        "image": imageFile
      };

      var adminservice = await adminServices();
      var response = await adminservice.adddoctor(body);
      return response;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Icon(
                  Icons.settings,
                  color: Colors.blue,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text("Add Doctor Info",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4, top: 8.0),
                  child: TextFormField(
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    controller: doctornameController,
                    onChanged: (value) {
                      doctorname = value;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter Doctor Name",
                      hintStyle: const TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                      contentPadding: EdgeInsets.all(10.0),
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.blue,
                      ),
                      enabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 6)),
                      focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 6)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4, top: 8.0),
                  child: TextFormField(
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    controller: doctorSpecialityController,
                    onChanged: (value) {
                      doctorspeciality = value;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter Doctor Speciality",
                      hintStyle: const TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                      contentPadding: EdgeInsets.all(10.0),
                      prefixIcon: const Icon(
                        Icons.account_circle,
                        color: Colors.blue,
                      ),
                      enabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 6)),
                      focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 6)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4, top: 8.0),
                  child: TextFormField(
                    style: const TextStyle(
                        color: Colors.black,fontWeight: FontWeight.bold),
                    controller: doctorhospitalController,
                    onChanged: (value) {
                      doctorhospital = value;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter Hospital Name",
                      hintStyle: const TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                      contentPadding: EdgeInsets.all(10.0),
                      prefixIcon: const Icon(
                        Icons.local_hospital,
                        color: Colors.blue,
                      ),
                      enabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 6)),
                      focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 6)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),

                if (imageFile != null)
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(imageFile!)),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                    onPressed: () => openImageFile(),
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(
                          Colors.blue),
                    ),
                    child: const Text(
                      "Choose Image",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )),
              ),
            ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: 200,
                  height: 80,
                  child: ElevatedButton(
                      onPressed: () async{
                        var response= json.decode(await adddoctorData());
                        if(response["success"]==true){
                          Fluttertoast.showToast(
                              msg: 'Doctor added successfully!',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.deepPurple,
                              textColor: Colors.white);
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdminDashboard()));
                        }
                        if(response["success"]==false){
                          Fluttertoast.showToast(
                              msg: 'Unsuccessful Action!',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.deepPurple,
                              textColor: Colors.white);
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(
                            Colors.blue),
                      ),
                      child: const Text(
                        "Add Details",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void openImageFile() async {
    final picture = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picture?.path != null) {
      setState(() {
        imageFile = File(picture!.path);
      });
    }
  }

}
