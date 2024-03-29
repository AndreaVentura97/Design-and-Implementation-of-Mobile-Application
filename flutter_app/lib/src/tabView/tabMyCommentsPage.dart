import 'package:flutter/material.dart';
import 'package:flutter_app/src/services/sendNotification.dart';
import 'package:flutter_app/src/view/userAccountWidget.dart';
import 'package:flutter_app/redux/model/AppState.dart';
import 'package:flutter_app/src/view/viewModel.dart';
import 'package:flutter_app/src/services/stationServices.dart';
import '../view/displayMenuStation.dart';
import '../services/service.dart';
import '../services/messagesService.dart';
import '../services/userService.dart';
import '../services/stationServices.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_app/redux/model/AppState.dart';
import 'package:flutter_app/redux/model/customer.dart';
import 'package:delayed_display/delayed_display.dart';
import '../services/stationServices.dart';
import '../services/service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../services/service.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../services/stationServices.dart';
import 'tabDrawerWidget.dart';


class TabMyComments extends StatefulWidget {
  String station;
  TabMyComments({Key key, this.station}) : super(key: key);
  TabMyCommentsState createState() => TabMyCommentsState();
}


class TabMyCommentsState extends State<TabMyComments> {
  List myComments = [];
  List myCommentsInteractions = [];
  var valueDrop = "Date";
  var ready = false;
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




  void retrieveMyComments(email) {
    getMyComments(email).then( ((netComments) => setState(() {
      myComments = new List.from(netComments.reversed);
      for (int i = 0; i < myComments.length; i++){
        informationStationByName(myComments[i]['station']).then((result) => setState((){
          myComments[i]['_id'] = result['line'];

        }));
      }

    })));
    getMyComments(email).then( ((netComments) => setState(() {
      myCommentsInteractions = orderListByInteractions(netComments);
      for (int i = 0; i < myCommentsInteractions.length; i++){
        informationStationByName(myCommentsInteractions[i]['station']).then((result) => setState((){
          myCommentsInteractions[i]['_id'] = result['line'];
        }));

      }

    })));
    ready = true;
  }




  @override
  void dispose() {
    super.dispose();
  }

  AssetImage buildAsset(name){
    if (name == "Metro M1"){
      return AssetImage("assets/M1.jpeg");
    }
    if (name == "Metro M2"){
      return AssetImage("assets/M2.jpeg");
    }
    if (name == "Metro M3"){
      return AssetImage("assets/M3.jpeg");
    }
    if (name == "Metro M5"){
      return AssetImage("assets/M5.jpeg");
    }
    if (name == "Metro M1-M2"){
      return AssetImage("assets/M1-M2.jpeg");
    }
    if (name == "Metro M1-M3"){
      return AssetImage("assets/M1-M3.jpeg");
    }
    if (name == "Metro M2-M3"){
      return AssetImage("assets/M2-M3.jpeg");
    }
  }

