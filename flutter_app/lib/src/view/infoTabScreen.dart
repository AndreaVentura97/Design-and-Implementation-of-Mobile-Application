import 'package:flutter/material.dart';
import 'package:flutter_app/redux/model/AppState.dart';
import 'package:flutter_app/src/services/userService.dart';
import 'package:flutter_app/src/view/viewModel.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../services/stationServices.dart';

class InfoStation extends StatefulWidget {
  String station;
  InfoStation({Key key, this.station}) : super(key: key);
  InfoStationState createState() => InfoStationState();
}


class InfoStationState extends State<InfoStation> {
  bool _favStation = false;
  String line;
  String address;

  void takeStationInformation (){
    informationStation(widget.station).then((information) => setState(() {
      line = information['line'];
      address = information['address'];
    }));
  }


  @override
  void initState() {
    super.initState();
    takeStationInformation();

  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector <AppState,ViewModel>(
      converter: (store) => createViewModel(store),
      builder: (context,_viewModel){
        return Scaffold(
            body: SingleChildScrollView(
              child: Column (
                mainAxisAlignment: MainAxisAlignment.center,
                  children:[
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
                      //color: Colors.grey[400],
                      child:Container(
                        margin: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                          Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Image(
                                  image: AssetImage("assets/M1.png"),
                                  height: 50.0,
                                  width: 75.0,
                                ),
                              ),
                              SizedBox(width: 10.0,),
                              Flexible(
                                fit: FlexFit.loose,
                                flex: 2,
                                child: Container(
                                  //color: Colors.green,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("${widget.station}",
                                        style: TextStyle(
                                          fontSize: 25.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                      // Text("$line",
                                      //   style: TextStyle(
                                      //     fontSize: 16.0,
                                      //     color: Colors.grey,
                                      //   ),
                                      // ),
                                      Text("$address",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(_favStation ? Icons.favorite_outline : Icons.favorite,
                                  size: 20.0,
                                ),
                                onPressed: () {
                                  addMyStations(_viewModel.c.email, widget.station);
                                  setState(() {
                                    _favStation = !_favStation;
                                  });
                                },
                              ),
                            ],
                          )
                        ]
                        ),
                      ),
                    ),
                    Card(
                      elevation: 3.0,
                      margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(
                          color: Colors.blue[900],
                          width: 2.0,
                        ),
                      ),
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Related links',
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                            Divider(
                              color: Colors.black,
                              thickness: 1.0,
                            ),
                            SizedBox(height: 10.0),
                            Text('Railway:'),
                            SizedBox(height: 10.0),
                            Text('Tram:'),
                            SizedBox(height: 10.0),
                            Text('Bus:'),
                            SizedBox(height: 10.0),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      elevation: 3.0,
                      margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(
                          color: Colors.blue[900],
                          width: 2.0,
                        ),
                      ),
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Services:',
                              style: TextStyle(
                                fontSize: 18.0
                              ),
                            ),
                            Spacer(),
                            Icon(Icons.elevator, size: 30.0),
                            Icon(Icons.wc, size: 25.0)
                          ],
                        ),
                      ),
                    ),
                    Card(
                      elevation: 3.0,
                      margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(
                          color: Colors.blue[900],
                          width: 2.0,
                        ),
                      ),
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Points of interest:',
                              style: TextStyle(
                                  fontSize: 18.0
                              ),
                            ),
                            Divider(
                              color: Colors.black,
                              thickness: 1.0,
                            ),


                            Container(
                              //height: 150.0,
                              margin: EdgeInsets.symmetric(vertical: 5.0),
                              color: Colors.grey,
                              child: IntrinsicHeight(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
                                          color: Colors.blue,
                                          child: Center(child: Text('Immagine')),
                                          height: 100.0,
                                          width: 100.0,
                                        ),
                                        Expanded(
                                          child: Container(
                                            color: Colors.red,
                                            child: Column(
                                              //mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  color: Colors.orange,
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.restaurant),
                                                      Text('Nome punto di interesse',
                                                        style: TextStyle(
                                                          decoration: TextDecoration.underline,
                                                          color: Colors.blue,
                                                          fontSize: 16.0,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  color: Colors.green[200],
                                                  child: Text('indirizzo'),
                                                ),
                                                Align(
                                                  alignment: Alignment.bottomRight,
                                                  child: Container(
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        IconButton(
                                                            icon: Icon(Icons.thumb_up,
                                                                size: 25.0,
                                                                // color: ((checkLike(messages[index]['_id'])))
                                                                //     ? Colors.green
                                                                //     : Colors.grey
                                                               ),
                                                            onPressed: () {
                                                              // if ((!checkLike(messages[index]['_id']))) {
                                                              //   if (checkUnlike(messages[index]['_id'])) {
                                                              //     removeUnlike(_viewModel.c.email,
                                                              //         messages[index]['_id']);
                                                              //     setState(() {
                                                              //       myUnlikes.remove(messages[index]['_id']);
                                                              //     });
                                                              //     messages[index]['nu'] =
                                                              //         messages[index]['nu'] - 1;
                                                              //     minusOne2(messages[index]['_id']);
                                                                }
                                                                // insertLike(_viewModel.c.email,
                                                                //     messages[index]['_id']);
                                                                // setState(() {
                                                                //   myLikes.add(messages[index]['_id']);
                                                                // });
                                                            //     sendNotification(
                                                            //         messages[index]['email'], "like");
                                                            //     plusOne(messages[index]['_id']);
                                                            //     messages[index]['nl'] =
                                                            //         messages[index]['nl'] + 1;
                                                            //   } else {
                                                            //     removeLike(_viewModel.c.email,
                                                            //         messages[index]['_id']);
                                                            //     setState(() {
                                                            //       myLikes.remove(messages[index]['_id']);
                                                            //     });
                                                            //     minusOne(messages[index]['_id']);
                                                            //     messages[index]['nl'] =
                                                            //         messages[index]['nl'] - 1;
                                                            //   }
                                                            // }
                                                            ),
                                                        Text("0"), //${messages[index]['nl']}"),
                                                        IconButton(
                                                            icon: Icon(Icons.thumb_down,
                                                                size: 25.0,
                                                                // color: ((checkUnlike(messages[index]['_id'])))
                                                                //     ? Colors.red
                                                                //     : Colors.grey
                                                                     ),
                                                            onPressed: () {
                                                              // if ((!checkUnlike(messages[index]['_id']))) {
                                                              //   if (checkLike((messages[index]['_id']))) {
                                                              //     removeLike(_viewModel.c.email,
                                                              //         messages[index]['_id']);
                                                              //     setState(() {
                                                              //       myLikes.remove(messages[index]['_id']);
                                                              //     });
                                                              //     messages[index]['nl'] =
                                                              //         messages[index]['nl'] - 1;
                                                              //     minusOne(messages[index]['_id']);
                                                                }
                                                            //     insertUnlike(_viewModel.c.email,
                                                            //         messages[index]['_id']);
                                                            //     setState(() {
                                                            //       myUnlikes.add(messages[index]['_id']);
                                                            //     });
                                                            //     sendNotification(
                                                            //         messages[index]['email'], "unlike");
                                                            //     plusOne2(messages[index]['_id']);
                                                            //     messages[index]['nu'] =
                                                            //         messages[index]['nu'] + 1;
                                                            //   } else {
                                                            //     removeUnlike(_viewModel.c.email,
                                                            //         messages[index]['_id']);
                                                            //     setState(() {
                                                            //       myUnlikes.remove(messages[index]['_id']);
                                                            //     });
                                                            //     minusOne2(messages[index]['_id']);
                                                            //     messages[index]['nu'] =
                                                            //         messages[index]['nu'] - 1;
                                                            //   }
                                                            // }
                                                            ),
                                                        Text("0"), //${messages[index]['nu']}"),
                                                      ],

                                                  ),
                                                )
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),

                              //   ],
                              // ),
                            ),


                            Container(
                              height: 150.0,
                              margin: EdgeInsets.symmetric(vertical: 5.0),
                              color: Colors.green,
                            ),
                            Container(
                              height: 150.0,
                              margin: EdgeInsets.symmetric(vertical: 5.0),
                              color: Colors.yellow,
                            ),
                            Container(
                              height: 150.0,
                              margin: EdgeInsets.symmetric(vertical: 5.0),
                              color: Colors.red,
                            )
                          ],
                        ),
                      ),
                    )

                  ]
              ),
            )
        );
      },
    );
  }
}