import 'package:flutter/material.dart';
import 'src/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'src/db.dart' as DB;
import 'package:sevr/sevr.dart';
import 'package:mongo_dart/mongo_dart.dart';

final server = new Sevr();
const port = 8081;
void main () async {
  server.listen(port, callback: () {
    print('Server listening on port: $port');
  });
  DB.start();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();




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


