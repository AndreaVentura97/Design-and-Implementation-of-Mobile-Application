import 'package:flutter/material.dart';
import 'map.dart';
import 'checkLogin.dart';
import 'login.dart';
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
      debugShowCheckedModeBanner:false,
      home: Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text(
                'Welcome back',
                style: TextStyle(
                  color: Colors.black,
                  letterSpacing: 1.5,
                  fontFamily: 'FredokaOne',
                ),
                  textAlign: TextAlign.center,
              ),

            ),
          centerTitle: true,
          backgroundColor: Colors.amber[400],
        ),
          drawer: new Drawer(
            child: ListView(
              children: <Widget>[
                new UserAccountsDrawerHeader(
                    accountName: Row(children:[Icon(
                      Icons.account_box_outlined,
                      color: Colors.black,
                    ),
                      Text("$name"),
                    ]),
                    accountEmail: Row(children:[Icon(
                      Icons.email,
                      color: Colors.black,
                    ),
                      Text("$email"),
                    ]),
                    currentAccountPicture: new CircleAvatar(
                      backgroundImage: (photo==null) ? null : new NetworkImage(photo),
                    ),
                ),
                new ListTile(
                  title: Text("See my stations"),
                  onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder:(context)=> MyStations (email: email)));
                  }
                  ),
                new ListTile(
                  title: Text("See my comments"),
                  onTap: (){
                    //TODO
                  }
                ),
                new ListTile(
                    title: Text("Contact us"),
                    onTap: (){
                      //TODO
                    }
                ),
                new ListTile(
                    title: Text("About us"),
                    onTap: (){
                      //TODO
                    }
                ),

                new ListTile(
                    title: Text("Logout"),
                  onTap: () {
                    setLogged(false);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder:(BuildContext context)=> Login()));
                    },
                ),
              ]
            )
          ),
          body: Column (
            children: [
              /*
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

               */
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomRight,
                  child: Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: RawMaterialButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder:(context)=> Map()));
                        },
                        elevation: 2.0,
                        fillColor: Colors.red,
                        child: new ImageIcon(
                          AssetImage("assets/map.png"),
                          size: 35.0,
                        ),
                        padding: EdgeInsets.all(15.0),
                        shape: CircleBorder(),
                      ) //Your widget here,
                  ),
                ),
              ),
              ]

              /*
              OutlineButton(
                child: Text("See map"),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder:(context)=> Map()));
                },
              ),
            ]

               */

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
