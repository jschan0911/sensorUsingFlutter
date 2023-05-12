import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

class Distance extends StatefulWidget {
  const Distance({Key? key}) : super(key: key);

  @override
  State<Distance> createState() => _DistanceState();
}

class _DistanceState extends State<Distance> {
  // 가속도 센서 값을 저장할 변수
  List<double> _accelerometerValues = [0, 0, 0];
  // 경과 시간을 저장할 변수
  int _timeStamp = DateTime.now().millisecondsSinceEpoch;
  // 이동 거리를 저장할 변수
  double _distance = 0;
  // 속도를 저장할 변수
  double _velocity = 0;

  // 가속도 센서 값을 읽어올 함수
  void _onAccelerometerData(AccelerometerEvent event) {
    // 현재 시간을 구합니다.
    int currentTimeStamp = DateTime.now().millisecondsSinceEpoch;
    // 경과 시간을 계산합니다.
    double deltaTime = (currentTimeStamp - _timeStamp) / 1000.0;
    // 현재 시간을 이전 시간 값으로 업데이트합니다.
    _timeStamp = currentTimeStamp;

    // 가속도 센서 값을 저장합니다.
    _accelerometerValues = <double>[event.x, event.y, event.z];

    // 현재 속도를 계산합니다.
    _velocity += _accelerometerValues[0] * deltaTime;

    // 현재 이동 거리를 계산합니다.
    double deltaDistance = _velocity * deltaTime;

    // 누적 이동 거리를 업데이트합니다.
    // _distance += deltaDistance;

    // 상태를 업데이트합니다.
    setState(() {
      _distance += deltaDistance;
    });
  }

  // 초기화 함수
  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen(_onAccelerometerData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Distance Tracker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '이동 거리:',
            ),
            Text(
              '$_distance m',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}
