import 'package:flutter/material.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter_app/src/services/service.dart';
import '../services/adminService.dart';
import 'adminScreenStation.dart';
import 'login.dart';

class AdminScreen extends StatefulWidget {
  AdminScreenState createState() => AdminScreenState();
}

class AdminScreenState extends State<AdminScreen> {
  List stations = [];
  var status;
  var ready = false;



  void listStations() {
    retrieveStations2().then((netStations) =>
        setState(() {
          stations = netStations;
        }));
    setState(() {
      ready = true;
    });

  }

  getColor2(stat){
    if (stat == true){
      return true;
    }
    else {
      return false;
    }
  }



    @override
    void initState() {
      super.initState();
      listStations();
    }


    String getAsset(name) {
      if (name == "Metro M1") {
        return "assets/M1.jpeg";
      }
      if (name == "Metro M2") {
        return "assets/M2.jpeg";
      }
      if (name == "Metro M3") {
        return "assets/M3.jpeg";
      }
      if (name == "Metro M5") {
        return "assets/M5.jpeg";
      }
      if (name == "Metro M1-M2") {
        return "assets/M1-M2.jpeg";
      }
      if (name == "Metro M2-M3") {
        return "assets/M2-M3.jpeg";
      }
      if (name == "Metro M1-M3") {
        return "assets/M1-M3.jpeg";
      }
    }




    Widget build(BuildContext context) {
      return MaterialApp(
          home: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Colors.blue[900],
                leading: IconButton(icon: Icon(Icons.exit_to_app, color: Colors.white), onPressed: (){Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
                  return Login();
                }));}),
                title: Text("Stations"),
                actions: [
                  IconButton(icon: Icon(Icons.refresh), onPressed:  (){Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
                    return AdminScreen();
                  }));}),
                ],
              ),
              body: (ready) ? ListView.builder(
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
                                      image: AssetImage(
                                          getAsset(stations[index]['line'])),
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
                                  color : (stations[index]['_id']) ?  Colors.red : Colors.blue[900],
                                  size: 20,
                                ),
                                Icon(
                                  Icons.circle,
                                  color: (getColor2(stations[index]['status'])) ? Colors.green : Colors.red,
                                  size: 15,
                                ),
                              ],
                            )
                          ],
                        ),
                        onTap: () =>
                        {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AdminScreenStation(
                                          name: stations[index]['name'])))
                        }),
                  );
                },
              ): null));

    }
  }

