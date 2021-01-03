import 'package:flutter/material.dart';
import 'package:flutter_app/src/services/sendNotification.dart';
import 'package:flutter_app/src/view/userAccountWidget.dart';
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
              drawer: UserAccount(),
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
                  Column(
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
                            margin: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 10.0),

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                        //color: Colors.green,
                                        child: ListTile(
                                          dense: true,
                                          contentPadding: EdgeInsets.all(0.0),
                                          title: Row(
                                            children: [
                                              Container(
                                                child: Image(
                                                  image: AssetImage("assets/M1.png"),
                                                  height: 30.0,
                                                  width: 45.0,
                                                ),
                                              ),
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
                                                    Container(
                                                      //color: Colors.black,
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text(myComments[index]['date'],
                                                            style: TextStyle(
                                                              fontSize: 15.0,
                                                              color: Colors.grey,
                                                            ),
                                                          ),

                                                          //
                                                          // Da cambiare in base se cittadino o visitatiore
                                                          // Text('Citizen',
                                                          //   style: TextStyle(
                                                          //     fontSize: 15.0,
                                                          //     color: Colors.grey,
                                                          //   ),
                                                          // ),

                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          trailing: IconButton(icon: Icon(Icons.close), onPressed: null),
                                        ),
                                      ),
                                  Container(
                                    //color: Colors.red,
                                    child: Text(myComments[index]['text'],
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black
                                        )
                                    ),
                                  ),
                                  Container(
                                    //color: Colors.yellow,
                                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(Icons.thumb_up,
                                                size: 25.0,
                                                color: Colors.green,
                                            ),
                                        Text(" ${myComments[index]['nl']} "),
                                        Icon(Icons.thumb_down,
                                                size: 25.0,
                                                color: Colors.red,
                                           ),
                                        Text(" ${myComments[index]['nu']} "),
                                      ],
                                    ),
                                  ),


                                ],
                              ),

                        ),
                      ),
                    ],
                  );
                },
              ));
        });
  }
}