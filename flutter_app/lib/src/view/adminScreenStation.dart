import 'package:flutter/material.dart';
import 'package:flutter_app/src/services/sendNotification.dart';
import '../services/service.dart';
import '../checkLogin.dart';
import 'messages.dart';
import '../services/userService.dart';
import '../checkLogin.dart';
import '../services/adminService.dart';

class AdminScreenStation extends StatefulWidget {
  final String name;

  AdminScreenStation({Key key, this.name}) : super(key: key);
  AdminScreenStationState createState() => AdminScreenStationState();

}

class AdminScreenStationState extends State<AdminScreenStation> {

  bool _value;

  void updateValue(station) {
    retrieveStatus(widget.name).then((netStatus) => setState(() {
      _value = netStatus;
    }));
  }

  @override
  void initState() {
    super.initState();
    updateValue(widget.name);
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
                  DropdownButton(
                    value: _value,
                    items: [
                    DropdownMenuItem(
                      child: Text("True"),
                      value: true,
                  ),
                      DropdownMenuItem(
                        child: Text("False"),
                        value: false,
                      ),
                  ],
                    onChanged: (value) {
                      setState(() {
                        _value = value;
                      });

                    }),
                  OutlineButton(
                    child: Text("Submit"),
                    onPressed: () {
                      setStatus(widget.name,_value);
                      if (_value == true){
                        sendNotification2(widget.name, "ok");
                      }
                      else {
                        sendNotification2(widget.name, "late");
                      }
                      },
                  ),
                ]
            )
        ),
      ),
    );
  }

}