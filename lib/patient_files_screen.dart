import 'package:flutter/material.dart';
import 'package:blissfulmassage/home_page.dart';

class PatientFilesScreen extends StatelessWidget {
  const PatientFilesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              "Patient Files",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
