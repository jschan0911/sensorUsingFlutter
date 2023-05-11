import 'package:flutter/material.dart';
import 'package:postgresql2/postgresql.dart' as pg;

// host='220.121.106.85'
// port=5432
// username=postgres
// password=0000
// database=Databases

class PostgreTest extends StatefulWidget {
  const PostgreTest({Key? key}) : super(key: key);

  @override
  State<PostgreTest> createState() => _PostgreTestState();
}

class _PostgreTestState extends State<PostgreTest> {
  final String _host = '220.121.106.85';
  final int _port = 5432;
  final String _username = 'postgres';
  final String _password = '0000';
  final String _databaseName = 'Databases';

  Future<List<pg.Row>> _executeQuery(String query) async {
    var uri = 'postgres://$_username:$_password@$_host:$_port/$_databaseName';
    var conn = await pg.connect(uri);
    var result = await conn.query(query).toList();
    // await conn.close();
    return result;
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
              child: Text('Execute Query'),
              onPressed: () async {
                var query = 'SELECT * FROM my_table';
                var result = await _executeQuery(query);
                print(result);
              },
            ),
          ],
        ),
      ),
    );
  }
}
