import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

class GetPath extends StatefulWidget {
  const GetPath({Key? key}) : super(key: key);

  @override
  State<GetPath> createState() => _GetPathState();
}

class _GetPathState extends State<GetPath> {
  double _accelerometerX = 0.0;
  double _accelerometerY = 0.0;
  double _accelerometerZ = 0.0;

  double _svm = 0.0;

  String _detect = "";

  int _step = 0;

  @override
  void initState() {
    DateTime beforeTime = DateTime.now();
    // TODO: implement initState
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        DateTime nowTime = DateTime.now();
        int deltaTime = nowTime.difference(beforeTime).inMilliseconds;

        if (deltaTime >= 100) {
          _accelerometerX = event.x;
          _accelerometerY = event.y;
          _accelerometerZ = event.z;

          _svm = _accelerometerX.abs() + _accelerometerY.abs() + _accelerometerZ.abs() - 10.0;

          if (_svm > 7.0) {
            _detect += "\n$_svm";
            _step += 1;
          }
          beforeTime = nowTime;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Get Path"),),
      body: Column(
        children: [
          Text("$_svm"),
          Text("$_step"),
          ListView(
            children: [
              Center(
                child: Text(_detect),
              )
            ]
          ),
        ],
      ),
    );
  }
}
