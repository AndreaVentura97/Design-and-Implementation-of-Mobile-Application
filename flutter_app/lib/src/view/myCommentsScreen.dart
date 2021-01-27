import 'package:flutter/material.dart';
import 'package:flutter_app/src/services/sendNotification.dart';
import 'package:flutter_app/src/view/userAccountWidget.dart';
import 'package:flutter_app/redux/model/AppState.dart';
import 'package:flutter_app/src/view/viewModel.dart';
import '../services/service.dart';
import '../services/messagesService.dart';
import '../services/userService.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_app/redux/model/AppState.dart';
import 'package:flutter_app/redux/model/customer.dart';
import '../services/stationServices.dart';
import '../services/service.dart';

class MyComments extends StatefulWidget {
  String station;
  MyComments({Key key, this.station}) : super(key: key);
  MyCommentsState createState() => MyCommentsState();
}


class MyCommentsState extends State<MyComments> {
  List myComments = [];
  List myComments2 = [];
  String line;
  String image = "";



  void retrieveMyComments(email) {
    getMyComments(email).then((mounted) ? ((netComments) => setState(() {
        myComments = new List.from(netComments.reversed);
    })): null);
  }

  void takeStationInformation (){
    informationStation(widget.station).then((information) => setState(() {
      line = information['line'];
      //address = information['address'];
      checkLine(line);
    }));
    pointsStation(widget.station).then((result) => setState(() {
      //points = result;
    }));
  }

  String checkLine(line){
    if (line=="Metro M1"){
      setState(() {
        image = "assets/M1.jpeg";
      });
    }
    if (line=="Metro M2"){
      setState(() {
        image = "assets/M2.jpeg";
      });
    }
    if (line=="Metro M3"){
      setState(() {
        image = "assets/M3.jpeg";
      });
    }
    if (line=="Metro M5"){
      setState(() {
        image = "assets/M5.jpeg";
      });
    };

    return image;
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
                backgroundColor: Colors.blue[900],
              ),
              drawer: UserAccount(),
              body:
                      ListView.builder(
                        //shrinkWrap: true,
                        itemCount: myComments.length,
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
                                                          image: (image!="") ? AssetImage(image) : AssetImage("assets/loading.jpg"),
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
                                                  trailing: IconButton(icon: Icon(Icons.close), onPressed: (){
                                                    deleteMyComment(myComments[index]['_id']);
                                                    setState(() {
                                                      myComments.remove(myComments[index]);
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
                          );
                        },
                      ),


              );
        });
  }

Widget showAlert() {
//   if (_error != null)
//     return Container(
//       color: Colors.amber,
//       width: double.infinity,
//       padding: EdgeInsets.all(8.0),
//       child: Row(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(right: 8.0),
//             child: Icon(Icons.error_outline),
//           ),
//           Expanded(
//             child: AutoSizeText(
//               "$_error",
//               maxLines: 3,
//             ),
//           ),
//           IconButton(
//               icon: Icon(Icons.close),
//               onPressed: () {
//                 setState(() {
//                   _error = null;
//                 });
//               })
//         ],
//       ),
//     );
//   return SizedBox(
//     height: 0.0,
//   );
}
}