import 'package:flutter/material.dart';
import 'package:flutter_app/src/services/sendNotification.dart';
import 'package:flutter_app/src/view/listViewAdminWidget.dart';
import 'adminScreen.dart';
import '../services/adminService.dart';
import 'listViewAdminWidget.dart';


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
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(icon: Icon(Icons.arrow_back_outlined, color: Colors.white), onPressed: (){Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
              return AdminScreen();
            }));}),
            title: Text("${widget.name}"),
            backgroundColor: Colors.blue[900],
          ),
          body: Center(
              child: Column (
                  children: [
                    Container(
                      color: Colors.grey[300],
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Card(
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
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text ("Status:",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.blue[900]
                                    ),
                                  ),
                                  DropdownButton(
                                    value: _value,
                                    items: [
                                    DropdownMenuItem(
                                      child: Row(
                                        children: [
                                          Icon(Icons.circle, color: Colors.green,size: 15,),
                                          Text(" Active")
                                        ],
                                      ),
                                      value: true,
                                  ),
                                      DropdownMenuItem(
                                        child: Row(
                                          children: [
                                            Icon(Icons.circle, color: Colors.red,size:15),
                                            Text(" Inactive")
                                          ],
                                        ),
                                        value: false,
                                      ),
                                  ],
                                    onChanged: (value) {
                                      setState(() {
                                        _value = value;
                                      });
                                    }),

                                ],
                              ),
                              FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                color: Colors.blue[900],
                                child: Text(
                                  "Submit change",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                  ),
                                ),
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
                            ],
                          ),
                        ),
                      ),
                      Container(
                          //color: Colors.grey[300],
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  //color: Colors.red,
                                  padding: EdgeInsets.fromLTRB(10,10,10,10),
                                  child: Text("Reports",
                                        style: TextStyle(
                                            fontSize: 22,
                                          color: Colors.blue[900],
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                ),
                                Divider(
                                  thickness: 2.0,
                                  height: 1,
                                  color: Colors.black,
                                ),
                              ]
                          )
                      ),
                    ]
              ),
                  ),
               ListViewAd(name:widget.name),






      ])
        )
      ),
    );

  }


}