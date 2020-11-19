import 'package:flutter/material.dart';
import 'src/login.dart';
import 'src/db.dart' as DB;
import 'package:sevr/sevr.dart';
import 'package:mongo_dart/mongo_dart.dart';

final server = new Sevr();
const port = 8081;
void main() {
  server.listen(port, callback: () {
    print('Server listening on port: $port');
  });
  DB.start();





  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Login ()
    );
  }
}


