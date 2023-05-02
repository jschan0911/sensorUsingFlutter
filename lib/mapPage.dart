import 'package:flutter/material.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  TextEditingController xController = TextEditingController();
  TextEditingController yController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Image Widget'),
      ),
      body: Column(
        children: [
          Center(
            child: Image.asset(
              'images/1f.png', // 이미지 경로
              // width: 500, // 이미지 너비
              // fit: BoxFit.contain, // 이미지 높이
            ),
          ),
          TextField(
            controller: xController,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }
}
