import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../db.dart' as DB;
import 'dart:ui' as ui;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../view/displayMenuStation.dart';



retrieveMessages(station) async {
  var response = await DB.getDB().collection('messages').find({'station': station}).toList();
  return response;
}

retrieveSuggestions(station) async {
  var response = await DB.getDB().collection('suggestions').find({'station': station}).toList();
  print("aaa $response");
  return response;
}

retrieveMarkers () async {
  var response = await DB.getDB().collection('markers').find().toList();
  return response;
}

buildMarkers (response, context) async {
  Set<Marker> _markers = Set <Marker>();
  for (int i=0; i<response.length; i++){
    String id = i.toString();
    var lat = response[i]['latitude'];
    var long = response[i]['longitude'];
    String name = response[i]['name'];
    String line = response[i]['line'];
    String image;
    BitmapDescriptor myIcon;
    if(line=="Metro M1") {
      image = "assets/M1.jpeg";
    }
    if (line == "Metro M2"){
      image = "assets/M2.jpeg";
    }
    if (line == "Metro M3"){
      image = "assets/M3.jpeg";
    }
    if (line=="Metro M5"){
      image = "assets/M5.jpeg";
    }

    Future<Uint8List> getBytesFromAsset(String path, int width) async{
      ByteData data = await rootBundle.load(path);
      ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
      ui.FrameInfo fi = await codec.getNextFrame();
      return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
    }
    
    final Uint8List markerIcon  = await getBytesFromAsset(image, 100);

    _markers.add(Marker(
        markerId: MarkerId(id),
        icon: BitmapDescriptor.fromBytes(markerIcon),
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

buildTabMarkers (response, context) async {
  final Set<Marker> _markers = Set <Marker>();
  for (int i=0; i<response.length; i++){
    String id = i.toString();
    var lat = response[i]['latitude'];
    var long = response[i]['longitude'];
    String name = response[i]['name'];
    String line = response[i]['line'];
    String image;
    BitmapDescriptor myIcon;
    if(line=="Metro M1") {
      image = "assets/M1.jpeg";
    }
    if (line == "Metro M2"){
      image = "assets/M2.jpeg";
    }
    if (line == "Metro M3"){
      image = "assets/M3.jpeg";
    }
    if (line=="Metro M5"){
      image = "assets/M5.jpeg";
    }

    Future<Uint8List> getBytesFromAsset(String path, int width) async{
      ByteData data = await rootBundle.load(path);
      ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
      ui.FrameInfo fi = await codec.getNextFrame();
      return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
    }

    final Uint8List markerIcon  = await getBytesFromAsset(image, 100);

    _markers.add(Marker(
      markerId: MarkerId(id),
      icon: BitmapDescriptor.fromBytes(markerIcon),
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

saveMessage (myEmail, myName, myText, myPhoto, myStation,state) async {
  DateTime now = new DateTime.now();
  String formattedDate = "${now.year.toString()}-${now.month.toString().padLeft(2,'0')}-${now.day.toString().padLeft(2,'0')}";
  await DB.getDB().collection('messages').insertOne({'email': myEmail, 'date':formattedDate, 'name': myName, 'photo':myPhoto, 'text': myText,
    'station': myStation, 'nl':0, 'nu':0, 'citizen': state});
}

saveSuggestion (myEmail, myName, myText, myPhoto, myStation) async {
  DateTime now = new DateTime.now();
  String formattedDate = "${now.year.toString()}-${now.month.toString().padLeft(2,'0')}-${now.day.toString().padLeft(2,'0')}";
  await DB.getDB().collection('suggestions').insertOne({'email': myEmail, 'date':formattedDate, 'name': myName, 'photo':myPhoto, 'text': myText,
    'station': myStation});
}




