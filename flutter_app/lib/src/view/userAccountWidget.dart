import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/redux/model/AppState.dart';
import 'package:flutter_app/redux/model/customer.dart';
import 'package:flutter_app/src/services/sendNotification.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/redux/model/AppState.dart';
import 'package:flutter_app/src/view/viewModel.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'profile.dart';
import '../checkLogin.dart';
import 'login.dart';
import 'myCommentsScreen.dart';
import 'myStations.dart';
import 'notificationScreen.dart' as not;
import 'notificationWidget.dart';


class UserAccount <State> extends StatefulWidget {


  @override
  _UserAccountState createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {

  @override
  Widget build(BuildContext context) {
    return new StoreConnector <AppState,ViewModel>(
        converter : (store) => createViewModel(store),
        builder : (context, _viewModel) {
          return

              new Drawer(
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
                            title: Text("Home"),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder:(context)=> Profile()));
                            }
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
                            title: Row(
                                children: [Text("Notification"),NotificationWidget()]
                            ),
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
              );
        });

  }
}