import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;


var checkFBlogin;
var checkGlogin;
bool isLoggedG = false;
bool isLoggedF = false;

checkSession () async {
  if (checkFBlogin!=null){
    switch (checkFBlogin.status){
      case FacebookLoginStatus.loggedIn:
        final token = checkFBlogin.accessToken.token;
        final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
        final profile = JSON.jsonDecode(graphResponse.body);
        isLoggedF = true;
        return profile;
        break;
      case FacebookLoginStatus.cancelledByUser:
        break;
      case FacebookLoginStatus.error:
        break;
    }
  }
  if (await checkGlogin.isSignedIn()){
    isLoggedG = true;
    return checkGlogin.currentUser;
  }

}

 setCheckFb (result){
  checkFBlogin = result;
}

setCheckG(result){
  checkGlogin = result;
}

getLoggedG (){
  return isLoggedG;
}

getLoggedF (){
  return isLoggedF;
}



