import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'package:sensors_example/getAllSensor.dart';
import 'package:sensors_example/yaw.dart';

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
    return const MaterialApp(
      home: GetAllSensor()
    );
  }
}
