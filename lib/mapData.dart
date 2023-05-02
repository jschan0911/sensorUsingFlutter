import 'dart:convert';

class MapData {
  List<List<double>> mapSize = [
    [0.0, 0.0],   //floor 데이터를 바로 idx로 사용하기 위해 빈 자료 넣음
    [1111.0, 849.0],
    [989.0, 849.0],
    [1064.0, 849.0],
    [1064.0, 849.0],
    [1064.0, 849.0]
  ];

  Map<String, dynamic> dataSet(String _data) {
    Map<String, dynamic> data = jsonDecode(_data);

    int floor = data['floor'];
    String mapUrl = 'images/${floor}fmap.png';
    double mapWidths = mapSize[floor][0];
    double mapHeights = mapSize[floor][1];

    return {
      'url': mapUrl,
      'widths': mapWidths,
      'heights': mapHeights
    };
  }
}