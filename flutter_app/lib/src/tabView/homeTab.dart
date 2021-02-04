import 'package:delayed_display/delayed_display.dart';
import 'package:flutter_app/redux/model/AppState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_app/src/view/viewModel.dart';
import 'package:flutter/gestures.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../services/service.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../services/stationServices.dart';
import 'MapWidget.dart';
import 'tabDrawerWidget.dart';
import 'tabProfilePage.dart';
//import '../view/InfoProfileScreen.dart';

class HomeTab extends StatefulWidget {
  HomeTabState createState() => HomeTabState();
}

class HomeTabState extends State<HomeTab> {
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
    HomeTabState();
    super.initState();
    setMarkers();
    rootBundle.loadString('assets/mapStyle.txt').then((string) {
      mapStyle = string;
    });
    _getLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, ViewModel>(
        converter: (store) => createViewModel(store),
    builder: (context, _viewModel) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Row(
          children: [
            Flexible(
              flex: 4,
              child: TabProfile(email: _viewModel.c.email),

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
    });
  }
}
