import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/redux/model/AppState.dart';
import 'package:flutter_app/src/view/viewModel.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../services/stationServices.dart';
import '../services/userService.dart';
import 'package:flutter_app/src/services/service.dart';

class PopupVote extends StatefulWidget {
  String email;
  String station;

  PopupVote({Key key, this.email,this.station}) : super(key: key);

  PopupVoteState createState() => PopupVoteState();
}

class PopupVoteState extends State<PopupVote> {
  var cleaning;
  var dis;
  var safety;
  var area;
  List<bool> voting = [false, false, false, false];

  retrieveMyVotes() {
    retrieveMyVoteCleaning(widget.email, widget.station).then((vote) => setState(() {
      cleaning = vote;
      if(vote!=50.00) {
        voting[0]=true;
      }
    }));
    retrieveMyVoteDis(widget.email, widget.station).then((vote) => setState(() {
      dis = vote;
      if(vote!=50.00) {
        voting[1]=true;
      }
    }));
    retrieveMyVoteSafety(widget.email, widget.station).then((vote) => setState(() {
      safety = vote;
      if(vote!=50.00) {
        voting[2]=true;
      }
    }));
    retrieveMyVoteArea(widget.email, widget.station).then((vote) => setState(() {
      area = vote;
      if(vote!=50.00) {
        voting[3]=true;
      }
    }));
  }

  @override
  void initState() {
    super.initState();
    retrieveMyVotes();
  }

  @override
  Widget build(BuildContext context) {

    Widget meanValues(String Title, MeanValue) {
      return Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Column(
            children: [
              Text(Title,
                style: TextStyle(
                    //fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 50,
                width: 50,
                decoration:
                BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.blue[900],
                    width: 2,
                  ),
                  //boxShadow: [BoxShadow( blurRadius: 10, spreadRadius: 10)],
                ),
                child: Center(
                  child: (MeanValue!=null) ?
                  Text(MeanValue,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ) :
                  Text("--",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              )
            ],
          ),
        ),
      );
    }

    return Dialog(
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: Colors.blue[900],
          width: 2.0,
        ),
      ),
      child: Card(
        child: Container(
          //color: Colors.red,
          //padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      color: Colors.blue,
                      height: 30,
                      width: 30,
                      // child: new CircleAvatar(
                      //       backgroundImage: photo,
                      //       radius: 40,
                      //     ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: Column(
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
                              "Nome Utente",
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
                              "Mail Utente",
                              style: TextStyle(
                                fontSize: 20,
                                //fontWeight: FontWeight.bold
                              ),
                            ),
                          ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total comments:",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                              Text("20",//"$numberComments",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18.0
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total Interactions:",
                                style: TextStyle(
                                  color: Colors.grey,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                              Text("20",//"$numberComments",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18.0
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
                thickness: 2,
                indent: 10, endIndent: 10,
                color: Colors.blue[900],
              ),
              Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.grey[200],
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("<<Station name>>",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                          // Divider(
                          //   height: 2,
                          //   thickness: 2,
                          //   color: Colors.blue[900],
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              meanValues('Cleaniness', '50'),
                              meanValues('Services', '50'),
                              meanValues('Safety', '50'),
                              meanValues('Area', '50')
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(" Comments:",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                              Text("20",//"$numberComments",
                                style: TextStyle(
                                    fontSize: 20.0
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(" Interactions:",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                              Text("20",//"$numberComments",
                                style: TextStyle(
                                    fontSize: 20.0
                                ),
                              )
                            ],
                          ),
                        ],
                      )

                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );




      Scaffold(
            resizeToAvoidBottomPadding: false,
            resizeToAvoidBottomInset: true,
            //backgroundColor: Colors.green,
            body: Column(
              children: [
                Text("Cleaning"),
                (voting[0]==true) ? Slider(
                  value: cleaning,
                  min: 0,
                  max: 100,
                  divisions: 100,
                  label: cleaning.round().toString(),
                  activeColor: Colors.green,
                ) : Text('No vote for cleaning'),
                Text("Voce 2"),
                (voting[1]==true) ? Slider(
                  value: dis,
                  min: 0,
                  max: 100,
                  divisions: 100,
                  label: cleaning.round().toString(),
                  activeColor: Colors.green,
                ) : Text('No vote for voce 2'),
                Text("Voce 3"),
                (voting[2]==true) ? Slider(
                  value: safety,
                  min: 0,
                  max: 100,
                  divisions: 100,
                  label: cleaning.round().toString(),
                  activeColor: Colors.green,
                ) : Text('No vote for voce 3'),
                Text("Voce 4"),
                (voting[3]==true) ? Slider(
                  value: area,
                  min: 0,
                  max: 100,
                  divisions: 100,
                  label: cleaning.round().toString(),
                  activeColor: Colors.green,
                ) : Text('No vote for voce 4')
              ],
            ),
        );

  }
}

