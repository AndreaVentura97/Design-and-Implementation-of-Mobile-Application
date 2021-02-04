import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/checkLogin.dart';
import 'package:flutter_app/src/view/notificationWidget.dart';
import 'package:flutter_app/src/view/userAccountWidget.dart';

class Notification extends StatefulWidget {
  List <String> notifications;
  Notification({Key key, this.notifications}) : super(key: key);
  @override
  NotificationState createState() => NotificationState();
}

class NotificationState extends State<Notification> {

  myNotifications() {
    getMessages().then((result) => setState((){
      if (result!=null){
        widget.notifications = result;
        widget.notifications = new List.from(widget.notifications.reversed);
      }
      else {
        widget.notifications = [];
      }

    }));
  }

  @override
  void initState() {
    myNotifications();
    super.initState();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue[900],
              title: Row(
                children: [
                  Text("Notification"),
                  NotificationWidget(),
                ],
              ),
            ),
            drawer: UserAccount(),
            body: Stack(
              children: [

                Stack(children: [
                  Container(
                    color: Colors.white,
                    child: Center(
                      child: Container(
                        height: 300,
                        width: 200,
                        color: Colors.white,
                        child: FittedBox(
                          child: Image.asset(
                              'assets/Logo_MeMiQ_2.png',
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Container(
                  //   color: Color.fromRGBO(255, 255, 255, 0.3),
                  // )
                ]),
                (widget.notifications.length!=0)
                    ? ListView.builder(
                  //shrinkWrap: true,
                  itemCount: widget.notifications.length,
                  itemBuilder: (BuildContext context, int index) {
                    return (widget.notifications[index]!=null) ?
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Card(
                          margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                          elevation: 3.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(
                              color: Colors.blue[900],
                              width: 2.0,
                            ),
                          ),
                          child: Container(
                            margin: EdgeInsets.all(8),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Flexible(
                                  child: Text(widget.notifications[index],
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)),
                                ),
                                Container(width: 30, child: IconButton(icon: Icon(Icons.close), onPressed: null))
                              ],
                            ),
                          ),
                        ),
                      ) 
                          : Text('');
                  },
                )
                    :  Center(
                    child: Container(
                      width: 200,
                      child: Text("You don't have new notifications",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blue[900],
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                ),
              ],
            ),


        ));
  }

}
