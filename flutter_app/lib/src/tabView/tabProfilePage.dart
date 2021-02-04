import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/services/stationServices.dart';
import 'package:flutter_app/src/view/userAccountWidget.dart';
import '../services/userService.dart';
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
import 'package:percent_indicator/percent_indicator.dart ';
import '../view/loadingTab.dart';
import 'tabDrawerWidget.dart';

class TabProfile extends StatefulWidget {
  var email;

  TabProfileState createState() => TabProfileState();

  TabProfile({Key key, this.email}) : super(key: key);
}

class TabProfileState extends State<TabProfile> {
  var numberComments;
  var totalLikes = 0;
  var totalUnlikes = 0;
  var commentMostLike;
  var commentMostUnLike;
  var win;
  var totalLikesGiven = 0;
  var totalUnlikesGiven = 0;
  bool ready = false;

  void takeMyStatistics() async {
    getNumberOfMyComments(widget.email).then((result) => setState(() {
          numberComments = result;
        }));
    getNumberOfLikes(widget.email).then((result) => setState(() {
          totalLikes = result;
        }));
    getNumberOfUnLikes(widget.email).then((result) => setState(() {
          totalUnlikes = result;
        }));
    getCommentWithMostLike(widget.email).then((result) => setState(() {
          commentMostLike = result;
        }));
    getCommentWithMostUnLike(widget.email).then((result) => setState(() {
          commentMostUnLike = result;
          ready = true;
        }));
    getLikesGiven(widget.email).then((result) => setState(() {
          totalLikesGiven = result;
        }));
    getUnlikesGiven(widget.email).then((result) => setState(() {
          totalUnlikesGiven = result;
        }));
    // setState(() {
    //   ready = true;
    // });
  }

  @override
  void initState() {
    takeMyStatistics();
    super.initState();
  }

