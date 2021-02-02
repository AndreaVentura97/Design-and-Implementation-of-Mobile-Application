import 'package:flutter/material.dart';
import 'package:flutter_app/src/view/userAccountWidget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import '../services/service.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../services/stationServices.dart';

class MapWidget extends StatefulWidget {
  @override
  MapWidgetState createState() => MapWidgetState();
}

class MapWidgetState extends State<MapWidget> {
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
    );
  }
}
