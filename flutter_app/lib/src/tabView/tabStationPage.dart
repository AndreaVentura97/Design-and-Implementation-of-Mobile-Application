import 'package:flutter/material.dart';
import 'package:flutter_app/redux/model/AppState.dart';
import 'package:flutter_app/src/tabView/tabDrawerWidget.dart';
import 'package:flutter_app/src/view/commentTabScreen.dart';
import 'package:flutter_app/src/services/userService.dart';
import 'package:flutter_app/src/view/pointWidget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../services/service.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../services/stationServices.dart';
import 'package:flutter_app/src/view/infoTabScreen.dart';
import 'package:flutter_app/src/view/userAccountWidget.dart';
import 'package:flutter_app/src/view/viewModel.dart';
import 'package:flutter_app/src/view/votingTabScreen.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../view/animatedAppBar.dart';
import '../view/commentsTabScreen.dart';
import '../services/stationServices.dart';


class tabMenuStation extends StatefulWidget {
  final String name;
  // String station;
  tabMenuStation({Key key, this.name}) : super(key: key);
  tabMenuStationState createState() => tabMenuStationState();
}

class tabMenuStationState extends State<tabMenuStation> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  String line;
  String address;
  List points = [];
  //var RGBStation = new List(3);
  List RGBStation = [0, 0, 0];
  AnimationController _animationController;
  Animation _colorTween;
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
    buildTabMarkers(response, context).then((result) => setState((){
      _markers = result;
    }));
  }
  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
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

  void takeStationInformation (){
    informationStation(widget.name).then((information) => setState(() {
      line = information['line'];
      address = information['address'];
      checkLine(line);
      print('${RGBStation[0]}');
    }));
    pointsStation(widget.name).then((result) => setState(() {
      points = result;
    }));
  }

  void checkLine(line){
    if (line=="Metro M1"){
      setState(() {
        RGBStation = [236, 44, 32] ;
      });
    }
    if (line=="Metro M2"){
      setState(() {
        RGBStation = [92, 148, 51];
      });
    }
    if (line=="Metro M3"){
      setState(() {
        RGBStation = [251, 186, 20];
      });
    }
    if (line=="Metro M5"){
      setState(() {
        RGBStation = [154, 140, 195];
      });
    }
  }

  Animatable<Color> background = TweenSequence<Color>([
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(
        begin: Colors.red,
        end: Colors.green,
      ),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(
        begin: Colors.green,
        end: Colors.blue,
      ),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(
        begin: Colors.blue,
        end: Colors.pink,
      ),
    ),
  ]);

  @override
  void initState() {
    takeStationInformation ();
    setMarkers();
    rootBundle.loadString('assets/mapStyle.txt').then((string) {
      mapStyle = string;
    });
    _getLocationPermission();
    super.initState();
    _animationController =
    AnimationController(vsync:this, duration: Duration(seconds: 3))..repeat();
    _colorTween = ColorTween(begin: Colors.red, end: Colors.green)
        .animate(_animationController);
  }





  @override
  Widget build(BuildContext context) {

    return new StoreConnector<AppState, ViewModel>(
        converter: (store) => createViewModel(store),
        builder: (context,_viewModel){
          final tabs =[
            InfoStation(station: widget.name),
            Comments(station: widget.name),
            Voting(station:widget.name),
          ];
          return AnimatedBuilder(
              animation:_animationController,
              builder : (context,child){
                return Scaffold(
                  resizeToAvoidBottomInset: false,
                  appBar: AppBar(
                      title: Text("${widget.name}"),
                      //backgroundColor: Color.fromRGBO(RGBStation[0],RGBStation[1],RGBStation[2],  1.0),
                      backgroundColor: _colorTween.value
                  ),
                  drawer: TabDrawer(),
                  body: SafeArea(
                    child: Row(
                      children: [
                        Flexible(
                          flex: 4,
                          child: Scaffold (
                            body: tabs[_currentIndex],
                            bottomNavigationBar: BottomNavigationBar(
                              currentIndex: _currentIndex,
                              //type: BottomNavigationBarType.fixed,
                              selectedFontSize: 15,
                              items: [
                                BottomNavigationBarItem(
                                  icon: Icon(Icons.home,
                                    color: Colors.blue[900],
                                  ),
                                  title: Text("Info Station",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.blue[900]
                                    ),
                                  ),
                                ),
                                BottomNavigationBarItem(
                                  icon: Icon(Icons.search,
                                    color: Colors.blue[900],
                                  ),
                                  title: Text("Comments",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.blue[900],
                                    ),
                                  ),
                                ),
                                BottomNavigationBarItem(
                                  icon: Icon(Icons.how_to_vote_outlined,
                                    color: Colors.blue[900],
                                  ),
                                  title: Text("Voting",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.blue[900]
                                    ),
                                  ),
                                ),
                              ],
                              onTap: (index){
                                setState(() {
                                  _currentIndex = index;
                                });
                              },
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

              }
          );
        }

    );

  }
}
