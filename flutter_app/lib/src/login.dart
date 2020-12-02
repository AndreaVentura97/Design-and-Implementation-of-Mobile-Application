import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'profile.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'checkLogin.dart';
import 'register.dart';
import 'signIn.dart';
import 'userService.dart';
import 'checkLogin.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  bool isLogged = false;

  Map userProfile;
  final facebookLogin = FacebookLogin();
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  getprefs() async {
    getLogged().then((log)=> setState((){
      if (log!=null){
        isLogged = log;
      }
      else {
        isLogged = false;
      }

    }));
  }


  void initState() {
    super.initState();
    getprefs();
  }


  _loginWithFB() async {
    final result = await facebookLogin.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
        final profile = JSON.jsonDecode(graphResponse.body);
        //print(profile);
        setState(() {
          userProfile = profile;
          isLogged = true;
        });
        insertUser(profile['email'], profile['name']);
        checkSession(profile['name'], profile['email'], profile["picture"]["data"]["url"]);
        break;
        case FacebookLoginStatus.cancelledByUser:
        setState(() => isLogged = false );
        break;
      case FacebookLoginStatus.error:
        setState(() => isLogged = false );
        break;
    }
  }

  _loginWithGoogle() async{
    try{
      await _googleSignIn.signIn();
      setState(() {
        isLogged = true;
      });
      insertUser(_googleSignIn.currentUser.email, _googleSignIn.currentUser.displayName);
      checkSession(_googleSignIn.currentUser.displayName, _googleSignIn.currentUser.email, _googleSignIn.currentUser.photoUrl);
    } catch (err){
      print(err);
    }
  }





  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: (!isLogged) ? Column (
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  OutlineButton(
                    child: Text("Login with Facebook"),
                    onPressed: () {
                      _loginWithFB();
                    },
                  ),
                  OutlineButton(
                    child: Text("Login with Google"),
                    onPressed: () {
                      _loginWithGoogle();
                    },
                  ),
                  OutlineButton(
                    child: Text("Login with Email"),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder:(context)=>
                          SignIn()),);
                    },
                  ),
                  OutlineButton(
                    child: Text("Registration with Email"),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder:(context)=>
                          Register()),);
                    },
                  ),
                ]

            ) : Profile()
            ),
      ),
    );
  }
}