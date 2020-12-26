import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class Notification extends StatefulWidget {

  @override
  NotificationState createState() => NotificationState();
}

class NotificationState extends State<Notification> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String _message = '';

  _registerOnFirebase() {
    _firebaseMessaging.getToken().then((token) => print(token));
  }

  @override
  void initState() {
    _registerOnFirebase();
    getMessage();
    super.initState();
  }

  void getMessage() {
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print('received message1');
          setState(() => _message = message["notification"]["body"]);
        }, onResume: (Map<String, dynamic> message) async {
      print('on resume $message');
      setState(() => _message = message["notification"]["body"]);
    }, onLaunch: (Map<String, dynamic> message) async {
      print('on launch $message');
      setState(() => _message = message["notification"]["body"]);
    },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Push Notifications Test'),
      ),
      body: Container(
          child: Center(
            child: Text("Message: $_message"),
          )),
    );
  }
}
