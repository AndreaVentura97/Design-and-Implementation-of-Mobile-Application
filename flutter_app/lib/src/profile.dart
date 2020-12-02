import 'package:flutter/material.dart';
import 'db.dart' as DB;
import 'map.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'checkLogin.dart';
import 'login.dart';
import 'checkLogin.dart';
import 'userService.dart';
import 'myStations.dart';



class Profile<State> extends StatefulWidget {
  var profile;
  var myStations;


  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var name;
  String photo;
  var email;

  bool status;

  void takeProfile() {
    exportProfile().then((myProfile)=> setState((){
      name = myProfile[0];
      email = myProfile[1];
      photo = myProfile[2];
    }));
  }





  @override
  void initState() {
    super.initState();
    takeProfile();

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
                  //Image.network(photo, height: 150.0, width: 150.0,),
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
              OutlineButton(
                child: Text("See my favourite stations"),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder:(context)=> MyStations (email: email)));
                },
              ),
              OutlineButton(
                child: Text("Logout"),
                onPressed: () {
                  setLogged(false);
                  Navigator.push(context, MaterialPageRoute(builder:(context)=> Login()));
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
