import 'package:camra_gallary/direction.dart';
import 'package:camra_gallary/listview.dart';
import 'package:camra_gallary/selecttype.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: direction.id,
      routes: {
        direction.id: (context) => direction(),
        selecttype.id: (context) => selecttype(),
      },
    );
  }
}
