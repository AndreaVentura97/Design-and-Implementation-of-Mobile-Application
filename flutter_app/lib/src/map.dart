import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'service.dart';
import 'package:location/location.dart';
import 'displayMenuStation.dart';




class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  Set<Marker> _markers;
  GoogleMapController mapController;
  final LatLng _center = const LatLng(45.456532, 9.125001);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void setMarkers () async{
    var response = await retrieveMarkers();
    setState(() {
      _markers = buildMarkers(response, context);
    });

  }

  void _getLocationPermission() async {
    var location = new Location();
    try {

      location.requestPermission();
    } on Exception catch (_) {
      print('There was a problem allowing location access');
    }
  }

  void initState() {
    super.initState();
    setMarkers();
    _getLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Map'),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
          markers: _markers,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,

        ),
      ),
    );
  }
}

