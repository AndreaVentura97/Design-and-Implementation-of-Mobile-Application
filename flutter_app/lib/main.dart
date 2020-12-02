import 'package:flutter/material.dart';
import 'src/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'src/db.dart' as DB;
import 'package:sevr/sevr.dart';
import 'src/profile.dart';
import 'src/checkLogin.dart';
import 'package:shared_preferences/shared_preferences.dart';

final server = new Sevr();
const port = 8081;
SharedPreferences prefs;
void main () async {
  server.listen(port, callback: () {
    print('Server listening on port: $port');
  });
  DB.start();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //prefs = await returnPrefs();
  //if (await prefs.getBool("pref_logG") || await prefs.getBool("pref_logM") || await prefs.getBool("pref_logF")){
    //print(await prefs.getBool("pref_logG"));
    //runApp(Profile());
  //}



  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  bool flag;

  MyApp({Key key, this.flag}) : super(key: key);

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


