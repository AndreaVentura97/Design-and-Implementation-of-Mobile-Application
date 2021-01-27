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
import 'profile.dart';
import '../checkLogin.dart';
import 'login.dart';
import 'InfoProfileScreen.dart';
import 'myCommentsScreen.dart';
import 'myStations.dart';
import 'notificationScreen.dart' as not;
import 'notificationWidget.dart';
import 'package:image_picker/image_picker.dart';


class UserAccount <State> extends StatefulWidget {


  @override
  _UserAccountState createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  var flag=false;
  var package;
  File imageFile;
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
                            backgroundImage: getPhoto(_viewModel.c.photo)
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
                            title: Text("Change photo"),
                            onTap: () {
                              showChoiceDialog(_viewModel, context);
                            }
                        ),
                        new ListTile(
                            title: Text("Profile"),
                            onTap: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(
                                  builder: (BuildContext context) => InfoProfile(email:_viewModel.c.email)));
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



  Future<void> showChoiceDialog (_viewModel,BuildContext context){
    return showDialog (context:context, builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Make a choice"),
        content: SingleChildScrollView(
          child: ListBody(
          children: <Widget>[
            GestureDetector(
              child: Text("Gallery"),
              onTap: (){
                _openGallery(_viewModel,context);
              }
           ),
            GestureDetector(
                child: Text("Camera"),
                onTap: (){
                  _openCamera(_viewModel,context);
                }
            )
          ]
      )
      )
      );
    });
  }

  _openCamera(_viewModel, BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    final bytes = picture.readAsBytesSync();
    String img64 = base64Encode(bytes);
    await updatePhoto(_viewModel.c.email,img64);
    await setPhoto(img64);
    StoreProvider.of<AppState>(context).dispatch(updateCustomer(name:_viewModel.c.name,email:_viewModel.c.email,photo:img64,notification: _viewModel.c.notification));
    Navigator.of(context).pop();

  }
  _openGallery(_viewModel,
      BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    final bytes = picture.readAsBytesSync();
    String img64 = base64Encode(bytes);
    await updatePhoto(_viewModel.c.email,img64);
    await setPhoto(img64);
    StoreProvider.of<AppState>(context).dispatch(updateCustomer(name:_viewModel.c.name,email:_viewModel.c.email,photo:img64,notification: _viewModel.c.notification));
    Navigator.of(context).pop();

  }

  ImageProvider getPhoto (photo){
    if(photo == null){
      return NetworkImage("https://loverary.files.wordpress.com/2013/10/facebook-default-no-profile-pic.jpg?w=619&zoom=2");
    }
    if(photo is String && photo.length > 200) {
      return new MemoryImage(base64Decode(photo));
    }
    else {
      return new NetworkImage(photo);
    }

  }
}