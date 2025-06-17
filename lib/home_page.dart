import 'package:blissfulmassage/widget/textformfieldWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key}); //{
  //  getData();
  // }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _selectedBookingType;
  final List<String> _bookingTypes = ['Walk-in', 'Appointment', 'House Call'];
  final TextEditingController _dobController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var adressController = TextEditingController();
  var complaintController = TextEditingController();
  var raceController = TextEditingController();
  var diagnosisController = TextEditingController();
  var patient = FirebaseFirestore.instance.collection("patient");

  List dataList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffC1E8FF),
        title: Row(
          children: [
            SizedBox(width: 10),
            Text(
              'BlissFull Massage',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color(0xff052659),
              ),
            ),
            Spacer(),

            MaterialButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Color(0xffC1E8FF),
                      title: Text(
                        "Add New Patient",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      content: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Textformfieldwidget(
                                controller: nameController,
                                hintText: "Name",
                              ),

                              SizedBox(height: 10),
                              Textformfieldwidget(
                                controller: phoneController,
                                hintText: "Phone",
                              ),
                              SizedBox(height: 10),
                              Textformfieldwidget(
                                controller: adressController,
                                hintText: "Adress",
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                controller: _dobController,
                                readOnly: true,
                                decoration: InputDecoration(
                                  fillColor: Color(0xff5483b3),
                                  filled: true,
                                  labelText: "Date of Birth",
                                  labelStyle: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                  border: OutlineInputBorder(),
                                  suffixIcon: Icon(Icons.calendar_today),
                                ),
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now(),
                                  );
                                  if (pickedDate != null) {
                                    _dobController.text =
                                        "${pickedDate.toLocal()}".split(' ')[0];
                                  }
                                },
                              ),
                              SizedBox(height: 10),
                              Textformfieldwidget(
                                controller: raceController,
                                hintText: "Race",
                              ),
                              SizedBox(height: 10),
                              Textformfieldwidget(
                                controller: complaintController,
                                hintText: "Complaint",
                              ),
                              SizedBox(height: 10),
                              Textformfieldwidget(
                                controller: diagnosisController,
                                hintText: "Dr,s diagnosis",
                              ),
                              SizedBox(height: 15),

                              DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  fillColor: Color(0xff5483b3),
                                  filled: true,
                                  labelText: 'Booking Type',
                                  labelStyle: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                                value: _selectedBookingType,
                                items: _bookingTypes.map((type) {
                                  return DropdownMenuItem(
                                    value: type,
                                    child: Text(type),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedBookingType = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Cancel"),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await addPatient();
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffA7C7E7),
                            foregroundColor: Color(0xff4B0082),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 15,
                            ),
                            elevation: 3,
                          ),
                          child: Text("Add Patient"),
                        ),
                      ],
                    );
                  },
                );
              },
              color: Color(0xff7DA0C4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Add Patient",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 5),
                  Icon(Icons.personal_injury),
                ],
              ),
            ),
            SizedBox(width: 13),
            MaterialButton(
              onPressed: () {},
              color: Color(0xff7DA0C4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Patient Files",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 5),
                  Icon(Icons.file_open),
                ],
              ),
            ),
            SizedBox(width: 13),
            MaterialButton(
              onPressed: () {},
              color: Color(0xff7DA0C4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Service",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 5),
                  Icon(Icons.money),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addPatient() async {
    await patient
        .add({
          "name": nameController.text,
          "phone": phoneController.text,
          "adress": adressController.text,
          "complaint": complaintController.text,
          "race": raceController.text,
          "daignosis": diagnosisController.text,
          "Date of Brith": _dobController.text,
          "Booking Type": _selectedBookingType,
        })
        .then((value) => print("patient added"))
        .catchError((error) => print("failed to added : $error"));
  }

  getData() async {
    QuerySnapshot querySnapshot = await patient.get();
    dataList.addAll(querySnapshot.docs);
  }
}
