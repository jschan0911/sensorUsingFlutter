import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

class GetPath extends StatefulWidget {
  const GetPath({Key? key}) : super(key: key);

  @override
  State<GetPath> createState() => _GetPathState();
}

class _GetPathState extends State<GetPath> {
  bool _isOver = false;

  int _step = 0;

  double _accelerometerX = 0.0;
  double _accelerometerY = 0.0;
  double _accelerometerZ = 0.0;
  double _svm = 0.0;
  double _threshold = 7.0;

  // String _detect = "";

  @override
  void initState() {
    DateTime beforeTime = DateTime.now();
    DateTime beforeTimeForSensor = beforeTime;
    // TODO: implement initState
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        DateTime nowTime = DateTime.now();
        DateTime nowTimeForSensor = nowTime;

        int deltaTime = nowTime.difference(beforeTime).inMilliseconds;
        int deltaTimeForSensor = nowTimeForSensor.difference(beforeTimeForSensor).inMilliseconds;

        if (deltaTimeForSensor >= 50) {
          _accelerometerX = event.x;
          _accelerometerY = event.y;
          _accelerometerZ = event.z;
          _svm = _accelerometerX.abs() + _accelerometerY.abs() + _accelerometerZ.abs() - 10.0;

          beforeTimeForSensor = nowTimeForSensor;

          if (_svm > _threshold) {
            _isOver = true;
          }

          if (deltaTime >= 500) {
            if (_isOver == true) {
              _isOver = false;
              _step += 1;
              beforeTime = nowTime;
            }
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Get Path"),),
      body: Center(
        child: Column(
          children: [
            Text("$_svm"),
            Text("$_step", style: TextStyle(fontSize: 30),),
            ElevatedButton(onPressed: () {
              _step = 0;
            }, child: Text("Reset")),
          ],
        ),
      ),
    );
  }
}
