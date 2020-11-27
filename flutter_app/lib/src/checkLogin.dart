import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;


var checkFBlogin;
var checkGlogin;
var checkMemail;
bool isLoggedG = false;
bool isLoggedF = false;
bool isLoggedM = false;
var name;
var email;
var photo;

checkSession () async {
  if (checkFBlogin!=null){
    switch (checkFBlogin.status){
      case FacebookLoginStatus.loggedIn:
        final token = checkFBlogin.accessToken.token;
        final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
        final profile = JSON.jsonDecode(graphResponse.body);
        isLoggedF = true;
        name = profile['name'];
        photo = profile["picture"]["data"]["url"];
        email = profile["email"];
        return profile;
        break;
      case FacebookLoginStatus.cancelledByUser:
        break;
      case FacebookLoginStatus.error:
        break;
    }
  }
  if (checkGlogin != null){
    isLoggedG = true;
    name = checkGlogin.currentUser.displayName;
    photo = checkGlogin.currentUser.photoUrl;
    email = checkGlogin.currentUser.email;
    return checkGlogin.currentUser;
  }
  if (isLoggedM){
    name = checkMemail.displayName;
    email = checkMemail.email;
    photo = checkMemail.photoURL;
    return checkMemail;
  }

}

 setCheckFb (result){
  checkFBlogin = result;
}

setCheckG(result){
  checkGlogin = result;
}

setCheckF(result){
  checkMemail = result;
}

getLoggedG (){
  return isLoggedG;
}

getLoggedF (){
  return isLoggedF;
}

getName(){
  return name;
}

getEmail(){
  return email;
}

setLoggedMail (flag){
  isLoggedM = flag;
}

getLoggedM() {
  return isLoggedM;
}

getPhoto (){
  return photo;
}



