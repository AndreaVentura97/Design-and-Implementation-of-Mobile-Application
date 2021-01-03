import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/redux/model/AppState.dart';
import 'package:flutter_app/redux/model/customer.dart';
import 'package:flutter_app/src/services/sendNotification.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter_app/src/view/userAccountWidget.dart';
import 'package:flutter_app/src/view/viewModel.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'map.dart';
import '../checkLogin.dart';
import 'login.dart';
import 'myCommentsScreen.dart';
import 'myStations.dart';
import 'notificationScreen.dart' as not;
import 'notificationWidget.dart';


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
                title: Row(
<<<<<<< HEAD
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                    'Welcome back',
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.5,
                      fontFamily: 'FredokaOne',
                    ),
                    textAlign: TextAlign.left,
                  ),
                    NotificationWidget(),
                ]
=======
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome back',
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.5,
                          fontFamily: 'FredokaOne',
                        ),
                        textAlign: TextAlign.left,
                      ),
                      NotificationWidget(),
                    ]
>>>>>>> 7544a1657651c3210c12bc374f5048aca8be625a
                ),
                centerTitle: true,
                backgroundColor: Colors.blue[900],
              ),
              drawer: UserAccount(),
              body: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 10.0,
                      // width: 300.0,
                      // child: Carousel(
                      //
                      // ),
                    ),

                    CarouselSlider(
                      options: CarouselOptions(
                        height: 250.0,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        autoPlayInterval: Duration(seconds: 5),
                      ),
                      items: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.grey,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.green,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.blue,
                          ),
                        )
                      ],
                    ),

                    SizedBox(height: 15.0,),


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






