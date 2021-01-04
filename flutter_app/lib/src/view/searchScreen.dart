

import 'package:flutter/material.dart';
import 'displayMenuStation.dart';
import '../services/stationServices.dart';

class Search extends StatefulWidget {
  SearchState createState() => SearchState();
}

class SearchState extends State<Search> {
  List stations = [];

  void updateStations(String search) {
    searchStationByName(search).then((netStations) => setState(() {
      stations = netStations;
    }));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stations"),
      ),
      body : Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
            onChanged: updateStations,
          ),

          Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: stations.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      contentPadding: EdgeInsets.all(10.0),
                      title: Text(stations[index]["name"],
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black)),
                      onTap: () => {
                      Navigator.push(context, MaterialPageRoute(builder:(context)=>MenuStation(name:stations[index]['name'])))
                      });
                },
              ))
        ],
      ),
    );
  }
}