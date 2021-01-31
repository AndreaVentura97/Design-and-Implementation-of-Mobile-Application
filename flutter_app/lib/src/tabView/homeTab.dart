import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'MapWidget.dart';
import 'tabDrawerWidget.dart';
//import '../view/InfoProfileScreen.dart';

class HomeTab extends StatefulWidget {
  HomeTabState createState() => HomeTabState();
}

class HomeTabState extends State<HomeTab> {
  @override
  void initState() {
    HomeTabState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Flexible(
              flex: 4,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.blue[900],
                ),
                drawer: TabDrawer(),
                body: Stack(
                  children: [
                    Stack(
                          children: [
                            Center(
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
                            Container(color: Color.fromRGBO(255, 255, 255, 0.5),)
                          ]
                        ),


                    // Positioned(
                    //   top: 10.0,
                    //   left: 15.0,
                    //   right: 60.0,
                    //   child: Container(
                    //     padding: EdgeInsets.all(3.5),
                    //     decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       border: Border.all(
                    //         color: Colors.blue[900],
                    //         width: 2.0,
                    //       ),
                    //       borderRadius: BorderRadius.circular(10.0),
                    //     ),
                    //     child: Column(
                    //       children: [
                    //         Row(
                    //           mainAxisSize: MainAxisSize.min,
                    //           children: [
                    //             Flexible(
                    //               child: TextField(
                    //                 controller: _controller,
                    //                 textAlign: TextAlign.start,
                    //                 style: TextStyle(
                    //                     fontSize: 18,
                    //                     fontWeight: FontWeight.w500,
                    //                     color: Colors.black),
                    //                 decoration: InputDecoration(
                    //                   contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                    //                   isDense: true,
                    //                   fillColor: Colors.white,
                    //                   filled: true,
                    //                   hintText: 'Search Station',
                    //                   hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                    //                   enabledBorder:
                    //                   // UnderlineInputBorder(
                    //                   //   borderSide: BorderSide(
                    //                   //     color: Colors.blue[900],
                    //                   //     width: 2.0,
                    //                   //   ),
                    //                   //   //borderRadius: BorderRadius.circular(10.0),
                    //                   // ),
                    //                   InputBorder.none,
                    //                   focusedBorder:
                    //                   // UnderlineInputBorder(
                    //                   //   borderSide: BorderSide(
                    //                   //     color: Colors.blue[900],
                    //                   //     width: 2.0,
                    //                   //   ),
                    //                   //   //borderRadius: BorderRadius.circular(10.0),
                    //                   // ),
                    //                   InputBorder.none,
                    //                 ),
                    //                 onChanged: updateStations,
                    //               ),
                    //             ),
                    //             IconButton(
                    //               icon: Icon(
                    //                 Icons.clear,
                    //                 size: 16.0,
                    //               ),
                    //               padding: EdgeInsets.zero,
                    //               constraints: BoxConstraints(),
                    //               onPressed: () {
                    //                 _controller.clear();
                    //                 updateStations('null');
                    //               },
                    //             ),
                    //           ],
                    //         ),
                    //
                    //
                    //         ConstrainedBox(
                    //           constraints: BoxConstraints(
                    //             maxHeight: 200,
                    //           ),
                    //           child: ListView.separated(
                    //             shrinkWrap: true,
                    //             itemCount: stations.length,
                    //             itemBuilder: (BuildContext context, int index) {
                    //               return ListTile(
                    //                 tileColor: Colors.white,
                    //                 contentPadding:
                    //                 EdgeInsets.symmetric(horizontal: 5.0),
                    //                 leading: Container(
                    //                   child: Image(
                    //                     image: AssetImage(checkLine(stations[index])),
                    //                     height: 30.0,
                    //                     width: 45.0,
                    //                   ),
                    //                 ),
                    //                 title: Text(stations[index]["name"],
                    //                     style: TextStyle(
                    //                         fontSize: 20,
                    //                         fontWeight: FontWeight.w500,
                    //                         color: Colors.black)),
                    //                 onTap: () => {
                    //                   setState((){
                    //                     targetPosition = CameraPosition(
                    //                         target: LatLng(stations[index]['latitude'],stations[index]['longitude']),
                    //                         zoom: 16.5);
                    //                     CameraUpdate update =CameraUpdate.newCameraPosition(targetPosition);
                    //                     //mapController.moveCamera(update);
                    //                     mapController.animateCamera(update);
                    //                     //_controller.clear();
                    //                     stations.clear();
                    //                   })},
                    //                 onLongPress: () => {
                    //                   Navigator.push(
                    //                       context,
                    //                       MaterialPageRoute(
                    //                           builder: (context) => MenuStation(
                    //                               name: stations[index]['name'])))
                    //                 },
                    //
                    //
                    //                 dense: true,
                    //               );
                    //             },
                    //             separatorBuilder: (BuildContext context, int index) {
                    //               return Divider(color: Colors.grey, thickness: 1);
                    //             },
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // ]
                    // )
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 7,
              child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: MapWidget()),
            ),
          ],
        ),
      ),
    );
  }
}
