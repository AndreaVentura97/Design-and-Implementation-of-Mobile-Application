import 'package:flutter/material.dart';
import 'db.dart' as DB;
import 'map.dart';
import 'messages.dart';
import 'service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'checkLogin.dart';
import 'login.dart';
import 'checkLogin.dart';

class Profile<State> extends StatefulWidget {
  var profile;



  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var name;
  String photo;
  var email;
  void check() {
    checkSession().then((myProfile) => setState(() {
      widget.profile = myProfile;
      if (getLoggedF()){
        name = myProfile["name"];
        photo = myProfile["picture"]["data"]["url"];
        email = myProfile["email"];
      }
      if (getLoggedG()){
        name = myProfile.displayName;
        photo = myProfile.photoUrl;
        email = myProfile.email;
      }
    }));
  }

  @override
  void initState() {
    super.initState();
    check();
    //data();
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
                Text ("$name"),
                Image.network(photo, height: 150.0, width: 150.0,),
                Text ("$email"),
                OutlineButton(
                  child: Text("See map"),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder:(context)=> Map()));
                    },
                ),
              ]
            )
        ),
      ),
    );
  }



}
