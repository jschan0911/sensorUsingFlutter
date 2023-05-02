import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

class ShowYaw extends StatefulWidget {
  const ShowYaw({Key? key}) : super(key: key);

  @override
  State<ShowYaw> createState() => _ShowYawState();
}

class _ShowYawState extends State<ShowYaw> {
  double yaw = 0.0;
  double gyroscopeZ = 0.0;
  double previousGyroscopeZ = 0.0;
  double deltaTime = 0.0;

  String detection = "";

  @override
  void initState() {
    super.initState();
    gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        // // Calculate deltaTime
        // final double now = DateTime
        //     .now()
        //     .microsecondsSinceEpoch / 1000000;
        // deltaTime = now - previousGyroscopeZ;
        //
        // // Update previousGyroscopeZ
        // previousGyroscopeZ = now;
        //
        // // Update gyroscopeZ
        // gyroscopeZ += event.z * deltaTime;

        // Update yaw using gyroscopeZ
        // yaw += (180 / pi) * gyroscopeZ;
        //
        // gyroscopeZ = 0;

        yaw += (180 / pi) * event.z * 0.01;

        if (yaw > 90) {
          detection = "Left";
          yaw = 0;
        }

        if (yaw < -90) {
          detection = "Right";
          yaw = 0;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gyroscope Example'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'Yaw: ${yaw.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 24.0),
            ),
            Text(
              'Detect: $detection',
              style: TextStyle(fontSize: 24.0),
            ),
            TextButton(onPressed: (){
              yaw = 0;
            }, child: Text("Reset"))
          ],
        ),
      )
    //   Center(
    //     child: Text(
    //       'Yaw: ${yaw.toStringAsFixed(2)}',
    //       style: TextStyle(fontSize: 24.0),
    //     ),
    //   ),
    // )


    );
  }
}
