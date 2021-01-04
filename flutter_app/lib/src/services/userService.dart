import 'package:firebase_messaging/firebase_messaging.dart';

import '../db.dart' as DB;




insertUser (email, name,tk) async {
  bool flag = false;
  var listUser = await DB.getDB().collection('users').find().toList();
  for (int i =0; i < listUser.length; i++){
    if (listUser[i]['email']==email){
      flag = true;
      await DB.getDB().collection('users').update({'email': email}, {"\$set": {"token":tk}});
    }
  }

  List <String> myStations = [];
  List <String> myComments = [];
  List <String> myLiked = [];
  List <String> myUnliked = [];
  List <String> myLikedPoints = [];
  List <String> myUnlikedPoints = [];
  if (!flag){
    await DB.getDB().collection('users').insertOne({'email': email, 'name': name,
      'myStations': myStations, 'myComments': myComments,
      'myLiked':myLiked, 'myUnliked':myUnliked,
      'myLikedPoints':myLikedPoints, 'myUnlikedPoints':myUnlikedPoints, 'token':tk, 'state':true
    });
  }
}

addMyStations (email, station) async {
  bool flag = false;
  var user = await DB.getDB().collection('users').findOne({'email': email});
  var list = user['myStations'].toList();
  if (list.length>0){
    for (int i=0; i < list.length; i++){
      if (list[i]==station){
        flag = true;
      }
    }
  }
  if (!flag){
    list.add(station);
    await DB.getDB().collection('users').update({'email': email}, {"\$set": {"myStations":list}});
  }
}

deleteMyStations (email, station) async {
  var user = await DB.getDB().collection('users').findOne({'email': email});
  var list = user['myStations'].toList();
  list.remove(station);
    await DB.getDB().collection('users').update({'email': email}, {"\$set": {"myStations":list}});
}

isMyStation (email,station) async {
  var user = await DB.getDB().collection('users').findOne({'email': email});
  var list = user['myStations'].toList();
  if (list.contains(station)) return true;
  return false;
}




retrieveMyStations(email) async{
  var user = await DB.getDB().collection('users').findOne({'email': email});
  var myStations = user['myStations'].toList();
  return myStations;
}

retrieveMyLikes(email) async {
  var user = await DB.getDB().collection('users').findOne({'email': email});
  var myLiked = user['myLiked'].toList();
  return myLiked;
}

retrieveMyUnlikes(email) async {
  var user = await DB.getDB().collection('users').findOne({'email': email});
  var myUnliked = user['myUnliked'].toList();
  return myUnliked;
}

getMyComments(email) async {
  var listUser = await DB.getDB().collection('messages').find({'email':email}).toList();
  return listUser;
}

retrieveMyLikedPoints(email) async {
  var user = await DB.getDB().collection('users').findOne({'email': email});
  var myLiked = user['myLikedPoints'].toList();
  return myLiked;
}

retrieveMyUnLikedPoints(email) async {
  var user = await DB.getDB().collection('users').findOne({'email': email});
  var myLiked = user['myUnlikedPoints'].toList();
  return myLiked;
}

retrieveMyState(email) async {
  var user = await DB.getDB().collection('users').findOne({'email': email});
  var state = user['state'];
  return state;
}

updateState(email,value) async {
  await DB.getDB().collection('users').update({'email': email}, {"\$set": {"state":value}});
  return value;
}
