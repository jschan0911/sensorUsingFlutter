import 'dart:math';
//nowX, Y 연산에 img크기 핸들러 뺌, 그리고 yaw 자체를 보정시켜버렸음.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sensors/sensors.dart';
import 'package:sensors_example/newQrPage.dart';
import 'package:sensors_example/qrPage.dart';

class MyCustomPainter extends CustomPainter {
  final List<Offset> offsets;
  // final Offset offset;

  MyCustomPainter(this.offsets);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 5;

    for (Offset offset in offsets) {
      canvas.drawCircle(offset, 1.5, paint);
    }
  }

  @override
  bool shouldRepaint(MyCustomPainter oldDelegate) {
    return oldDelegate.offsets != offsets;
  }
}

class GetPathBuilding5 extends StatefulWidget {
  const GetPathBuilding5({Key? key}) : super(key: key);

  @override
  State<GetPathBuilding5> createState() => _GetPathBuilding5State();
}

class _GetPathBuilding5State extends State<GetPathBuilding5> {
  /*걸음 수를 측정하기 위해 필요한 변수들*/
  int _step = 0;                //걸음 수
  int _totalStep = 0;
  double _svm = 0.0;            //가속도 센서의 정보를 확인하기 위한 값
  double _upThreshold = 16.00;     //걸음 수를 셀 때 SVM값에 대한 한계값
  double _dnThreshold = 12.00;
  bool _isOver = false;         //걸음 수를 셀 때의 한계값을 넘었는지를 확인
  double _accelerometerX = 0.0; //가속도 센서의 값들
  double _accelerometerY = 0.0;
  double _accelerometerZ = 0.0;

  /*각도를 측정하기 위해 필요한 변수*/
  double yaw = 270.0; //z축 방향의 변화각 yaw

  /*경로를 나타내기 위해 필요한 변수들*/
  List<Offset> _offsets = []; //경로를 나타낼 때 필요한 좌표들을 저장하는 리스트
  double nowX = 682;  //사용자의 초기 위치
  double nowY = 790;

  /*테스트를 위한 변수들*/
  String results = "step, yaw, x, y";

  double imgSizeHandler = 0.35;

  double pixelPerMeter = 6.48;
  double oneStepInMeter = 0.7;
  double oneStepInPixel = 0.0;

