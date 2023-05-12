import 'package:flutter/material.dart';
import 'package:postgresql2/postgresql.dart' as pg;

// host name : database-1.crpiyfwnulnt.ap-northeast-2.rds.amazonaws.com
// port : 5432
// username=postgres
// password=Soie1003!
// database=indoor_navi_DB

class PostgreTest extends StatefulWidget {
  const PostgreTest({Key? key}) : super(key: key);

  @override
  State<PostgreTest> createState() => _PostgreTestState();
}

class _PostgreTestState extends State<PostgreTest> {
  final String _host = 'database-1.crpiyfwnulnt.ap-northeast-2.rds.amazonaws.com';
  final int _port = 5432;
  final String _username = 'postgres';
  final String _password = 'Soie1003!';
  final String _databaseName = 'indoor_navi_DB';

  String _data = 'default';

  // Future<List<pg.Row>> _executeQuery(String query) async {
  //   var uri = 'postgres://$_username:$_password@$_host:$_port/$_databaseName';
  //   var conn = await pg.connect(uri);
  //   var result = await conn.query(query).toList();
  //   // await conn.close();
  //   return result;
  // }

  Future<int> _executeQuery(String query) async {
    int a = 0;
    var uri = 'postgres://$_username:$_password@$_host:$_port/$_databaseName';
    try {
      var conn = await pg.connect(uri);
      var result = await conn.query(query).toList();
      a = 1;
    } catch(e) {
      a = 0;
    }
    var conn = await pg.connect(uri);
    var result = await conn.query(query).toList();
    //     // await conn.close();

    a = 1;
    return a;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter PostgreSQL2 Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text(_data),
              onPressed: () async {
                var query = 'SELECT * FROM account_test';
                var result = await _executeQuery(query);
                _data = "hello";
              },
            ),
          ],
        ),
      ),
    );
  }
}
