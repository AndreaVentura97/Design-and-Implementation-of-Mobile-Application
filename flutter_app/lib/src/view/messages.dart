import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/src/services/sendNotification.dart';
import 'package:flutter_app/src/view/popupVoteScreen.dart';
import 'package:flutter_app/src/view/viewModel.dart';
import '../services/service.dart';
import '../services/messagesService.dart';
import '../services/userService.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_app/redux/model/AppState.dart';
import 'package:flutter_app/redux/model/customer.dart';

import 'package:smooth_star_rating/smooth_star_rating.dart';

class Messages extends StatefulWidget {
  String station = "";

  Messages({Key key, this.station}) : super(key: key);

  MessagesState createState() => MessagesState();
}

class MessagesState extends State<Messages> {
  List messages = [];
  List myLikes = [];
  List myUnlikes = [];

  void listMessages(station) {
    retrieveMessages(station).then((netMessages) =>
        setState(() {
          messages = netMessages;
        }));
  }

  bool checkLike(id) {
    for (int i = 0; i < myLikes.length; i++) {
      if (myLikes[i] == id) {
        return true;
      }
    }
    return false;
  }

  bool checkUnlike(id) {
    for (int i = 0; i < myUnlikes.length; i++) {
      if (myUnlikes[i] == id) {
        return true;
      }
    }
    return false;
  }

  retrieveMyPreference(email) {
    retrieveMyLikes(email).then((netLikes) =>
        setState(() {
          myLikes = netLikes;
        }));
    retrieveMyUnlikes(email).then((netUnlikes) =>
        setState(() {
          myUnlikes = netUnlikes;
        }));
  }


  @override
  void initState() {
    super.initState();
    listMessages(widget.station);
  }