  @override
  void initState() {
    //센서를 효과적으로 사용하기 위해 사용하는 시간 정보들
    DateTime beforeTimeForStep = DateTime.now();
    DateTime beforeTimeForSensor = beforeTimeForStep;
    DateTime beforeTimeForDraw = beforeTimeForStep;
    DateTime beforeTimeForYaw = beforeTimeForStep;

    super.initState();
    oneStepInPixel = pixelPerMeter * oneStepInMeter;

    /*방향 정보를 구하기 위해 사용하는 자이로스코프 센서*/
    gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        //Degree 단위로 받아온 실시간 Yaw 값
        yaw -= (180 / pi) * event.z * 0.01;

        DateTime nowTimeForYaw = DateTime.now();
        int deltaTimeForYaw = nowTimeForYaw.difference(beforeTimeForYaw).inMilliseconds;

        //0.05초 마다 Yaw 값을 중첩시킴
        if (deltaTimeForYaw >= 50) {
          yaw -= 0.01;
          beforeTimeForYaw = nowTimeForYaw;
        }

        //Yaw 값이 0~360의 범위를 갖도록 조정
        if (yaw < 0) {
          yaw += 360;
        }
        else if (yaw > 360) {
          yaw -= 360;
        }
      });
    });

    /*이동거리를 구하기 위해 걸음 수를 측정하는 데에 사용하는 가속도 센서*/
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        DateTime nowTimeForStep = DateTime.now();
        DateTime nowTimeForSensor = nowTimeForStep;
        DateTime nowTimeForDraw = nowTimeForStep;

        int deltaTimeForStep = nowTimeForStep.difference(beforeTimeForStep).inMilliseconds;
        int deltaTimeForSensor = nowTimeForSensor.difference(beforeTimeForSensor).inMilliseconds;
        int deltaTimeForDraw = nowTimeForDraw.difference(beforeTimeForDraw).inMilliseconds;

        //0.05초마다 센서들로부터 정보를 받아옴
        if (deltaTimeForSensor >= 50) {
          _accelerometerX = event.x;
          _accelerometerY = event.y;
          _accelerometerZ = event.z;

          //SVM을 계산
          _svm = _accelerometerX.abs() + _accelerometerY.abs() + _accelerometerZ.abs();


          if (_svm >= _upThreshold && _isOver == false) {
            _isOver = true;
          }
          else if (_svm <= _dnThreshold && _isOver == true) {
            _step += 1;
            _isOver = false;
          }

          beforeTimeForSensor = nowTimeForSensor;
        }

        // //0.55초마다 _isOver의 상태를 확인하고, 그 값이 true일 때 걸음 수를 증가
        // if (deltaTimeForStep >= 550 && _isOver == true) {
        //   _isOver = false;
        //   _step += 1;
        //   beforeTimeForStep = nowTimeForStep;
        // }

        //2초마다 사용자의 현재 위치를 계산하여 Paint로 표시
        if (deltaTimeForDraw >= 2000 && _step > 0) {
          // //8개 방향
          // if (yaw > 337.5 && yaw <=360 || yaw >= 0 && yaw <= 22.5) {
          //   yaw = 0;
          // }
          // else if (yaw > 22.5 && yaw <= 67.5) {
          //   yaw = 45;
          // }
          // else if (yaw > 67.5 && yaw <= 112.5) {
          //   yaw = 90;
          // }
          // else if (yaw > 112.5 && yaw <= 157.5) {
          //   yaw = 135;
          // }
          // else if (yaw > 157.5 && yaw <= 202.5) {
          //   yaw = 180;
          // }
          // else if (yaw > 202.5 && yaw <= 247.5) {
          //   yaw = 225;
          // }
          // else if (yaw > 247.5 && yaw <= 292.5) {
          //   yaw = 270;
          // }
          // else if (yaw > 292.5 && yaw <= 337.5) {
          //   yaw = 315;
          // }

          // 4개 방향
          if (yaw > 315 && yaw <= 360 || yaw >= 0 && yaw <= 45) {
            yaw = 0;
          }
          else if (yaw > 45 && yaw <= 135) {
            yaw = 90;
          }
          else if (yaw > 135 && yaw <= 225) {
            yaw = 180;
          }
          else if (yaw > 225 && yaw <= 315) {
            yaw = 270;
          }

          //사용자 위치 좌표 업데이트, 이때 cos, sin함수의 파라미터는 radian 단위이므로 변환 과정 추가
          nowX += _step * oneStepInPixel  * cos(yaw * (pi / 180));
          nowY += _step * oneStepInPixel * sin(yaw * (pi / 180));

          //사용자 경로 리스트에 현재 연산한 위치좌표 추가
          _offsets.add(Offset(nowX * imgSizeHandler, nowY * imgSizeHandler));

          //log 데이터 출력
          results += "\n$_step, ${yaw.toStringAsFixed(2)}, ${nowX.toStringAsFixed(2)}, ${nowY.toStringAsFixed(2)}";

          _totalStep += _step;

          //2초 동안의 변위를 의미하는 걸음 수 초기화
          _step = 0;
          beforeTimeForDraw = nowTimeForDraw;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Indoor Navigation"),),
      body: ListView(
          children: [Column(
            children: [
              Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: Stack(
                      children: [
                        Image.asset('images/1fmap.png',
                          width: 1111.0 * imgSizeHandler,
                          height: 849.0 * imgSizeHandler,
                        ),
                        CustomPaint(
                          painter: MyCustomPainter(_offsets),
                        )
                      ],
                    ),
                  )
              ),
              Text("Yaw: ${yaw.toStringAsFixed(0)}"),
              Text("Steps in 2sec: $_step"),
              Text("Total steps: $_totalStep"),

              // IconButton(
              //     onPressed: () {
              //       Clipboard.setData(ClipboardData(text: results));
              //     },
              //     icon: const Icon(Icons.copy)
              // ),
              // Text(results),

              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => QRPage())
                    );
                  },
                child: Text("QR Code")
              ),
            ],
          ),
          ]),
    );
  }
}
