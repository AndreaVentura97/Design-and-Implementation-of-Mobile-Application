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
import 'map.dart';
import 'login.dart';
import 'InfoProfileScreen.dart';
import 'myCommentsScreen.dart';
import 'myStations.dart';
import 'notificationScreen.dart' as not;
import 'notificationWidget.dart';
import 'package:image_picker/image_picker.dart';


class UserAccount extends StatefulWidget {


  @override
  UserAccountState createState() => UserAccountState();
}

class UserAccountState extends State<UserAccount> {
  var flag=false;
  var package;
  File imageFile;


  @override
  void initState() {
    super.initState();
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



  @override
  Widget build(BuildContext context) {
    return new StoreConnector <AppState,ViewModel>(
        converter : (store) => createViewModel(store),
        builder : (context, _viewModel) {

          return
            new Drawer(
                child: ListView(
                    children: <Widget>[
                      // DrawerHeader(child: Container(
                      //   color: Colors.blue[900],
                      //   padding: EdgeInsets.zero,
                      // )
                      // ),
                      InkWell(
                        child: new UserAccountsDrawerHeader(
                          decoration: BoxDecoration(
                              color: Colors.blue[900]
                          ),
                          accountName: Row(children: [
                            Icon(
                              Icons.account_box_outlined,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10,),
                            Text("${_viewModel.c.name}",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ]),
                          accountEmail: Row(children: [
                            Icon(
                              Icons.email,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10,),
                            Text("${_viewModel.c.email}",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ]),
                          currentAccountPicture: Container(
                            //color: Colors.yellow,
                            child: new CircleAvatar(
                                  backgroundImage: getPhoto(_viewModel.c.photo),
                                ),
                          ),
                        ),
                        onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (BuildContext context) => InfoProfile(email:_viewModel.c.email)));
                        },
                      ),
                      new ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("    "),
                              Icon(Icons.location_on, color: Colors.blue[900],),
                              Text("   Map", style: TextStyle( color: Colors.blue[900], fontSize: 18),),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder:(context)=> Map()));
                          }
                      ),
                      new ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("    "),
                              Icon(Icons.train, color: Colors.blue[900],),
                              Text("   My Stations", style: TextStyle( color: Colors.blue[900], fontSize: 18),),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder:(context)=> MyStations (email: _viewModel.c.email)));
                          }
                      ),
                      new ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("    "),
                              Icon(Icons.comment, color: Colors.blue[900],),
                              Text("   My Comments ", style: TextStyle( color: Colors.blue[900], fontSize: 18),),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder:(context)=> MyComments ()));
                          }
                      ),
                      new ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            NotificationWidget(),
                            Text("Notifications ", style: TextStyle( color: Colors.blue[900], fontSize: 18),),


                          ],
                        ),

                      ),
                      new ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("    "),
                              Icon(Icons.account_balance_wallet, color: Colors.blue[900],),
                              Text("   Buy a ticket", style: TextStyle( color: Colors.blue[900], fontSize: 18),),
                            ],
                          ),
                          onTap: () {
                            openApp();
                          }
                      ),


                      // new ListTile(
                      //     title: Text("Profile"),
                      //     onTap: () {
                      //       Navigator.pushReplacement(context, MaterialPageRoute(
                      //           builder: (BuildContext context) => InfoProfile(email:_viewModel.c.email)));
                      //     }
                      // ),

                      new ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("    "),
                            Icon(Icons.exit_to_app, color: Colors.blue[900],),
                            Text("   Logout", style: TextStyle( color: Colors.blue[900], fontSize: 18),),
                          ],
                        ),
                        onTap: () {
                          setLogged(false);
                          changeToken(_viewModel.c.email);
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



  Future<void> showChoiceDialog(_viewModel, BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Make a choice",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: SingleChildScrollView(
                  child: ListBody(children: <Widget>[
                    GestureDetector(
                        child: Row(
                          children: [
                            Icon(Icons.image_outlined,
                              size: 25,
                            ),
                            Text(" Gallery",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          _openGallery(_viewModel, context);
                        }),
                    SizedBox(height: 5,),
                    GestureDetector(
                        child: Row(
                          children: [
                            Icon(Icons.camera_alt_outlined,
                              size: 25,
                            ),
                            Text(" Camera",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
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


}