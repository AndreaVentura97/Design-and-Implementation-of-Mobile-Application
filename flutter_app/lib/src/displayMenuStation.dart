import 'package:flutter/material.dart';
import 'service.dart';
import 'checkLogin.dart';
import 'messages.dart';
import 'userService.dart';
import 'messagesByDate.dart';

class MenuStation extends StatefulWidget {
  var profile;
  final String name;
  final String line;
  MenuStation({Key key, this.name, this.line}) : super(key: key);
  _MenuStationState createState() => _MenuStationState();

}

class _MenuStationState extends State<MenuStation> {
  final myController = TextEditingController();


  void check() {
    exportProfile().then((myProfile) => setState(() {
      widget.profile = myProfile;
    }));
  }



  @override
  void initState() {
    super.initState();
    check();
  }



  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: Column (
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text ("${widget.name}"),
                  Text ("${widget.line}"),
                  TextField(
                    decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter a comment', ),
                      controller: myController
            ),
                  OutlineButton(
                    child: Text("Send comment"),
                    onPressed: () {
                      var name = widget.profile[0];
                      var email = widget.profile[1];
                      saveMessage(name, email, myController.text, widget.name);
                    },
                  ),
                  OutlineButton(
                    child: Text("Retrieve all comments about this station "),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder:(context)=>
                          Messages(station: widget.name)),);
                    },
                  ),
                  OutlineButton(
                    child: Text("Retrieve the most recent comments about this station "),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder:(context)=>
                          MessagesByDate(station: widget.name)),);
                    },
                  ),
                  OutlineButton(
                    child: Text("Add to my stations"),
                    onPressed: () {
                      addMyStations(widget.profile[1], widget.name);
                    },
                  ),
                ]
            )
        ),
      ),
    );
  }

}


