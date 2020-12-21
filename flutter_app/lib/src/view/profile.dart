import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/redux/model/AppState.dart';
import 'package:flutter_app/redux/model/customer.dart';
import 'package:flutter_app/src/services/sendNotification.dart';
import 'package:flutter_app/src/view/viewModel.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'map.dart';
import '../checkLogin.dart';
import 'login.dart';
import 'myCommentsScreen.dart';
import 'myStations.dart';
import 'notificationScreen.dart' as not;


class Profile<State> extends StatefulWidget {
  var profile;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name;
  bool status;
  bool notifications;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();



  @override
  void initState() {
    super.initState();

  }




  @override
  Widget build(BuildContext context) {
    return new StoreConnector <AppState,ViewModel>(
        converter : (store) => createViewModel(store),
        builder : (context, _viewModel) {
          return Scaffold(
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
                          accountName: Row(children: [Icon(
                            Icons.account_box_outlined,
                            color: Colors.black,
                          ),
                            Text("${_viewModel.c.name}"),
                          ]),
                          accountEmail: Row(children: [Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                            Text("${_viewModel.c.email}"),
                          ]),
                          currentAccountPicture: new CircleAvatar(
                            backgroundImage: (_viewModel.c.photo == null)
                                ? null
                                : new NetworkImage(_viewModel.c.photo),
                          ),
                        ),
                        new ListTile(
                            title: Text("See my stations"),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder:(context)=> MyStations (email: _viewModel.c.email)));
                            }
                        ),
                        new ListTile(
                            title: Text("See my comments"),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder:(context)=> MyComments ()));
                            }
                        ),
                        new ListTile(
                            title: Text("Notification"),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder:(context)=>not.Notification()));
                            }
                        ),
                        new ListTile(
                            title: Text("Contact us"),
                            onTap: () {
                              //TODO
                            }
                        ),
                        new ListTile(
                            title: Text("About us"),
                            onTap: () {
                              //TODO
                            }
                        ),

                        new ListTile(
                          title: Text("Logout"),
                          onTap: () {
                            setLogged(false);
                            Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (BuildContext context) => Login()));
                          },
                        ),
                      ]
                  )
              ),
              body: Column(
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
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => Map()));
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

          );
        });

  }
}





