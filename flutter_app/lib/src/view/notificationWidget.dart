import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';




class NotificationWidget extends StatefulWidget {
  @override
  _NotificationWidgetState createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  bool yes=false;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  List<String> messages = [];

  void initState() {
    getMessage();
    super.initState();

  }

  void getMessage() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('received message2');
        setState(() => messages.add(message["notification"]["body"]));
        setState(() => yes = true);
      }, onResume: (Map<String, dynamic> message) async {
      print('on resume $messages');
      setState(() => messages.add(message["notification"]["body"]));
      setState(() => yes = true);
    }, onLaunch: (Map<String, dynamic> message) async {
      print('on launch $messages');
      setState(() => messages.add(message["notification"]["body"]));
      setState(() => yes = true);
    },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.notifications, color:(yes) ? Colors.red : Colors.black);
  }
}