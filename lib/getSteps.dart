import 'package:flutter/material.dart';
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
  double _threshold = 5.85;

  // List<double> svmList = [];
  // double _meanSvm = 0.0;

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

          // //최적의 threshold 값을 찾는 코드
          // if (_svm > 5.0) {
          //   svmList.add(_svm);
          //
          //   double nowSum = 0.0;
          //   for (double d in svmList) {
          //     nowSum += d;
          //   }
          //   _meanSvm = nowSum / svmList.length;
          //   // _threshold = _meanSvm;
          // }

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
            // Text("mean svm: $_meanSvm"),
            ElevatedButton(onPressed: () {
              _step = 0;
              // _meanSvm = 0.0;
              // svmList = [];
            }, child: Text("Reset")),
          ],
        ),
      ),
    );
  }
}
