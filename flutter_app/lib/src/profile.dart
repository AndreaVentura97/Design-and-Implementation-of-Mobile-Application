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
        //photo = myProfile.photoUrl;
        email = myProfile.email;
      }
    }));
  }

  @override
  void initState() {
    super.initState();
    check();
  }


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(

        appBar: AppBar(

          title: Row(
            children: [
              Icon(
                Icons.menu,
                color: Colors.grey[150],
              ),
              SizedBox(),
              Text(
                  'Welcome back',
                style: TextStyle(
                    color: Colors.grey[150],
                    letterSpacing: 1.5,
                    fontFamily: 'FredokaOne',
                ),
              ),
            ],
          ),
          centerTitle: true,
          backgroundColor: Colors.amber[400],
        ),

          body: Column (
            children: [
              Row(
                children: [
                  Image.network(photo, height: 150.0, width: 150.0,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(height: 0.0),
                      Row(
                        children: [
                          Icon(
                            Icons.account_box_outlined,
                            color: Colors.grey[600],
                          ),
                          SizedBox(width: 10.0,),
                          Text(
                            "$name",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 15.0,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        children: [
                          Icon(
                            Icons.email,
                            color: Colors.grey[600],
                          ),
                          SizedBox(width: 10.0,),
                          Text(
                            "$email",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 15.0,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
                //mainAxisAlignment: MainAxisAlignment.end,
              ),
              OutlineButton(
                child: Text("See map"),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder:(context)=> Map()));
                },
              ),
            ]

              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              // children: [
              //   Text ("$name"),
              //   Image.network(photo, height: 150.0, width: 150.0,),
              //   Text ("$email"),
              //   OutlineButton(
              //     child: Text("See map"),
              //     onPressed: () {
              //       Navigator.push(context, MaterialPageRoute(builder:(context)=> Map()));
              //       },
              //   ),

            )

      ),
    );
  }



}
