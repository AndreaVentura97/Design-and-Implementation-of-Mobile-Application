import 'package:flutter/material.dart';
import 'package:flutter_app/src/tabView/tabDrawerWidget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import '../services/service.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart' show rootBundle;
//import 'displayMenuStation.dart';
import '../services/stationServices.dart';

import 'tabDrawerWidget.dart';

class TabSearch extends StatefulWidget {
  @override
  TabSearchState createState() => TabSearchState();
}

class TabSearchState extends State<TabSearch> {
  Set<Marker> _markers;
  GoogleMapController mapController;
  final TextEditingController _controller= TextEditingController();
  List stations = [];
  String mapStyle;
  var cameraPosition = CameraPosition(
    target:  LatLng(45.456532, 9.125001),
    zoom: 12.0,
  );
  var targetPosition;


  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.setMapStyle(mapStyle);
  }

  void setMarkers() async {
    var response = await retrieveMarkers();
    buildMarkers(response, context).then((result) => setState((){
      _markers = result;
    }));
  }

  String checkLine(station){
    if (station['line']=="Metro M1"){
      return "assets/M1.jpeg";
    }
    if (station['line']=="Metro M2"){
      return "assets/M2.jpeg";
    }
    if (station['line']=="Metro M3"){
      return "assets/M3.jpeg";
    }
    if (station['line']=="Metro M5"){
      return "assets/M5.jpeg";
    }
  }

  void _getLocationPermission() async {
    var location = new Location();
    try {
      location.requestPermission();
    } on Exception catch (_) {
      print('There was a problem allowing location access');
    }
  }

  void updateStations(String search) {
    searchStationByName(search).then((netStations) => setState(() {
      stations = netStations;
    }));
  }

  void initState() {
    super.initState();
    setMarkers();
    rootBundle.loadString('assets/mapStyle.txt').then((string) {
      mapStyle = string;
    });
    _getLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Search Stations', style: TextStyle(fontSize: 25,)),
          backgroundColor: Colors.blue[900],
        ),
        drawer: TabDrawer(),
        body: Container(
          child: Stack(
            children: [
              Stack(children: [
                Container(
                  color: Colors.white,
                  child: Center(
                    child: Container(
                      height: 300,
                      width: 200,
                      child: FittedBox(
                        child: Image.asset(
                          'assets/Logo_Name.jpeg',
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Color.fromRGBO(255, 255, 255, 0.3),
                )
              ]),
              Column(
                        children: [
                          Container(
                            color: Colors.grey[300],
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                        child: TextField(
                                          controller: _controller,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                                            isDense: true,
                                            fillColor: Colors.grey[300],
                                            filled: true,
                                            hintText: 'Search Station',
                                            hintStyle: TextStyle(color: Colors.grey, fontSize: 22),
                                            enabledBorder:
                                            // UnderlineInputBorder(
                                            //   borderSide: BorderSide(
                                            //     color: Colors.blue[900],
                                            //     width: 2.0,
                                            //   ),
                                            //   //borderRadius: BorderRadius.circular(10.0),
                                            // ),
                                            InputBorder.none,
                                            focusedBorder:
                                            // UnderlineInputBorder(
                                            //   borderSide: BorderSide(
                                            //     color: Colors.blue[900],
                                            //     width: 2.0,
                                            //   ),
                                            //   //borderRadius: BorderRadius.circular(10.0),
                                            // ),
                                            InputBorder.none,
                                          ),
                                          onChanged: updateStations,
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.clear,
                                          size: 25.0,
                                        ),
                                        padding: EdgeInsets.zero,
                                        constraints: BoxConstraints(),
                                        onPressed: () {
                                          _controller.clear();
                                          updateStations('null');
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: 1,
                                  thickness: 1.0,
                                  //indent: 10, endIndent: 10,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                                //shrinkWrap: true,
                                itemCount: stations.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Card(
                                    margin: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 0.0),
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
                                      child: ListTile(
                                        tileColor: Colors.white,
                                        contentPadding:
                                        EdgeInsets.symmetric(horizontal: 5.0),
                                        leading: Container(
                                          child: Image(
                                            image: AssetImage(checkLine(stations[index])),
                                            height: 40.0,
                                            width: 60.0,
                                          ),
                                        ),
                                        title: Text(stations[index]["name"],
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black)),
                                        onTap: () => {
                                          setState((){
                                            targetPosition = CameraPosition(
                                                target: LatLng(stations[index]['latitude'],stations[index]['longitude']),
                                                zoom: 16.5);
                                            CameraUpdate update =CameraUpdate.newCameraPosition(targetPosition);
                                            //mapController.moveCamera(update);
                                            mapController.animateCamera(update);
                                            //_controller.clear();
                                            stations.clear();
                                          })},
                                        // onLongPress: () => {
                                        //   Navigator.push(
                                        //       context,
                                        //       MaterialPageRoute(
                                        //           builder: (context) => MenuStation(
                                        //               name: stations[index]['name'])))
                                        // },


                                        dense: true,
                                      ),
                                    ),
                                  );
                                },
                                // separatorBuilder: (BuildContext context, int index) {
                                //   return Divider(color: Colors.grey, thickness: 1);
                                // },
                              ),
                          ),
                        ],
                      ),
            ],
          ),
        ),

        );
  }
}

