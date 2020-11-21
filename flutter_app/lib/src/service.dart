import 'package:flutter/material.dart';
import 'db.dart' as DB;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'displayMenuStation.dart';


retrieveMessages() async {

  var response = await DB.getDB().collection('messages').findOne({'name': "andrea"});
  var list = response['messages'];

  //print('elenco messaggi: $b');
  return list;
}

retrieveMarkers () async {
  var response = await DB.getDB().collection('markers').find().toList();
  return response;
}

buildMarkers (response, context){
  Set<Marker> _markers = Set <Marker>();
  for (int i=0; i<response.length; i++){
    String id = i.toString();
    var lat = response[i]['latitude'];
    var long = response[i]['longitude'];
    String name = response[i]['name'];
    String line = response[i]['line'];

    _markers.add(Marker(
        markerId: MarkerId(id),
        position: LatLng(lat, long),
        infoWindow: InfoWindow (
          title: name,
          snippet: line,
        ),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder:(context)=>MenuStation(name:name, line:line)));
        }
    ));
  }
  return _markers;
}