  Widget build(BuildContext context) {
    return new StoreConnector<AppState, ViewModel>(
        converter: (store) => createViewModel(store),
        builder: (context, _viewModel) {
          return (ready) ? Scaffold(
            resizeToAvoidBottomPadding: false,
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.grey,
            appBar: AppBar(
              backgroundColor: Colors.blue[900],
              title: Row(
                children: [
                  Text("Profile",
                    style: TextStyle(
                      fontSize: 25,
                    )
                  ),
                ],
              ),
            ),
            drawer: TabDrawer(),
            body: Container(
              child: Stack(
                children: [
                  Stack(children: [
                    Container(
                      color: Colors.white,
                      child: Center(
                        child: Container(
                          height: 300,
                          width: 200,
                          child: FittedBox(
                            child: Image.asset(
                              'assets/Logo_Name.jpeg',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: Color.fromRGBO(255, 255, 255, 0.3),
                    )
                  ]),
                  Column(
                    children: [
                      Container(
                        //color: Colors.green,
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              //color: Colors.yellow,
                              child: InkWell(
                                  child: new CircleAvatar(
                                    backgroundImage:
                                        getPhoto(_viewModel.c.photo),
                                    radius: 40,
                                  ),
                                  onTap: () {
                                    showChoiceDialog(_viewModel, context);
                                  }),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children: [
                                  Icon(
                                    Icons.account_box,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "${_viewModel.c.name}",
                                    style: TextStyle(
                                      fontSize: 20,
                                      //fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]),
                                Row(children: [
                                  Icon(
                                    Icons.email,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "${_viewModel.c.email}",
                                    style: TextStyle(
                                      fontSize: 20,
                                      //fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ]),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                        thickness: 1.0,
                        indent: 10,
                        endIndent: 10,
                      ),
                      Container(
                        //color: Colors.grey[300],
                        child: Column(
                          children: [
                            Card(
                              elevation: 3.0,
                              margin:
                                  EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(
                                  color: Colors.blue[900],
                                  width: 2.0,
                                ),
                              ),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Text(
                                        'Main Activities',
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w900,
                                            color: Colors.blue[900]),
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.blue[900],
                                      thickness: 1,
                                    ),
                                    Container(
                                      //color: Colors.green,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(children: [
                                            Icon(Icons.circle, size: 10),
                                            Text(" Comments:",
                                                style: TextStyle(fontSize: 20))
                                          ]),
                                          Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5),
                                              child: Column(children: [
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Total Comment:",
                                                        style: TextStyle(
                                                          fontSize: 16.0,
                                                        ),
                                                      ),
                                                      Text(
                                                        "$numberComments",
                                                        style: TextStyle(
                                                            fontSize: 22.0),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text('Most liked:',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      16.0)),
                                                          Container(
                                                            child: Row(
                                                              children: [
                                                                Icon(
                                                                    Icons
                                                                        .thumb_up,
                                                                    color: Colors
                                                                        .green,
                                                                    size: 20),
                                                                (commentMostLike ==
                                                                        null)
                                                                    ? Text(
                                                                        '(-)',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                22.0))
                                                                    : Text(
                                                                        '(${commentMostLike['nl']})',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                22.0))
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      (commentMostLike == null)
                                                          ? Text(
                                                              "You don't have comment")
                                                          : Text(
                                                              "  ${commentMostLike['station']} - '${commentMostLike['text']}' ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                          .grey[
                                                                      600],
                                                                  fontSize: 14),
                                                            ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text('Most unliked:',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      16.0)),
                                                          Container(
                                                            child: Row(
                                                              children: [
                                                                Icon(
                                                                    Icons
                                                                        .thumb_down,
                                                                    color: Colors
                                                                        .red,
                                                                    size: 20),
                                                                (commentMostUnLike ==
                                                                        null)
                                                                    ? Text(
                                                                        '(-)',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                22.0))
                                                                    : Text(
                                                                        '(${commentMostUnLike['nu']})',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                22.0))
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      (commentMostUnLike ==
                                                              null)
                                                          ? Text(
                                                              "You don't have comment")
                                                          : Text(
                                                              "  ${commentMostUnLike['station']} - '${commentMostUnLike['text']}' ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                          .grey[
                                                                      600],
                                                                  fontSize: 14),
                                                            ),
                                                    ],
                                                  ),
                                                ),
                                              ]))
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      //color: Colors.green,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(children: [
                                            Icon(Icons.circle, size: 10),
                                            Text(" Interactions:",
                                                style: TextStyle(fontSize: 20))
                                          ]),
                                          Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        child: Column(
                                                            children: [
                                                          new CircularPercentIndicator(
                                                            radius: 130.0,
                                                            animation: true,
                                                            animationDuration:
                                                                500,
                                                            lineWidth: 15.0,
                                                            percent: totalUnlikes /
                                                                (totalLikes +
                                                                    totalUnlikes),
                                                            center: Container(
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Column(
                                                                          children: [
                                                                            Icon(Icons.thumb_up,
                                                                                color: Colors.green),
                                                                            Text(
                                                                              '($totalLikes)',
                                                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                                            )
                                                                          ]),
                                                                      Text(
                                                                        " | ",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                40),
                                                                      ),
                                                                      Column(
                                                                          children: [
                                                                            Icon(Icons.thumb_down,
                                                                                color: Colors.red),
                                                                            Text(
                                                                              '($totalUnlikes)',
                                                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                                            )
                                                                          ]),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            circularStrokeCap:
                                                                CircularStrokeCap
                                                                    .butt,
                                                            backgroundColor:
                                                                Colors.green,
                                                            progressColor:
                                                                Colors.red,
                                                          ),
                                                          Text("Received",
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700))
                                                        ])),
                                                    Container(
                                                        child: Column(
                                                            children: [
                                                          new CircularPercentIndicator(
                                                            radius: 130.0,
                                                            animation: true,
                                                            animationDuration:
                                                                1200,
                                                            lineWidth: 15.0,
                                                            percent: totalUnlikesGiven /
                                                                (totalLikesGiven +
                                                                    totalUnlikesGiven),
                                                            center: Container(
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Column(
                                                                          children: [
                                                                            Icon(Icons.thumb_up,
                                                                                color: Colors.green),
                                                                            Text(
                                                                              '($totalLikesGiven)',
                                                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                                            )
                                                                          ]),
                                                                      Text(
                                                                        " | ",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                40),
                                                                      ),
                                                                      Column(
                                                                          children: [
                                                                            Icon(Icons.thumb_down,
                                                                                color: Colors.red),
                                                                            Text(
                                                                              '($totalUnlikesGiven)',
                                                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                                            )
                                                                          ]),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            circularStrokeCap:
                                                                CircularStrokeCap
                                                                    .butt,
                                                            backgroundColor:
                                                                Colors.green,
                                                            progressColor:
                                                                Colors.red,
                                                          ),
                                                          Text(
                                                            "Given",
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          )
                                                        ]))
                                                  ]))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Text(
                            //     "If the difference between your likes and your don't like is greater than 50 you win a ticket!!!"),
                            // (totalLikes - totalUnlikes >= 50)
                            //     ? Text("You have won a ticket!! Get it")
                            //     : Text(
                            //     "You miss ${50 - (totalLikes - totalUnlikes)} likes to win!!"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ): Loading();
        });
  }

  Future<void> showChoiceDialog(_viewModel, BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(
                "Make a choice",
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
                        Icon(
                          Icons.image_outlined,
                          size: 25,
                        ),
                        Text(
                          " Gallery",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      _openGallery(_viewModel, context);
                    }),
                SizedBox(
                  height: 5,
                ),
                GestureDetector(
                    child: Row(
                      children: [
                        Icon(
                          Icons.camera_alt_outlined,
                          size: 25,
                        ),
                        Text(
                          " Camera",
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
