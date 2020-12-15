import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'checkLogin.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'services/userService.dart';
import 'dart:convert' as JSON;
import 'package:flutter_app/redux/actions/actions.dart';
import 'package:flutter_app/redux/model/AppState.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'view/profile.dart';
import 'view/adminScreen.dart';


final facebookLogin = FacebookLogin();
Map userProfile;

GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

FirebaseAuth _auth = FirebaseAuth.instance;

loginWithFB(context) async {
  final result = await facebookLogin.logIn(['email']);
  switch (result.status) {
    case FacebookLoginStatus.loggedIn:
      final token = result.accessToken.token;
      final graphResponse = await http.get(
          'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
      final profile = JSON.jsonDecode(graphResponse.body);
      StoreProvider.of<AppState>(context).dispatch(updateCustomer(name:profile['name'],email:profile['email'],photo:profile["picture"]["data"]["url"]));
      insertUser(profile['email'], profile['name']);
      checkSession(profile['name'], profile['email'],
          profile["picture"]["data"]["url"]);
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
    insertUser(_googleSignIn.currentUser.email,
        _googleSignIn.currentUser.displayName);
    checkSession(_googleSignIn.currentUser.displayName,
        _googleSignIn.currentUser.email, _googleSignIn.currentUser.photoUrl);
    StoreProvider.of<AppState>(context).dispatch(updateCustomer(name:_googleSignIn.currentUser.displayName, email:_googleSignIn.currentUser.email,photo:_googleSignIn.currentUser.photoUrl));
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
      checkSession(user.displayName, user.email, null);
      insertUser(user.email, user.displayName);
      StoreProvider.of<AppState>(context).dispatch(updateCustomer(name:user.displayName, email:user.email,photo:null));
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return Profile();
      }));
    }
  } catch (e) {
    await setLogged(false);
    return e.message;
  }
}