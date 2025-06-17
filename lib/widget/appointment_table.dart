import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentTable extends StatefulWidget {
  const AppointmentTable({super.key});

  @override
  State<AppointmentTable> createState() => _AppointmentTableState();
}

class _AppointmentTableState extends State<AppointmentTable> {
  final List<String> _days = [
    'Saturday',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];

  final List<String> _hours =
      List.generate(12, (index) {
        int hour = 12 + index;
        return hour > 12 ? '${hour - 12}:00 PM' : '12:00 PM';
      }) +
      List.generate(12, (index) {
        return '${index == 0 ? 12 : index}:00 AM';
      });

  List<DocumentSnapshot> _patients = [];
  Map<String, String> _appointments = {};

  @override
  void initState() {
    super.initState();
    _fetchPatients();
    _fetchAppointments();
  }

  Future<void> _fetchPatients() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('patient')
        .get();
    setState(() {
      _patients = snapshot.docs;
    });
  }

  Future<void> _fetchAppointments() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('appointments')
        .get();
    setState(() {
      for (var doc in snapshot.docs) {
        final day = doc['day'];
        final hour = doc['hour'];
        final name = doc['patientName'];
        _appointments['$day|$hour'] = name;
      }
    });
  }

  Future<void> _bookPatient({
    required BuildContext context,
    required String day,
    required String hour,
  }) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Patient'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _patients.length,
            itemBuilder: (context, index) {
              final patient = _patients[index];
              final name = patient['name'] ?? 'Unknown';
              return ListTile(
                title: Text(name),
                onTap: () async {
                  final key = '$day|$hour';
                  setState(() {
                    _appointments[key] = name;
                  });

                  await FirebaseFirestore.instance
                      .collection('appointments')
                      .add({
                        'day': day,
                        'hour': hour,
                        'patientName': name,
                        'timestamp': DateTime.now(),
                      });

                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(
    BuildContext context,
    String bookingKey,
    String day,
    String hour,
    String patientName,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('delete appointment '),
        content: Text(' do you want delete this patient "$patientName"؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('cancel'),
          ),
          TextButton(
            onPressed: () async {
              // حذف من الواجهة
              setState(() {
                _appointments.remove(bookingKey);
              });

              // حذف من Firestore
              final query = await FirebaseFirestore.instance
                  .collection('appointments')
                  .where('day', isEqualTo: day)
                  .where('hour', isEqualTo: hour)
                  .where('patientName', isEqualTo: patientName)
                  .get();

              for (var doc in query.docs) {
                await FirebaseFirestore.instance
                    .collection('appointments')
                    .doc(doc.id)
                    .delete();
              }

              Navigator.pop(context);
            },
            child: Text('delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 1.4,
        child: Table(
          border: TableBorder.all(),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  color: Colors.blue[100],
                  child: Text(
                    'Time',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ..._days.map(
                  (day) => Container(
                    padding: EdgeInsets.all(8),
                    color: (day == 'Saturday' || day == 'Friday')
                        ? Colors.grey[300]
                        : Colors.blue[100],
                    child: Text(
                      day,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            ..._hours.map(
              (hour) => TableRow(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    color: Colors.blue[100],
                    child: Text(hour, textAlign: TextAlign.center),
                  ),
                  ..._days.map((day) {
                    final key = '$day|$hour';
                    final name = _appointments[key];

                    return GestureDetector(
                      onTap: () {
                        if (name != null) {
                          _showDeleteDialog(context, key, day, hour, name);
                        } else {
                          _bookPatient(context: context, day: day, hour: hour);
                        }
                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        color: (day == 'Saturday' || day == 'Friday')
                            ? Colors.grey[200]
                            : Colors.white,
                        child: Text(
                          name ?? '+',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: name != null ? Colors.black : Colors.grey,
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