  void setMarkers() async {
    var response = await retrieveMarkers();
    buildTabMarkers(response, context).then((result) => setState((){
      _markers = result;
    }));
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
  @override
  void initState() {
    TabMyCommentsState();
    super.initState();
    setMarkers();
    rootBundle.loadString('assets/mapStyle.txt').then((string) {
      mapStyle = string;
    });
    _getLocationPermission();
  }

  Widget build(BuildContext context) {
    return new StoreConnector <AppState,ViewModel>(
        converter : (store) => createViewModel(store),
        onInit: (store) => retrieveMyComments(store.state.customer.email),
        builder: (context,_viewModel) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue[900],
              title: Text("My Comments", style: TextStyle(fontSize: 25,)),
            ),
            drawer: TabDrawer(),
            body: SafeArea(
              child: Row(
                children: [
                  Flexible(
                    flex: 4,
                    child: DelayedDisplay(
                      delay: Duration(milliseconds:1000),
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
                                      'assets/Logo_MeMiQ_2.png',
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
                                  child:Column(
                                      children: [
                                        Container(
                                          //color: Colors.red,
                                          padding: EdgeInsets.fromLTRB(10,10,10,10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Sorted by:",
                                                style: TextStyle(
                                                    fontSize: 22
                                                ),
                                              ),
                                              DropdownButton(
                                                  value: valueDrop,
                                                  items: [
                                                    DropdownMenuItem(
                                                      child: Text("Date", style: TextStyle(fontSize: 22),),
                                                      value: "Date",
                                                    ),
                                                    DropdownMenuItem(
                                                      child: Text("Interactions", style: TextStyle(fontSize: 22),),
                                                      value: "Interactions",
                                                    ),
                                                  ],
                                                  icon: Icon(Icons.arrow_drop_down, size: 30,),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      valueDrop = value;
                                                    });
                                                  })
                                            ],

                                          ),
                                        ),
                                        Divider(
                                          thickness: 1.0,
                                          height: 1,
                                          color: Colors.black,
                                        ),
                                      ]
                                  )
                              ),
                              Expanded(
                                child: (valueDrop == "Date") ? ListView.builder(
                                  //shrinkWrap: true,
                                  itemCount: myComments.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder:(context)=>MenuStation(name:myComments[index]['station'])));
                                      },
                                      child: Column(
                                        children: [
                                          Card(
                                            margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
                                            elevation: 3.0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                              side: BorderSide(
                                                color: Colors.blue[900],
                                                width: 2.0,
                                              ),
                                            ),
                                            child: Container(
                                              //color: Colors.blue,
                                              margin: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 10.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    //color: Colors.green,
                                                    child: ListTile(
                                                      dense: true,
                                                      contentPadding: EdgeInsets.all(0.0),
                                                      title: Row(
                                                        children: [
                                                          Container(
                                                              child: DelayedDisplay(
                                                                delay: Duration(seconds:1),
                                                                child: InkWell(
                                                                    child: Image(
                                                                      image: buildAsset(myComments[index]['_id']),
                                                                      height: 40.0,
                                                                      width: 60.0,
                                                                    ),
                                                                    onTap: (){
                                                                      Navigator.push(context, MaterialPageRoute(builder:(context)=>MenuStation(name:myComments[index]['station'])));
                                                                    }
                                                                ),
                                                              )
                                                          ),
                                                          SizedBox(width: 10.0,),
                                                          IntrinsicWidth(
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(myComments[index]['station'],
                                                                    style: TextStyle(
                                                                        fontSize: 25,
                                                                        fontWeight: FontWeight.w500,
                                                                        color: Colors.black
                                                                    )
                                                                ),
                                                                Container(
                                                                  //color: Colors.black,
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      Text(myComments[index]['date'],
                                                                        style: TextStyle(
                                                                          fontSize: 18.0,
                                                                          letterSpacing: 0.5,
                                                                          color: Colors.grey,
                                                                        ),
                                                                      ),

                                                                      //
                                                                      // Da cambiare in base se cittadino o visitatiore
                                                                      // Text('Citizen',
                                                                      //   style: TextStyle(
                                                                      //     fontSize: 15.0,
                                                                      //     color: Colors.grey,
                                                                      //   ),
                                                                      // ),

                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      trailing: IconButton(
                                                          icon: Icon(Icons.close, size: 25,),
                                                          onPressed: (){
                                                            deleteMyComment(myComments[index]['text'], myComments[index]['station'], myComments[index]['name']);
                                                            setState(() {
                                                              myCommentsInteractions = removeFromList(myCommentsInteractions,myComments[index]['text'], myComments[index]['station'], myComments[index]['email']);
                                                              myComments.remove(myComments[index]);
                                                            });
                                                      }),
                                                    ),
                                                  ),
                                                  Container(
                                                    //color: Colors.red,
                                                    child: Text(myComments[index]['text'],
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            letterSpacing: 0.5,
                                                            fontWeight: FontWeight.w500,
                                                            color: Colors.black
                                                        )
                                                    ),
                                                  ),
                                                  Container(
                                                    //color: Colors.yellow,
                                                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Icon(Icons.thumb_up,
                                                          size: 30.0,
                                                          color: Colors.green,
                                                        ),
                                                        Text(" ${myComments[index]['nl']} ", style: TextStyle(fontSize: 20),),
                                                        Icon(Icons.thumb_down,
                                                          size: 30.0,
                                                          color: Colors.red,
                                                        ),
                                                        Text(" ${myComments[index]['nu']} ", style: TextStyle(fontSize: 20),),
                                                      ],
                                                    ),
                                                  ),


                                                ],
                                              ),

                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ) : ListView.builder(
                                  //shrinkWrap: true,
                                  itemCount: myCommentsInteractions.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder:(context)=>MenuStation(name:myComments[index]['station'])));
                                      },
                                      child: Column(
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
                                              //color: Colors.blue,
                                              margin: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 10.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    //color: Colors.green,
                                                    child: ListTile(
                                                      dense: true,
                                                      contentPadding: EdgeInsets.all(0.0),
                                                      title: Row(
                                                        children: [
                                                          Container(
                                                              child: DelayedDisplay(
                                                                delay: Duration(seconds:1),
                                                                child: InkWell(
                                                                    child: Image(
                                                                      image: buildAsset(myCommentsInteractions[index]['_id']),
                                                                      height: 30.0,
                                                                      width: 45.0,
                                                                    ),
                                                                    onTap: (){
                                                                      Navigator.push(context, MaterialPageRoute(builder:(context)=>MenuStation(name:myCommentsInteractions[index]['station'])));
                                                                    }
                                                                ),
                                                              )
                                                          ),
                                                          SizedBox(width: 10.0,),
                                                          IntrinsicWidth(
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(myCommentsInteractions[index]['station'],
                                                                    style: TextStyle(
                                                                        fontSize: 20,
                                                                        fontWeight: FontWeight.w500,
                                                                        color: Colors.black
                                                                    )
                                                                ),
                                                                Container(
                                                                  //color: Colors.black,
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      Text(myCommentsInteractions[index]['date'],
                                                                        style: TextStyle(
                                                                          fontSize: 15.0,
                                                                          color: Colors.grey,
                                                                        ),
                                                                      ),

                                                                      //
                                                                      // Da cambiare in base se cittadino o visitatiore
                                                                      // Text('Citizen',
                                                                      //   style: TextStyle(
                                                                      //     fontSize: 15.0,
                                                                      //     color: Colors.grey,
                                                                      //   ),
                                                                      // ),

                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      trailing: IconButton(icon: Icon(Icons.close), onPressed: (){
                                                        deleteMyComment(myCommentsInteractions[index]['text'], myCommentsInteractions[index]['station'], myCommentsInteractions[index]['name']);
                                                        setState(() {
                                                          myComments = removeFromList(myComments,myCommentsInteractions[index]['text'], myCommentsInteractions[index]['station'], myCommentsInteractions[index]['email']);
                                                          myCommentsInteractions.remove(myCommentsInteractions[index]);
                                                        });
                                                      }),
                                                    ),
                                                  ),
                                                  Container(
                                                    //color: Colors.red,
                                                    child: Text(myCommentsInteractions[index]['text'],
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.w500,
                                                            color: Colors.black
                                                        )
                                                    ),
                                                  ),
                                                  Container(
                                                    //color: Colors.yellow,
                                                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Icon(Icons.thumb_up,
                                                          size: 25.0,
                                                          color: Colors.green,
                                                        ),
                                                        Text(" ${myCommentsInteractions[index]['nl']} "),
                                                        Icon(Icons.thumb_down,
                                                          size: 25.0,
                                                          color: Colors.red,
                                                        ),
                                                        Text(" ${myCommentsInteractions[index]['nu']} "),
                                                      ],
                                                    ),
                                                  ),


                                                ],
                                              ),

                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
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
                        child: Scaffold(
                          resizeToAvoidBottomPadding: false,
                          resizeToAvoidBottomInset: false,
                          //drawer: UserAccount(),
                          body: //Stack(children: [
                          GoogleMap(
                            onMapCreated: _onMapCreated,
                            initialCameraPosition: cameraPosition,
                            markers: _markers,
                            myLocationEnabled: true,
                            myLocationButtonEnabled: true,
                          ),
                        )
                    ),
                  ),

                ],
              ),
            ),
          );
              // : Scaffold(
              // appBar: AppBar(
              //   title: Text("My Comments"),
              // ),
              // drawer: UserAccount())

        });
  }

  Widget showAlert() {
//   if (_error != null)
//     return Container(
//       color: Colors.amber,
//       width: double.infinity,
//       padding: EdgeInsets.all(8.0),
//       child: Row(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(right: 8.0),
//             child: Icon(Icons.error_outline),
//           ),
//           Expanded(
//             child: AutoSizeText(
//               "$_error",
//               maxLines: 3,
//             ),
//           ),
//           IconButton(
//               icon: Icon(Icons.close),
//               onPressed: () {
//                 setState(() {
//                   _error = null;
//                 });
//               })
//         ],
//       ),
//     );
//   return SizedBox(
//     height: 0.0,
//   );
  }
}