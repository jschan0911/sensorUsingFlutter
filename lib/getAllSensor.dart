import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sensors/sensors.dart';
import 'package:sensors_example/distance.dart';
import 'package:sensors_example/mapPage.dart';
import 'package:sensors_example/pointMapPage.dart';
import 'package:sensors_example/postgreTest.dart';
import 'package:sensors_example/postgres.dart';
import 'package:sensors_example/qrPage.dart';
import 'package:sensors_example/yaw.dart';

class GetAllSensor extends StatefulWidget {
  const GetAllSensor({Key? key}) : super(key: key);

  @override
  State<GetAllSensor> createState() => _GetAllSensorState();
}

class _GetAllSensorState extends State<GetAllSensor> {

  double _gyroscopeX = 0;
  double _gyroscopeY = 0;
  double _gyroscopeZ = 0;
  double _accelerometerX = 0;
  double _accelerometerY = 0;
  double _accelerometerZ = 0;

  TextEditingController _floor = TextEditingController();
  TextEditingController _x = TextEditingController();
  TextEditingController _y = TextEditingController();

  @override
  void initState() {
    super.initState();

    // 자이로센서 및 가속도센서 값 구독
    gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        _gyroscopeX = event.x;
        _gyroscopeY = event.y;
        _gyroscopeZ = event.z;
      });
    });

    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerX = event.x;
        _accelerometerY = event.y;
        _accelerometerZ = event.z;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensor Values'),
      ),
      body: Center(
          child: Column(children: [
            // Text('Gyroscope values:'),
            // Text('X: $_gyroscopeX'),
            // Text('Y: $_gyroscopeY'),
            // Text('Z: $_gyroscopeZ'),
            // SizedBox(height: 20),
            // Text('Accelerometer values:'),
            // Text('X: $_accelerometerX'),
            // Text('Y: $_accelerometerY'),
            // Text('Z: $_accelerometerZ'),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ShowYaw())
                  );
                },
                child: Text("Show yaw")
            ),
            Divider(),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => QRPage())
                  );
                },
                child: Text("Show qr")
            ),
            Divider(),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.3),
                child: Row(
                  children: [
                    Expanded(child: Text("floor")),
                    Expanded(child: TextField(
                      controller: _floor,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                    ),)
                  ],
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.3),
                child: Row(
                  children: [
                    Expanded(child: Text("x")),
                    Expanded(child: TextField(
                      controller: _x,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                    ),)
                  ],
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.3),
                child: Row(
                  children: [
                    Expanded(child: Text("y")),
                    Expanded(child: TextField(
                      controller: _y,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                    ),)
                  ],
                ),
              ),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                      // MaterialPageRoute(builder: (context) => PointMapPage('{"floor": ${_floor.text}, "x": 930, "y": 742}'))
                      MaterialPageRoute(builder: (context) => PointMapPage('{"floor": ${_floor.text}, "x": ${_x.text}, "y": ${_y.text}}'))
                  );
                },
                child: Text("Show point map")
            ),
            Divider(),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Distance())
                  );
                },
                child: Text("Distance")
            ),
            Divider(),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => PostgreTest())
                  );
                },
                child: Text("PostgreSQL")
            ),
            Divider(),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => PostgresPage())
                  );
                },
                child: Text("Postgres")
            ),
          ],
        ),
      )
    );
  }
}
