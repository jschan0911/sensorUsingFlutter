import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

class ShowYaw extends StatefulWidget {
  const ShowYaw({Key? key}) : super(key: key);

  @override
  State<ShowYaw> createState() => _ShowYawState();
}

class _ShowYawState extends State<ShowYaw> {
  double gYaw = 0.0;
  double aYaw = 0.0;
  double yaw = 0.0;

  double gyroscopeZ = 0.0;
  // double previousGyroscopeZ = 0.0;
  // double deltaTime = 0.0;

  String detection = "";

  @override
  void initState() {
    super.initState();
    gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        // gYaw += (180 / pi) * event.z * 0.01;
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

    // accelerometerEvents.listen((AccelerometerEvent event) {
    //   setState(() {
    //     double gx = event.x;
    //     double gy = event.y;
    //     double gz = event.z;
    //
    //     double norm = sqrt(gx * gx + gy * gy + gz * gz);
    //     gx /= norm;
    //     gy /= norm;
    //     gz /= norm;
    //
    //     aYaw += (180 / pi) * -atan2(gx, gz);
    //     yaw = gYaw * 0.98 + aYaw * 0.02;
    //     // yaw = aYaw;
    //
    //     if (yaw > 90) {
    //       detection = "Left";
    //       yaw = 0;
    //     }
    //
    //     if (yaw < -90) {
    //       detection = "Right";
    //       yaw = 0;
    //     }
    //   });
    // });
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
    );
  }
}
