import 'package:flutter/material.dart';
import 'package:flutter_app/src/services/sendNotification.dart';
import 'package:flutter_app/src/view/userAccountWidget.dart';
import 'package:flutter_app/redux/model/AppState.dart';
import 'package:flutter_app/src/view/viewModel.dart';
import 'package:flutter_app/src/services/stationServices.dart';
import 'displayMenuStation.dart';
import 'loadingTab.dart';
import '../services/service.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../services/messagesService.dart';
import '../services/userService.dart';
import '../services/stationServices.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_app/redux/model/AppState.dart';
import 'package:flutter_app/redux/model/customer.dart';

import 'package:delayed_display/delayed_display.dart';


import '../services/stationServices.dart';
import '../services/service.dart';


class MyComments extends StatefulWidget {
  String station;
  MyComments({Key key, this.station}) : super(key: key);
  MyCommentsState createState() => MyCommentsState();
}


class MyCommentsState extends State<MyComments> {
  List myComments = [];
  List myCommentsInteractions = [];
  bool show = false;
  var valueDrop = "Date";


  var ready = false;





  void retrieveMyComments(email) {
    getMyComments(email).then( ((netComments) => setState(() {
        myComments = new List.from(netComments.reversed);
        for (int i = 0; i < myComments.length; i++){
          informationStationByName(myComments[i]['station']).then((result) => setState((){
            myComments[i]['_id'] = result['line'];

          }));
        }

    })));
    getMyComments(email).then( ((netComments) => setState(() {
      myCommentsInteractions = orderListByInteractions(netComments);
      for (int i = 0; i < myCommentsInteractions.length; i++){
        informationStationByName(myCommentsInteractions[i]['station']).then((result) => setState((){
          myCommentsInteractions[i]['_id'] = result['line'];
        }));

      }

    })));
    ready = true;
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String buildAsset(name){
    if (name == "Metro M1"){
      return "assets/M1.jpeg";
    }
    if (name == "Metro M2"){
      return "assets/M2.jpeg";
    }
    if (name == "Metro M3"){
      return "assets/M3.jpeg";
    }
    if (name == "Metro M5"){
      return "assets/M5.jpeg";
    }
    if (name == "Metro M1-M2"){
      return "assets/M1-M2.jpeg";
    }
    if (name == "Metro M1-M3"){
      return "assets/M1-M3.jpeg";
    }
    if (name == "Metro M2-M3"){
      return "assets/M2-M3.jpeg";
    }
  }

  Widget build(BuildContext context) {
    return new StoreConnector <AppState,ViewModel>(
        converter : (store) => createViewModel(store),
        onInit: (store) => retrieveMyComments(store.state.customer.email),
        builder: (context,_viewModel) {
          return Scaffold(
            backgroundColor: Colors.grey[300],
                appBar: AppBar(
                  backgroundColor: Colors.blue[900],
                  title: Text("My Comments"),
                ),
                drawer: UserAccount(),
                body: (ready) ? DelayedDisplay(
                  delay: Duration(milliseconds:2000),
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
                            color: Colors.grey[300],
                            child:Column(
                              children: [
                                Container(
                            //color: Colors.red,
                            padding: EdgeInsets.fromLTRB(10,10,10,10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("  Sorted by:",
                                    style: TextStyle(
                                      fontSize: 22
                                    ),
                                  ),
                                   DropdownButton(
                             value: valueDrop,
                             items: [
                              DropdownMenuItem(
                                 child: Text("   Date",
                                   style: TextStyle(
                                       fontSize: 22
                                   )),
                                 value: "Date",
                               ),
                               DropdownMenuItem(
                                 child: Text("   Interactions",
                                   style: TextStyle(
                                       fontSize: 22
                                   ),),
                                 value: "Interactions",
                               ),
                             ],
                             onChanged: (value) {
                               setState(() {
                                 valueDrop = value;
                                 });
                             })
                             ],

                              ),
                          ),
                                Divider(
                                  thickness: 1.0,
                                  height: 1,
                                  color: Colors.black,
                                ),

                              ]
                            )
                          ),
                          Expanded(
                            child: (valueDrop == "Date") ? ListView.builder(
                                      //shrinkWrap: true,
                                      itemCount: myComments.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return GestureDetector(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder:(context)=>MenuStation(name:myComments[index]['station'])));
                                          },
                                          child: Column(
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
                                                                        child: DelayedDisplay(
                                                                          delay: Duration(milliseconds:1000),
                                                                          child: InkWell(
                                                                            child: DelayedDisplay(
                                                                              delay: Duration(milliseconds:1000),
                                                                              child: Image(
                                                                                image: (buildAsset(myComments[index]['_id'])!=null) ? AssetImage(buildAsset(myComments[index]['_id'])) : AssetImage('assets/loading.jpeg'),
                                                                                height: 30.0,
                                                                                width: 45.0,
                                                                              ),
                                                                            ),
                                                                              onTap: (){
                                                                                Navigator.push(context, MaterialPageRoute(builder:(context)=>MenuStation(name:myComments[index]['station'])));
                                                                              }
                                                                          ),
                                                                        )
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
                                                                  trailing: IconButton(icon: Icon(Icons.close), onPressed: (){
                                                                    deleteMyComment(myComments[index]['text'], myComments[index]['station'], myComments[index]['name']);
                                                                    setState(() {
                                                                      myCommentsInteractions = removeFromList(myCommentsInteractions,myComments[index]['text'], myComments[index]['station'], myComments[index]['email']);
                                                                      myComments.remove(myComments[index]);
                                                                      show = true;

                                                                    });
                                                                  }),
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
                                          ),
                                        );
                                      },
                                    ) : ListView.builder(
                              //shrinkWrap: true,
                              itemCount: myCommentsInteractions.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder:(context)=>MenuStation(name:myComments[index]['station'])));
                                  },
                                  child: Column(
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
                                                          child: DelayedDisplay(
                                                            delay: Duration(seconds:1),
                                                            child: InkWell(
                                                                child: Image(
                                                                  image: AssetImage(buildAsset(myCommentsInteractions[index]['_id'])),
                                                                  height: 30.0,
                                                                  width: 45.0,
                                                                ),
                                                                onTap: (){
                                                                  Navigator.push(context, MaterialPageRoute(builder:(context)=>MenuStation(name:myCommentsInteractions[index]['station'])));
                                                                }
                                                            ),
                                                          )
                                                      ),
                                                      SizedBox(width: 10.0,),
                                                      IntrinsicWidth(
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(myCommentsInteractions[index]['station'],
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
                                                                  Text(myCommentsInteractions[index]['date'],
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
                                                  trailing: IconButton(icon: Icon(Icons.close), onPressed: (){
                                                    deleteMyComment(myCommentsInteractions[index]['text'], myCommentsInteractions[index]['station'], myCommentsInteractions[index]['name']);
                                                    setState(() {
                                                      myComments = removeFromList(myComments,myCommentsInteractions[index]['text'], myCommentsInteractions[index]['station'], myCommentsInteractions[index]['email']);
                                                      myCommentsInteractions.remove(myCommentsInteractions[index]);
                                                      show = true;
                                                    });
                                                  }),
                                                ),
                                              ),
                                              Container(
                                                //color: Colors.red,
                                                child: Text(myCommentsInteractions[index]['text'],
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
                                                    Text(" ${myCommentsInteractions[index]['nl']} "),
                                                    Icon(Icons.thumb_down,
                                                      size: 25.0,
                                                      color: Colors.red,
                                                    ),
                                                    Text(" ${myCommentsInteractions[index]['nu']} "),
                                                  ],
                                                ),
                                              ),


                                            ],
                                          ),

                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          showAlert()
                        ],
                      ),
                    ],
                  ),



                ): Loading(),
          );

        });
  }

Widget showAlert() {
   if (show)
     return Container(
       color: Colors.amber,
       width: double.infinity,
       padding: EdgeInsets.all(8.0),
       child: Row(
         children: [
           Padding(
             padding: const EdgeInsets.only(right: 8.0),
             child: Icon(Icons.error_outline),
           ),
           Expanded(
             child: AutoSizeText(
               "Comment deleted",
               maxLines: 3,
             ),
           ),
           IconButton(
               icon: Icon(Icons.close),
               onPressed: () {
                 setState(() {
                   show = false;
                 });
               })
         ],
       ),
     );
   return SizedBox(
     height: 0.0,
  );
}
}