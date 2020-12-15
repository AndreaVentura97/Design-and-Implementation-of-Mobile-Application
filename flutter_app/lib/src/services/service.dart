import 'package:flutter/material.dart';
import '../db.dart' as DB;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../view/displayMenuStation.dart';


retrieveMessages(station) async {
  var response = await DB.getDB().collection('messages').find({'station': station}).toList();
  return response;
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
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder:(context)=>MenuStation(name:name)));
            }
        ),

    ));
  }
  return _markers;
}

saveMessage (myEmail, myName, myText, myStation) async {
  await DB.getDB().collection('messages').insertOne({'email': myEmail, 'name': myName, 'text': myText, 'station': myStation});
}


