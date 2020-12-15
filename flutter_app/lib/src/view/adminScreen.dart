import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    listStations();
  }

  Widget build(BuildContext context) {
    return MaterialApp(

        home: Scaffold(
            appBar: AppBar(
              title: Text("Stations"),
            ),
            body: ListView.builder(
              //shrinkWrap: true,
              itemCount: stations.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  contentPadding: EdgeInsets.all(10.0),
                  title: Text(stations[index]['name'],
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)),
                  onTap: () => { Navigator.push(context, MaterialPageRoute(builder:(context)=> AdminScreenStation(name: stations[index]['name'])))}
                );
              },
            )



        ));
  }



}