import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class PostgresPage extends StatefulWidget {
  const PostgresPage({Key? key}) : super(key: key);

  @override
  State<PostgresPage> createState() => _PostgresPageState();
}

class _PostgresPageState extends State<PostgresPage> {
  String text = "hello";

  final String _host = 'database-1.crpiyfwnulnt.ap-northeast-2.rds.amazonaws.com';
  final int _port = 5432;
  final String _username = 'postgres';
  final String _password = 'Soie1003!';
  final String _databaseName = 'indoor_navi_DB';

  void ExecuteQuery(query) async {
    PostgreSQLConnection connection = PostgreSQLConnection(_host, _port, _databaseName, username: _username, password: _password);
    await connection.open();

    List<List<dynamic>> results = await connection.query(query);
    // String _text = results[0][1];
    print(results);
    // print(_text);

    //이 부분 블로깅하자 setState를 안 해서 반영이 안 되는 문제 많이 겪었어 ㅎㅎ
    setState(() {
      // text = _text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Postgres 패키지 실험'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text(text),
          onPressed: () {
            String query = "SELECT * FROM pgr_dijkstra('SELECT id, source, target, cost, reverse_cost FROM edge_table_1f_5',2, 7);";
            ExecuteQuery(query);
          },
        ),
      ),
    );
  }
}
