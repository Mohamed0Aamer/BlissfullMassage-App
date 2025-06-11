import 'package:blissfulmassage/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BlissFullMassage());
}

class BlissFullMassage extends StatelessWidget {
  const BlissFullMassage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}
