import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/view/login.dart';
import 'checkLogin.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../src/view/map.dart';
import '../src/services/userService.dart';
import 'package:flutter_app/redux/actions/actions.dart';
import 'package:flutter_app/redux/model/AppState.dart';

Future registerAccount(name,email,password,context) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  try {
    final User user = (await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user;
    if (user != null) {
      //if (!user.emailVerified) {
      //await user.sendEmailVerification();
      //}
      await user.updateProfile(displayName: name);
      final user1 = _auth.currentUser;
      checkSession(user1.displayName, user1.email, null);
      String tk = await _firebaseMessaging.getToken();
      StoreProvider.of<AppState>(context).dispatch(updateCustomer(name:user1.displayName,email:user1.email,photo:null,notification: false));
      insertUser(user1.email, user1.displayName,tk);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return Map();
      }));
    }
  } catch (e) {
    return e.message;
  }
}