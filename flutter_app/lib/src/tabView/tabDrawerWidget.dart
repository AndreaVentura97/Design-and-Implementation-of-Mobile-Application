import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:android_intent/android_intent.dart';
import 'package:device_apps/device_apps.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/redux/actions/actions.dart';
import 'package:flutter_app/redux/model/AppState.dart';
import 'package:flutter_app/src/services/userService.dart';
import 'package:path_provider/path_provider.dart';
import '../db.dart' as DB;
import 'package:flutter_app/src/view/viewModel.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:url_launcher/url_launcher.dart';
import '../checkLogin.dart';
import 'package:image_picker/image_picker.dart';

import 'tabProfilePage.dart';
import 'tabMyStationPage.dart';
import 'tabSearchPage.dart';
import 'tabMyCommentsPage.dart';
import 'tabLogin.dart';


class TabDrawer extends StatefulWidget {
  @override
  TabDrawerState createState() => TabDrawerState();
}

class TabDrawerState extends State<TabDrawer> {
  var flag = false;
  var package;
  File imageFile;

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, ViewModel>(
        converter: (store) => createViewModel(store),
        builder: (context, _viewModel) {
          return new Drawer(
                child: ListView(children: <Widget>[
                   InkWell(
                     child: new UserAccountsDrawerHeader(
                      decoration: BoxDecoration(color: Colors.blue[900]),
                       accountName: Row(children: [
                         Icon(
                          Icons.account_box_outlined,
                          color: Colors.white,
                           size: 30,
                         ),
                         SizedBox(
                          width: 5,
                         ),
                        Text("${_viewModel.c.name}",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                       ]),
                       accountEmail: Row(children: [
                    Icon(
                      Icons.email,
                      color: Colors.white,
                      size: 30,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "${_viewModel.c.email}",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ]),
                       currentAccountPicture: new CircleAvatar(
                            backgroundImage: getPhoto(_viewModel.c.photo),
                            radius: 60,
                          ),

                ),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              TabProfile()));
                },
              ),
                  new ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.train, color: Colors.blue[900], size: 30,),
                      Text(" My Stations", style: TextStyle(color: Colors.blue[900], fontSize: 22),),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TabMyStations(email: _viewModel.c.email)));
                  }),
                  new ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.search,
                            color: Colors.blue[900],
                            size: 30,
                          ),
                          Text(
                            " Search Stations",
                            style: TextStyle(color: Colors.blue[900], fontSize: 22),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TabSearch()));
                      }),
                  new ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.comment, color: Colors.blue[900], size: 30,),
                      Text(" My Comments", style: TextStyle(color: Colors.blue[900], fontSize: 22),),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TabMyComments()));
                  }),
              //     new ListTile(
              //   title:
              //       Row(children: [Text("Notification"), NotificationWidget()]),
              // ),

                  new ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          Icon(Icons.account_balance_wallet, color: Colors.blue[900],size: 30),
                          Text(" Buy a ticket", style: TextStyle( color: Colors.blue[900], fontSize: 22),),
                        ],
                      ),
                      onTap: () {
                        openApp();
                      }
                  ),

                  new ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.exit_to_app, color: Colors.blue[900], size: 30),
                    Text(" Logout", style: TextStyle( color: Colors.blue[900], fontSize: 22),),
                  ],
                ),
                onTap: () {
                  setLogged(false);
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                      builder: (BuildContext context) => TabLogin()), ModalRoute.withName('/'));
                },
              ),

            ]));
        });
  }

  openApp() async {
    String dt =
        "https://www.atm.it/it/AtmNews/AtmInforma/Pagine/accedi_metro_smartphone.aspx";

    DeviceApps.getInstalledApplications(
            includeAppIcons: true,
            includeSystemApps: false,
            onlyAppsWithLaunchIntent: false)
        .then((result) => setState(() {
              for (int i = 0; i < result.length; i++) {
                if (result[i].appName == "ATM Milano") {
                  package = result[i].packageName;
                  flag = true;
                  //print(" $flag + $package");
                }
              }
            }));
    if (flag == true) {
      DeviceApps.openApp(package);
    } else {
      if (await canLaunch(dt))
        await launch(dt);
      else
        throw 'Could not launch $dt';
    }
  }

  Future<void> showChoiceDialog(_viewModel, BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Make a choice"),
              content: SingleChildScrollView(
                  child: ListBody(children: <Widget>[
                GestureDetector(
                    child: Text("Gallery"),
                    onTap: () {
                      _openGallery(_viewModel, context);
                    }),
                GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      _openCamera(_viewModel, context);
                    })
              ])));
        });
  }

  _openCamera(_viewModel, BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    final bytes = picture.readAsBytesSync();
    String img64 = base64Encode(bytes);
    await updatePhoto(_viewModel.c.email, img64);
    await setPhoto(img64);
    StoreProvider.of<AppState>(context).dispatch(updateCustomer(
        name: _viewModel.c.name,
        email: _viewModel.c.email,
        photo: img64,
        notification: _viewModel.c.notification));
    Navigator.of(context).pop();
  }

  _openGallery(_viewModel, BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    final bytes = picture.readAsBytesSync();
    String img64 = base64Encode(bytes);
    await updatePhoto(_viewModel.c.email, img64);
    await setPhoto(img64);
    StoreProvider.of<AppState>(context).dispatch(updateCustomer(
        name: _viewModel.c.name,
        email: _viewModel.c.email,
        photo: img64,
        notification: _viewModel.c.notification));
    Navigator.of(context).pop();
  }

  ImageProvider getPhoto(photo) {
    if (photo == null) {
      return NetworkImage(
          "https://loverary.files.wordpress.com/2013/10/facebook-default-no-profile-pic.jpg?w=619&zoom=2");
    }
    if (photo is String && photo.length > 200) {
      return new MemoryImage(base64Decode(photo));
    } else {
      return new NetworkImage(photo);
    }
  }
}
