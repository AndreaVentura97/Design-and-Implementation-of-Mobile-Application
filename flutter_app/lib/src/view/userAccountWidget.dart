import 'package:android_intent/android_intent.dart';
import 'package:device_apps/device_apps.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/redux/model/AppState.dart';
import '../db.dart' as DB;
import 'package:flutter_app/src/view/viewModel.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:url_launcher/url_launcher.dart';
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
  var flag=false;
  var package;
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
                            title: Text("Reconnect"),
                            onTap: () {
                              DB.start().then((result) => setState(() {
                                print("reconnected to mongoDb");
                              }));
                            }
                        ),
                        new ListTile(
                            title: Text("Buy a ticket"),
                            onTap: () {
                              openApp();
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
openApp () async {
  String dt = "https://www.atm.it/it/AtmNews/AtmInforma/Pagine/accedi_metro_smartphone.aspx";

  DeviceApps.getInstalledApplications(
      includeAppIcons: true,
      includeSystemApps: false,
      onlyAppsWithLaunchIntent: false).
  then((result)=>setState((){
    for(int i=0;i<result.length;i++){
      if(result[i].appName=="ATM Milano"){
        package = result[i].packageName;
        flag = true;
        //print(" $flag + $package");
      }
    }
  }));
  if (flag == true) {
      DeviceApps.openApp(package);
    }
    else
    {
      if (await canLaunch(dt))
        await launch(dt);
      else
        throw 'Could not launch $dt';
    }
  }
}