import 'dart:convert';

import 'package:flutter/material.dart';

import 'mapData.dart';

class MyCustomPainter extends CustomPainter {
  final Offset offset;

  MyCustomPainter(this.offset);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 5;

    canvas.drawCircle(offset, 2, paint);
  }

  @override
  bool shouldRepaint(MyCustomPainter oldDelegate) {
    return oldDelegate.offset != offset;
  }
}

class PointMapPage extends StatefulWidget {
  final String _data;

  PointMapPage(this._data, {Key? key}) : super(key: key);

  @override
  State<PointMapPage> createState() => _PointMapPageState();
}

class _PointMapPageState extends State<PointMapPage> {
  Map<String, dynamic> data = Map();
  Map<String, dynamic> mapData = Map();

  int floor = 0;
  int x = 0;
  int y = 0;

  double imgWidth = 0;
  double imgHeight = 0;
  String imgUrl = '';

  double imgSizeHandler = 0.35;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = jsonDecode(widget._data);

    floor = data['floor'];
    x = data['x'];
    y = data['y'];
    y = MapData().getColumnFromY(floor, y);

    mapData = MapData().dataSet(widget._data);

    imgUrl = mapData['url'];
    imgWidth = mapData['widths'];
    imgHeight = mapData['heights'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Map page after qr"),),
      body: ListView(
        children: [
          // Text('${widget.imgForData.width}'),
          Center(
            child: Stack(
              children: [
                Image.asset(imgUrl,
                  width: imgWidth * imgSizeHandler,
                  height: imgHeight * imgSizeHandler,
                ),
                CustomPaint(
                  painter: MyCustomPainter(Offset(x.toDouble() * imgSizeHandler, y.toDouble() * imgSizeHandler)),
                )
              ],
            )
          ),
          Text('floor: $floor'),
          Text('x: $x'),
          Text('y: $y'),
        ],
      ),
    );
  }
}
