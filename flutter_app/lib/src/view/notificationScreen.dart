import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/view/notificationWidget.dart';
import 'package:flutter_app/src/view/userAccountWidget.dart';

class Notification extends StatefulWidget {
  List <String> notifications;
  Notification({Key key, this.notifications}) : super(key: key);
  @override
  NotificationState createState() => NotificationState();
}

class NotificationState extends State<Notification> {

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return MaterialApp(

        home: Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  Text("My Notification"),
                  NotificationWidget(),
                ],
              ),
            ),
<<<<<<< HEAD
            drawer: UserAccount(),
=======
>>>>>>> 7544a1657651c3210c12bc374f5048aca8be625a
            body: ListView.builder(
              //shrinkWrap: true,
              itemCount: widget.notifications.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  contentPadding: EdgeInsets.all(10.0),
                  title: Text(widget.notifications[index],
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)),
                );
              },
            )



        ));
  }

}
