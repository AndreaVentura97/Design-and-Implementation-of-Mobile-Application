import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'checkLogin.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'services/userService.dart' as us;
import 'dart:convert' as JSON;
import 'package:flutter_app/redux/actions/actions.dart';
import 'package:flutter_app/redux/model/AppState.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'view/login.dart';
import 'view/adminScreen.dart';


final facebookLogin = FacebookLogin();
Map userProfile;

GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

FirebaseAuth _auth = FirebaseAuth.instance;

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

loginWithFB(context) async {
  final result = await facebookLogin.logIn(['email']);
  switch (result.status) {
    case FacebookLoginStatus.loggedIn:
      final token = result.accessToken.token;
      final graphResponse = await http.get(
          'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
      final profile = JSON.jsonDecode(graphResponse.body);
      if (await us.getPhoto(profile['email']) != null){
        us.getPhoto(profile['email']).then((result) =>
            StoreProvider.of<AppState>(context).dispatch(updateCustomer(name:profile['name'],email:profile['email'],photo: result ,notification: false)));
        us.getPhoto(profile['email']).then((result2) => checkSession(profile['name'], profile['email'],
            result2));
        print("here1");
      }
      else {
        StoreProvider.of<AppState>(context).dispatch(updateCustomer(name:profile['name'],email:profile['email'],photo:profile["picture"]["data"]["url"],notification: false));
        checkSession(profile['name'], profile['email'],
            profile["picture"]["data"]["url"]);
        print("here2");

      }
      String tk = await _firebaseMessaging.getToken();
      us.insertUser(profile['email'], profile['name'],tk);

      return true;
      break;
    case FacebookLoginStatus.cancelledByUser:
      return false;
      break;
    case FacebookLoginStatus.error:
      return false;
      break;
  }
}

loginWithGoogle(context) async {
  try {
    await _googleSignIn.signIn();
    String tk = await _firebaseMessaging.getToken();
    if (await us.getPhoto(_googleSignIn.currentUser.email) != null){
      us.getPhoto(_googleSignIn.currentUser.email).then((result) =>
          StoreProvider.of<AppState>(context).dispatch(updateCustomer(name:_googleSignIn.currentUser.displayName,email:_googleSignIn.currentUser.email,photo: result ,notification: false)));
      us.getPhoto(_googleSignIn.currentUser.email).then((result2) => checkSession(_googleSignIn.currentUser.displayName, _googleSignIn.currentUser.email,
          result2));
    }
    else {
      checkSession(_googleSignIn.currentUser.displayName,
          _googleSignIn.currentUser.email, _googleSignIn.currentUser.photoUrl);
      StoreProvider.of<AppState>(context).dispatch(updateCustomer(name:_googleSignIn.currentUser.displayName, email:_googleSignIn.currentUser.email,photo:_googleSignIn.currentUser.photoUrl,notification: false));
    }
    us.insertUser(_googleSignIn.currentUser.email,
        _googleSignIn.currentUser.displayName,tk);
    return true;
  } catch (err) {
    print(err);
    return false;
  }
}

 signInWithEmailAndPassword(context,email,password) async {
  try {
    final User user = (await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user;
    //if (!user.emailVerified) {
    //await user.sendEmailVerification();
    //}
    if (email == "admin@live.it" &&
        password == "adminadmin") {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return AdminScreen();
      }));
    } else {
      if (await us.getPhoto(user.email) != null){
        us.getPhoto(user.email).then((result) =>
            StoreProvider.of<AppState>(context).dispatch(updateCustomer(name:user.displayName,email:user.email,photo: result ,notification: false)));
        us.getPhoto(user.email).then((result2) => checkSession(user.displayName, user.email,
            result2));
      }
      else {
        checkSession(user.displayName, user.email, null);
        StoreProvider.of<AppState>(context).dispatch(updateCustomer(name:user.displayName, email:user.email,photo:null,notification: false));
      }
      String tk = await _firebaseMessaging.getToken();
      us.insertUser(user.email, user.displayName,tk);
      print('here I am');
      //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        //return Login();
      //}));
      return null;
    }
  } catch (e) {
    print('ritornando errore');
    await setLogged(false);
    return e.message;
  }
}