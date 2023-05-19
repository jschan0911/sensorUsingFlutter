import 'dart:async';
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
  
  String timeStamp = "";

  @override
  void initState() {
    super.initState();
    DateTime beforeTime = DateTime.now();
    gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        yaw -= (180 / pi) * event.z * 0.01;

        DateTime nowTime = DateTime.now();
        int deltaTime = nowTime.difference(beforeTime).inMilliseconds;

        if (deltaTime >= 50) {
          yaw -= 0.01;
          beforeTime = nowTime;
        }

        if (yaw < 0) {
          yaw += 360;
        }

        if (yaw > 360) {
          yaw -= 360;
        }

        // double beforeYaw = 0;
        // if (beforeYaw - yaw >= 0.01) {
        //   DateTime now = DateTime.now();
        //   Duration deltaTime = now.difference(beforeTime);
        //   String dTime = deltaTime.toString();
        //   timeStamp += "\n$dTime";
        //
        //   beforeTime = now;
        //   beforeYaw = yaw;
        //   yaw = 0;
        // }

        // if (yaw > 90) {
        //   detection = "Right";
        //   yaw = 0;
        // }
        //
        // if (yaw < -90) {
        //   detection = "Left";
        //   yaw = 0;
        // }
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
      body: ListView(
        children: [
          Center(
            child: Column(
              children: [
                Text(
                  'Yaw: ${yaw.toStringAsFixed(5)}',
                  style: TextStyle(fontSize: 24.0),
                ),
                Text(
                  'Detect: $detection',
                  style: TextStyle(fontSize: 24.0),
                ),
                TextButton(onPressed: (){
                  yaw = 0;
                  timeStamp = "";
                }, child: Text("Reset"))
              ],
            ),
          ),
          Text(timeStamp)
        ]
      )
    );
  }
}
