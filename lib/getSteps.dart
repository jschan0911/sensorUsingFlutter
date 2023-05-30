import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sensors/sensors.dart';

class GetSteps extends StatefulWidget {
  const GetSteps({Key? key}) : super(key: key);

  @override
  State<GetSteps> createState() => _GetStepsState();
}

class _GetStepsState extends State<GetSteps> {
  bool _isOver = false;

  int _step = 0;

  double _accelerometerX = 0.0;
  double _accelerometerY = 0.0;
  double _accelerometerZ = 0.0;
  double _svm = 0.0;
  double _upThreshold = 16.00;
  double _dnThreshold = 12.00;

  // List<double> svmList = [];
  // double _meanSvm = 0.0;

  String logData = "";
  int totalTime = 0;

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
          _svm = _accelerometerX.abs() + _accelerometerY.abs() + _accelerometerZ.abs();

          beforeTimeForSensor = nowTimeForSensor;

          if (_svm >= _upThreshold && _isOver == false) {
            _isOver = true;
          }
          else if (_svm <= _dnThreshold && _isOver == true) {
            _step += 1;
            _isOver = false;
          }

          // if (_svm > _upThreshold) {
          //   _isOver = true;
          // }

          totalTime += deltaTimeForSensor;
          logData += "\n($totalTime, ${_svm.toStringAsFixed(4)}),";

        }

        // //0.55초마다 _isOver의 상태를 확인하고, 그 값이 true일 때 걸음 수를 증가
        // if (deltaTime >= 600 && _isOver == true) {
        //   _isOver = false;
        //   _step += 1;
        //   beforeTime = nowTime;
        // }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Accelerometer sensor"),),
      body: ListView(
        children: [Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text( "${_svm.toStringAsFixed(2)}", style: TextStyle(fontSize: 30)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Steps: $_step", style: TextStyle(fontSize: 20, color: Colors.grey)),
              ),
              // Text("mean svm: $_meanSvm"),
              // ElevatedButton(onPressed: () {
              //   _step = 0;
              //   _meanSvm = 0.0;
              //   svmList = [];
              // }, child: Text("Reset")),

              // IconButton(
              //     onPressed: () {
              //       Clipboard.setData(ClipboardData(text: logData));
              //     },
              //     icon: const Icon(Icons.copy)
              // ),
              // Text(logData),
            ],
          ),
        ),]
      ),
    );
  }
}
