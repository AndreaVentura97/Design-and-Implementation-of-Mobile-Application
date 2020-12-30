import 'package:flutter/material.dart';
import 'package:flutter_app/src/services/sendNotification.dart';
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
    retrieveMessages(station).then((netMessages) => setState(() {
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
    retrieveMyLikes(email).then((netLikes) => setState(() {
          myLikes = netLikes;
        }));
    retrieveMyUnlikes(email).then((netUnlikes) => setState(() {
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
              body: ListView.builder(
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
                        //color: Colors.blue,
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          //color: Colors.red,
                          margin: EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                  dense: true,
                                  contentPadding: EdgeInsets.all(0.0),
                                  title: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.blue[900],
                                        radius: 15.0,
                                      ),
                                      SizedBox(width: 10.0,),
                                      IntrinsicWidth(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(messages[index]['name'],
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black)),
                                            Container(
                                              color: Colors.black,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(messages[index]['date'],
                                                    style: TextStyle(
                                                      fontSize: 15.0,
                                                      color: Colors.grey,
                                                    ),
                                                  ),

                                                  //
                                                  // Da cambiare in base se cittadino o visitatiore
                                                  Text('Citizen',
                                                    style: TextStyle(
                                                      fontSize: 15.0,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: SmoothStarRating(
                                    rating: 5,
                                    starCount: 5,
                                    isReadOnly: true,
                                    color: Colors.amber,
                                  )
                              ),
                              Text(messages[index]['text'],
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      icon: Icon(Icons.thumb_up,
                                          size: 25.0,
                                          color: ((checkLike(messages[index]['_id'])))
                                              ? Colors.green
                                              : Colors.grey),
                                      onPressed: () {
                                        if ((!checkLike(messages[index]['_id']))) {
                                          if (checkUnlike(messages[index]['_id'])) {
                                            removeUnlike(_viewModel.c.email,
                                                messages[index]['_id']);
                                            setState(() {
                                              myUnlikes.remove(messages[index]['_id']);
                                            });
                                            messages[index]['nu'] =
                                                messages[index]['nu'] - 1;
                                            minusOne2(messages[index]['_id']);
                                          }
                                          insertLike(_viewModel.c.email,
                                              messages[index]['_id']);
                                          setState(() {
                                            myLikes.add(messages[index]['_id']);
                                          });
                                          sendNotification(
                                              messages[index]['email'], "like");
                                          plusOne(messages[index]['_id']);
                                          messages[index]['nl'] =
                                              messages[index]['nl'] + 1;
                                        } else {
                                          removeLike(_viewModel.c.email,
                                              messages[index]['_id']);
                                          setState(() {
                                            myLikes.remove(messages[index]['_id']);
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
                                          color: ((checkUnlike(messages[index]['_id'])))
                                              ? Colors.red
                                              : Colors.grey),
                                      onPressed: () {
                                        if ((!checkUnlike(messages[index]['_id']))) {
                                          if (checkLike((messages[index]['_id']))) {
                                            removeLike(_viewModel.c.email,
                                                messages[index]['_id']);
                                            setState(() {
                                              myLikes.remove(messages[index]['_id']);
                                            });
                                            messages[index]['nl'] =
                                                messages[index]['nl'] - 1;
                                            minusOne(messages[index]['_id']);
                                          }
                                          insertUnlike(_viewModel.c.email,
                                              messages[index]['_id']);
                                          setState(() {
                                            myUnlikes.add(messages[index]['_id']);
                                          });
                                          sendNotification(
                                              messages[index]['email'], "unlike");
                                          plusOne2(messages[index]['_id']);
                                          messages[index]['nu'] =
                                              messages[index]['nu'] + 1;
                                        } else {
                                          removeUnlike(_viewModel.c.email,
                                              messages[index]['_id']);
                                          setState(() {
                                            myUnlikes.remove(messages[index]['_id']);
                                          });
                                          minusOne2(messages[index]['_id']);
                                          messages[index]['nu'] =
                                              messages[index]['nu'] - 1;
                                        }
                                      }),
                                  Text("${messages[index]['nu']}"),
                                ],
                              ),

                            ],
                          ),
                        )
                    ),
                  ),
                  // Divider(
                  //   indent: 10.0,
                  //   endIndent: 10.0,
                  //   color: Colors.black,
                  //   thickness: 1.0,
                  // ),
                ],
              );
            },
          ));
        });
  }
}
