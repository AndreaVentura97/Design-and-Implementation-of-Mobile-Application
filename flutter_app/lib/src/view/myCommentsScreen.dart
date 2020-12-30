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


class MyComments extends StatefulWidget {

  MyCommentsState createState() => MyCommentsState();
}


class MyCommentsState extends State<MyComments> {
  List myComments = [];




  void retrieveMyComments(email) {
    getMyComments(email).then((mounted) ? ((netComments) => setState(() {
        myComments = netComments;
    })): null);
  }


  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return new StoreConnector <AppState,ViewModel>(
        converter : (store) => createViewModel(store),
        onInit: (store) => retrieveMyComments(store.state.customer.email),
        builder: (context,_viewModel) {
          return Scaffold(
              appBar: AppBar(
                title: Text("Comments"),
              ),
              body: ListView.builder(
                //shrinkWrap: true,
                itemCount: myComments.length,
                itemBuilder: (BuildContext context, int index) {
                  return
                  //   ListTile(
                  //     contentPadding: EdgeInsets.all(10.0),
                  //     title: Row(
                  //       children: [
                  //         Text(myComments[index]['station'],
                  //             style: TextStyle(
                  //                 fontSize: 20,
                  //                 fontWeight: FontWeight.w500,
                  //                 color: Colors.black)),
                  //         Text(":  "),
                  //         Text(myComments[index]['text'],
                  //             style: TextStyle(
                  //                 fontSize: 15,
                  //                 fontWeight: FontWeight.w500,
                  //                 color: Colors.black)),
                  //         Text("Tot Like: ${myComments[index]['nl']}"),
                  //         Text("Tot UnLike: ${myComments[index]['nu']}"),
                  //       ],
                  //     )
                  // );
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
                                      // CircleAvatar(
                                      //   backgroundColor: Colors.blue[900],
                                      //   radius: 15.0,
                                      // ),
                                      SizedBox(width: 10.0,),
                                      IntrinsicWidth(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(myComments[index]['station'],
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black
                                                )
                                            ),
                                            // Text(messages[index]['name'],
                                            //     style: TextStyle(
                                            //         fontSize: 18.0,
                                            //         fontWeight: FontWeight.w500,
                                            //         color: Colors.black)),
                                            // Container(
                                            //   color: Colors.black,
                                            //   child: Row(
                                            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            //     children: [
                                            //       Text(messages[index]['date'],
                                            //         style: TextStyle(
                                            //           fontSize: 15.0,
                                            //           color: Colors.grey,
                                            //         ),
                                            //       ),
                                            //
                                            //       //
                                            //       // Da cambiare in base se cittadino o visitatiore
                                            //       Text('Citizen',
                                            //         style: TextStyle(
                                            //           fontSize: 15.0,
                                            //           color: Colors.grey,
                                            //         ),
                                            //       ),
                                            //     ],
                                            //   ),
                                            // ),

                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  // trailing: SmoothStarRating(
                                  //   rating: 5,
                                  //   starCount: 5,
                                  //   isReadOnly: true,
                                  //   color: Colors.amber,
                                  // )
                              ),
                              Text(myComments[index]['text'],
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black
                                  )
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(Icons.thumb_up,
                                          size: 25.0,
                                          color: Colors.green,
                                      ),
                                  Text("${myComments[index]['nl']}"),
                                  Icon(Icons.thumb_down,
                                          size: 25.0,
                                          color: Colors.red,
                                     ),
                                  Text("${myComments[index]['nu']}"),
                                ],
                              ),

                            ],
                          ),
                        )
                    ),
                  );
                },
              )
          );
        }

    );
  }
}