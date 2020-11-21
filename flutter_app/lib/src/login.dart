import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'profile.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  bool _isLoggedInF = false;
  bool _isLoggedInG = false;
  Map userProfile;
  final facebookLogin = FacebookLogin();
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  _loginWithFB() async{
    final result = await facebookLogin.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
        final profile = JSON.jsonDecode(graphResponse.body);
        //print(profile);
        setState(() {
          userProfile = profile;
          _isLoggedInF = true;
        });

        Navigator.push(context, MaterialPageRoute(builder:(context)=>
        Profile(name: userProfile["name"], photo: userProfile["picture"]["data"]["url"], email: userProfile["email"])),);

        break;

      case FacebookLoginStatus.cancelledByUser:
        setState(() => _isLoggedInF = false );
        break;
      case FacebookLoginStatus.error:
        setState(() => _isLoggedInF = false );
        break;
    }

  }

  _loginWithGoogle() async{
    try{
      await _googleSignIn.signIn();
      setState(() {
        _isLoggedInG = true;
      });
      Navigator.push(context, MaterialPageRoute(builder:(context)=>
    Profile(name: _googleSignIn.currentUser.displayName, photo: _googleSignIn.currentUser.photoUrl, email: _googleSignIn.currentUser.email)),);

    } catch (err){
      print(err);
    }
  }


  _logoutF(){
    facebookLogin.logOut();
    setState(() {
      _isLoggedInF = false;
    });
  }

  _logoutG(){
    _googleSignIn.signOut();
    setState(() {
      _isLoggedInG = false;
    });
  }




  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: Column (
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
                ]

            )
            ),
      ),
    );
  }
}