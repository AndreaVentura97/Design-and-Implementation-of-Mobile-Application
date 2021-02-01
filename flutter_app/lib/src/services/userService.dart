import 'package:firebase_messaging/firebase_messaging.dart';

import '../db.dart' as DB;
import 'dart:io' as Io;





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
      'myLikedPoints':myLikedPoints, 'myUnlikedPoints':myUnlikedPoints, 'token':tk, 'citizen':true
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

updatePhoto (email,photo) async {
  var user = await DB.getDB().collection('users').findOne({'email': email});
  print(user);
  await DB.getDB().collection('users').update({'email': email}, {"\$set": {"photo":photo}});
  var messages = await DB.getDB().collection('messages').find({'email':email}).toList();
  for (int i=0; i<messages.length; i++){
    await DB.getDB().collection('messages').update({'text': messages[i]['text']}, {"\$set": {"photo":photo}});
  }

}

getPhoto (email) async {
  var user = await DB.getDB().collection('users').findOne({'email': email});
  if(user!=null){
    print("presa");
    return user['photo'];
  }
  return null;
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

getNumberOfMyComments(email) async {
  var listUser = await DB.getDB().collection('messages').find({'email':email}).toList();
  return listUser.length;
}

getNumberOfLikes(email) async {
  var total = 0;
  var listUser = await DB.getDB().collection('messages').find({'email':email}).toList();
  for (int i = 0; i < listUser.length; i++){
    total = total + listUser[i]['nl'];
  }
  return total;
}

getNumberOfUnLikes(email) async {
  var total = 0;
  var listUser = await DB.getDB().collection('messages').find({'email':email}).toList();
  for (int i = 0; i < listUser.length; i++){
    total = total + listUser[i]['nu'];
  }
  return total;
}

getCommentWithMostLike(email) async {
  var listUser = await DB.getDB().collection('messages').find({'email':email}).toList();
  if (listUser.length==0){
    return null;
  }
  var comment = listUser[0];
  for (int i = 1; i < listUser.length; i++){
    if (comment['nl'] < listUser[i]['nl']){
      comment = listUser[i];
    }
  }
  return comment;
}

getCommentWithMostUnLike(email) async {
  var listUser = await DB.getDB().collection('messages').find({'email':email}).toList();
  if (listUser.length==0){
    return null;
  }
  var comment = listUser[0];
  for (int i = 1; i < listUser.length; i++){
    if (comment['nu'] < listUser[i]['nu']){
      comment = listUser[i];
    }
  }
  return comment;
}

getLikesGiven(email) async {
  var user = await DB.getDB().collection("users").findOne({'email':email});
  var list = user['myLiked'];
  return list.length;
}

getUnlikesGiven(email) async {
  var user = await DB.getDB().collection("users").findOne({'email':email});
  var list = user['myUnliked'];
  return list.length;
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
  var state = user['citizen'];
  return state;
}

updateState(email,value) async {
  await DB.getDB().collection('users').update({'email': email}, {"\$set": {"citizen":value}});
  return value;
}

orderListByInteractions (list) {
  List orderedList = [];
  if (list.length==0) {
    return list;
  }
  var flag = true;
  while (flag){
    for (int i=0; i< list.length; i++){
      if(list[i]['nl'] + list[i]['nu'] >= checkMax(list)){

        orderedList.add(list[i]);
        list.remove(list[i]);

      }
      if(list.length==0){
        flag = false;

      }
    }
  }
  return orderedList;
}

checkMax(list){
  var total = 0;
  for (int i = 0; i < list.length; i++){
    if (list[i]['nl'] + list[i]['nu'] >= total){
      total = list[i]['nl'] + list[i]['nu'];
    }
  }
  return total;
}

removeFromList(list,text,station,email){
  for (int i=0; i < list.length; i++){
    if (list[i]['text']==text && list[i]['email']==email && list[i]['station']==station){
      list.remove(list[i]);

    }

  }
  return list;
}

commentsStation(email,station) async {
  var listUser = await DB.getDB().collection('messages').find({'email':email, 'station':station}).toList();
  print(listUser);
  return listUser.length;
}