  Widget build(BuildContext context) {
    return new StoreConnector<AppState, ViewModel>(
        converter: (store) => createViewModel(store),
        onInit: (store) => retrieveMyPreference(store.state.customer.email),
        builder: (context, _viewModel) {
          return Scaffold(
            backgroundColor: Colors.grey[300],
              body: Column(
                children: [
                  Container(
                    color: Colors.white,
                    //padding: EdgeInsets.fromLTRB(0,10,0,0),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Row(
                            children: [
                              Text("Sorted by:",
                                style: TextStyle(
                                    fontSize: 22
                                ),
                              ),
                              // DropdownButton(
                              //     value: valueDrop,
                              //     items: [
                              //       DropdownMenuItem(
                              //         child: Text("All users"),
                              //         value: "All",
                              //       ),
                              //       DropdownMenuItem(
                              //         child: Text("Citizens"),
                              //         value: "Citizens",
                              //       ),
                              //   DropdownMenuItem(
                              //     child: Text("Visitors"),
                              //     value: "Visitors",
                              //   ),
                              // ],
                              // onChanged: (value) {
                              //   setState(() {
                              //     valueDrop = value;
                              //     if(value=="Visitors"){
                              //       buildMeanVisitor(widget.station, "cleaning").then((result)=>setState((){
                              //         if (result!=50){
                              //           avgClean = result.toStringAsFixed(1);
                              //         }
                              //         else {
                              //           avgClean = "--";
                              //         }
                              //       }));
                              //       buildMeanVisitor(widget.station, "dis").then((result)=>setState((){
                              //         if (result!=50){
                              //           avgDis = result.toStringAsFixed(1);
                              //         }
                              //         else {
                              //           avgDis = "--";
                              //         }
                              //       }));
                              //       buildMeanVisitor(widget.station, "safety").then((result)=>setState((){
                              //         if (result!=50){
                              //           avgSafety = result.toStringAsFixed(1);
                              //         }
                              //         else {
                              //           avgSafety = "--";
                              //         }
                              //       }));
                              //       buildMeanVisitor(widget.station, "area").then((result)=>setState((){
                              //         if (result!=50){
                              //           avgArea = result.toStringAsFixed(1);
                              //         }
                              //         else {
                              //           avgArea = "--";
                              //         }
                              //       }));
                              //     }
                              //     if (value=="Citizens"){
                              //       buildMeanCitizen(widget.station, "cleaning").then((result)=>setState((){
                              //         if (result!=50){
                              //           avgClean = result.toStringAsFixed(1);
                              //         }
                              //         else {
                              //           avgClean = "--";
                              //         }
                              //       }));
                              //       buildMeanCitizen(widget.station, "dis").then((result)=>setState((){
                              //         if (result!=50){
                              //           avgDis = result.toStringAsFixed(1);
                              //         }
                              //         else {
                              //           avgDis = "--";
                              //         }
                              //       }));
                              //       buildMeanCitizen(widget.station, "safety").then((result)=>setState((){
                              //         if (result!=50){
                              //           avgSafety = result.toStringAsFixed(1);
                              //         }
                              //         else {
                              //           avgSafety = "--";
                              //         }
                              //       }));
                              //       buildMeanCitizen(widget.station, "area").then((result)=>setState((){
                              //         if (result!=50){
                              //           avgArea = result.toStringAsFixed(1);
                              //         }
                              //         else {
                              //           avgArea = "--";
                              //         }
                              //       }));
                              //     }
                              //     if(value=="All") {
                              //       updateMeanClean(widget.station).then((result)=>setState((){
                              //         if (result!=50){
                              //           avgClean = result.toStringAsFixed(1);
                              //         }
                              //         else {
                              //           avgClean = "--";
                              //         }
                              //       }));
                              //       updateMeanDis(widget.station).then((result)=>setState((){
                              //         if (result!=50){
                              //           avgDis = result.toStringAsFixed(1);
                              //         }
                              //         else {
                              //           avgDis = "--";
                              //         }
                              //       }));
                              //       updateMeanSafety(widget.station).then((result)=>setState((){
                              //         if (result!=50){
                              //           avgSafety = result.toStringAsFixed(1);
                              //         }
                              //         else {
                              //           avgSafety = "--";
                              //         }
                              //       }));
                              //       updateMeanArea(widget.station).then((result)=>setState((){
                              //         if (result!=50){
                              //           avgArea = result.toStringAsFixed(1);
                              //         }
                              //         else {
                              //           avgArea = "--";
                              //         }
                              //       }));
                              //     }
                              //   });
                              // });
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                          thickness: 1.0,
                          //indent: 10, endIndent: 10,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: ListView.builder(
                      //shrinkWrap: true,
                      itemCount: messages.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Card(
                                margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                                elevation: 3.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(
                                    color: Colors.blue[900],
                                    width: 2.0,
                                  ),
                                ),
                                child: Container(
                                  //color: Colors.red,
                                  margin: EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        //color: Colors.pink,
                                        child: ListTile(
                                            dense: true,
                                            contentPadding: EdgeInsets.all(0.0),
                                            title: Row(
                                              children: [
                                                CircleAvatar(
                                                  //backgroundColor: Colors.blue[900],
                                                  backgroundImage: getPhoto(
                                                      messages[index]['photo']),
                                                  //updatePhoto,
                                                  radius: 15.0,
                                                ),
                                                SizedBox(width: 10.0,),
                                                IntrinsicWidth(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      InkWell(
                                                          child: Text(
                                                              messages[index]['name'],
                                                              style: TextStyle(
                                                                  fontSize: 18.0,
                                                                  fontWeight: FontWeight
                                                                      .w500,
                                                                  color: Colors
                                                                      .black)),
                                                          onTap: () {
                                                            showDialog(
                                                                context: context,
                                                                builder: (
                                                                    BuildContext context) {
                                                                  return PopupVote(
                                                                      email: messages[index]['email'],
                                                                      station: widget
                                                                          .station);
                                                                });
                                                          }
                                                      ),
                                                      Container(
                                                        //color: Colors.black,
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            Text(
                                                              messages[index]['date'],
                                                              style: TextStyle(
                                                                fontSize: 15.0,
                                                                color: Colors.grey,
                                                              ),
                                                            ),

                                                            //
                                                            // Da cambiare in base se cittadino o visitatiore
                                                            (messages[index]['citizen'])
                                                                ? Text(' - Citizen',
                                                              style: TextStyle(
                                                                fontSize: 15.0,
                                                                color: Colors.grey,
                                                              ),
                                                            )
                                                                : Text(' - Visitor',
                                                              style: TextStyle(
                                                                fontSize: 15.0,
                                                                color: Colors.grey,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                        ),
                                      ),
                                      Container(
                                        //color: Colors.green[100],
                                          child: Text(messages[index]['text'],
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black)),
                                      ),
                                      Container(
                                        //color: Colors.blue[900],
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                                icon: Icon(Icons.thumb_up,
                                                    size: 20.0,
                                                    color: ((checkLike(
                                                        messages[index]['_id'])))
                                                        ? Colors.green
                                                        : Colors.grey),
                                                onPressed: () {
                                                  if ((!checkLike(
                                                      messages[index]['_id']))) {
                                                    if (checkUnlike(
                                                        messages[index]['_id'])) {
                                                      removeUnlike(_viewModel.c.email,
                                                          messages[index]['_id']);
                                                      setState(() {
                                                        myUnlikes.remove(
                                                            messages[index]['_id']);
                                                      });
                                                      messages[index]['nu'] =
                                                          messages[index]['nu'] - 1;
                                                      minusOne2(
                                                          messages[index]['_id']);
                                                    }
                                                    insertLike(_viewModel.c.email,
                                                        messages[index]['_id']);
                                                    setState(() {
                                                      myLikes.add(
                                                          messages[index]['_id']);
                                                    });
                                                    sendNotification(
                                                        messages[index]['email'],
                                                        "like", _viewModel.c.name,
                                                        messages[index]['text'],
                                                        messages[index]['station']);
                                                    plusOne(messages[index]['_id']);
                                                    messages[index]['nl'] =
                                                        messages[index]['nl'] + 1;
                                                  } else {
                                                    removeLike(_viewModel.c.email,
                                                        messages[index]['_id']);
                                                    setState(() {
                                                      myLikes.remove(
                                                          messages[index]['_id']);
                                                    });
                                                    minusOne(messages[index]['_id']);
                                                    messages[index]['nl'] =
                                                        messages[index]['nl'] - 1;
                                                  }
                                                }),
                                            Text("${messages[index]['nl']}"),
                                            IconButton(
                                                icon: Icon(Icons.thumb_down,
                                                    size: 25.0,
                                                    color: ((checkUnlike(
                                                        messages[index]['_id'])))
                                                        ? Colors.red
                                                        : Colors.grey),
                                                onPressed: () {
                                                  if ((!checkUnlike(
                                                      messages[index]['_id']))) {
                                                    if (checkLike(
                                                        (messages[index]['_id']))) {
                                                      removeLike(_viewModel.c.email,
                                                          messages[index]['_id']);
                                                      setState(() {
                                                        myLikes.remove(
                                                            messages[index]['_id']);
                                                      });
                                                      messages[index]['nl'] =
                                                          messages[index]['nl'] - 1;
                                                      minusOne(
                                                          messages[index]['_id']);
                                                    }
                                                    insertUnlike(_viewModel.c.email,
                                                        messages[index]['_id']);
                                                    setState(() {
                                                      myUnlikes.add(
                                                          messages[index]['_id']);
                                                    });
                                                    sendNotification(
                                                        messages[index]['email'],
                                                        "unlike", _viewModel.c.name,
                                                        messages[index]['text'],
                                                        messages[index]['station']);
                                                    plusOne2(messages[index]['_id']);
                                                    messages[index]['nu'] =
                                                        messages[index]['nu'] + 1;
                                                  } else {
                                                    removeUnlike(_viewModel.c.email,
                                                        messages[index]['_id']);
                                                    setState(() {
                                                      myUnlikes.remove(
                                                          messages[index]['_id']);
                                                    });
                                                    minusOne2(messages[index]['_id']);
                                                    messages[index]['nu'] =
                                                        messages[index]['nu'] - 1;
                                                  }
                                                }),
                                            Text("${messages[index]['nu']}"),
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                )
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ));
        });
  }

  ImageProvider getPhoto(photo) {
    if (photo == null) {
      return NetworkImage(
          "https://loverary.files.wordpress.com/2013/10/facebook-default-no-profile-pic.jpg?w=619&zoom=2");
    }
    if (photo is String && photo.length > 200) {
      return new MemoryImage(base64Decode(photo));
    }
    else {
      return new NetworkImage(photo);
    }
  }
}

