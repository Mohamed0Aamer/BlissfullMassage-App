import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PatientFilesScreen extends StatefulWidget {
  const PatientFilesScreen({super.key});

  @override
  State<PatientFilesScreen> createState() => _PatientFilesScreenState();
}

class _PatientFilesScreenState extends State<PatientFilesScreen> {
  List<Map<String, dynamic>> patients = [];

  @override
  void initState() {
    super.initState();
    fetchPatients();
  }

  Future<void> fetchPatients() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection("patient")
        .get();
    setState(() {
      patients = querySnapshot.docs.map((doc) {
        final data = doc.data();
        data["id"] = doc.id;
        return data;
      }).toList();
    });
  }

  void showPatientDetails(Map<String, dynamic> patient) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(patient["name"] ?? "No Name"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Phone: ${patient["phone"] ?? "N/A"}"),
            Text("Address: ${patient["adress"] ?? "N/A"}"),
            Text("Date of Birth: ${patient["Date of Brith"] ?? "N/A"}"),
            Text("Race: ${patient["race"] ?? "N/A"}"),
            Text("Complaint: ${patient["complaint"] ?? "N/A"}"),
            Text("Diagnosis: ${patient["daignosis"] ?? "N/A"}"),
            Text("Booking Type: ${patient["Booking Type"] ?? "N/A"}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffC1E8FF),
        title: Text(
          "Patient Files",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: patients.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: patients.length,
              itemBuilder: (context, index) {
                final patient = patients[index];
                return ListTile(
                  title: Text(patient["name"] ?? "No Name"),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () => showPatientDetails(patient),
                );
              },
            ),
    );
  }
}
