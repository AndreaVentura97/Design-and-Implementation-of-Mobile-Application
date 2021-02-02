import 'package:flutter/material.dart';
import 'package:delayed_display/delayed_display.dart';
import '../services/adminService.dart';
import 'adminScreenStation.dart';

class AdminScreen extends StatefulWidget {
  AdminScreenState createState() => AdminScreenState();
}

class AdminScreenState extends State<AdminScreen> {
  List stations = [];

  void listStations() {
    retrieveStations().then((netStations) => setState(() {
          stations = netStations;
        }));
  }

  String getAsset(name){
    if (name == "Metro M1"){
      return "assets/M1.jpeg";
    }
    if (name == "Metro M2"){
      return "assets/M2.jpeg";
    }
    if (name == "Metro M3"){
      return "assets/M3.jpeg";
    }
    if (name == "Metro M5"){
      return "assets/M5.jpeg";
    }
  }

  @override
  void initState() {
    super.initState();
    listStations();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.blue[900],
              title: Text("Stations"),
            ),
            body: ListView.builder(
              //shrinkWrap: true,
              itemCount: stations.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                  elevation: 3.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                      color: Colors.blue[900],
                      width: 2.0,
                    ),
                  ),
                  child: ListTile(
                      //contentPadding: EdgeInsets.all(10.0),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                child: DelayedDisplay(
                                  delay: Duration(milliseconds: 500),
                                  child: Image(
                                    image: AssetImage(getAsset(stations[index]['line'])),
                                    height: 30.0,
                                    width: 45.0,
                                  ),
                                ),
                              ),
                              SizedBox(width: 5,),
                              Text(stations[index]['name'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black)
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.notifications_active,
                                color: Colors.blue[900],
                                size: 20,
                              ),
                              Icon(
                                Icons.circle,
                                color: Colors.red,
                                size: 15,
                              ),
                            ],
                          )
                        ],
                      ),
                      onTap: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AdminScreenStation(
                                        name: stations[index]['name'])))
                          }),
                );
              },
            )));
  }
}
