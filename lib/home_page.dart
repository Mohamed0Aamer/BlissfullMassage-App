import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
              onPressed: () {},
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
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Patient File",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 5),
                  Icon(Icons.file_copy),
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
}
