import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/redux/model/AppState.dart';
import 'package:flutter_app/src/view/viewModel.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../services/stationServices.dart';
import '../services/userService.dart';
import 'package:flutter_app/src/services/service.dart';

class Voting extends StatefulWidget {
  String station;

  Voting({Key key, this.station}) : super(key: key);

  VotingState createState() => VotingState();
}

class VotingState extends State<Voting> {
  var color = Colors.black;
  double valueClean;
  double valueMeanClean;
  double valueDis;
  double valueMeanDis;
  double valueSafety;
  double valueMeanSafety;
  double valueArea;
  double valueMeanArea;
  bool citizen = true;
  List<bool> voting = [false, false, false, false];

  //bool voting = false;
  final myController = TextEditingController();
  final myController2 = TextEditingController();

  void takeStationInformation() {
    informationStation(widget.station).then((information) => setState(() {
      //line = information['line'];
      if (information['avgClean'] != null) {
        valueMeanClean = information['avgClean'];
      } else {
        valueMeanClean = 50.0;
      }
      if (information['avgDis'] != null) {
        valueMeanDis = information['avgDis'];
      } else {
        valueMeanDis = 50.0;
      }
      if (information['avgSafety'] != null) {
        valueMeanSafety = information['avgSafety'];
      } else {
        valueMeanSafety = 50.0;
      }
      if (information['avgArea'] != null) {
        valueMeanArea = information['avgArea'];
      } else {
        valueMeanArea = 50.0;
      }
    }));
  }

  retrieveMyVotes(email) {
    retrieveMyVoteCleaning(email, widget.station).then((vote) => setState(() {
      valueClean = vote;
    }));
    retrieveMyVoteDis(email, widget.station).then((vote2) => setState(() {
      valueDis = vote2;
    }));
    retrieveMyVoteSafety(email, widget.station).then((vote3) => setState(() {
      valueSafety = vote3;
    }));
    retrieveMyVoteArea(email, widget.station).then((vote4) => setState(() {
      valueArea = vote4;
    }));
    retrieveMyState(email).then((result) => setState(() {
      citizen = result;
    }));
  }

  @override
  void initState() {
    super.initState();
    takeStationInformation();
  }

  @override
  Widget build(BuildContext context) {
      return new StoreConnector<AppState, ViewModel>(
      converter: (store) => createViewModel(store),
      onInit: (store) => retrieveMyVotes(store.state.customer.email),
      builder: (context, _viewModel) {
        return SingleChildScrollView(
              child: Column(
                //mainAxisSize: MainAxisSize.min,
                  children: [
                    Card(
                      //color: Colors.blue,
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
                        margin: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'My votes',
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),

                            Container(
                              //color: Colors.blue,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Kind of user:',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    //color: Colors.purple,
                                    child: Row(
                                      children: [
                                        Container(
                                          //color: Colors.orange,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          child: Column(
                                            children: [
                                              Text('Citizen',
                                                style: TextStyle(fontWeight: FontWeight.bold),
                                              ),
                                              IconButton(
                                                icon: (!citizen)
                                                    ? Icon(
                                                  Icons
                                                      .brightness_1_outlined, //:Icons.brightness_1,
                                                )
                                                    : Icon(
                                                  Icons.brightness_1,
                                                ),
                                                onPressed: () => {
                                                  updateState(
                                                      _viewModel.c.email,
                                                      true)
                                                      .then((value) =>
                                                      setState(() {
                                                        citizen = value;
                                                      }))
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          //color: Colors.orange,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          child: Column(
                                            children: [
                                              Text('Visitor',
                                                style: TextStyle(fontWeight: FontWeight.bold
                                                ),
                                              ),
                                              IconButton(
                                                icon: (!citizen)
                                                    ? Icon(
                                                  Icons.brightness_1,
                                                )
                                                    : Icon(Icons
                                                    .brightness_1_outlined),
                                                onPressed: () => {
                                                  updateState(
                                                      _viewModel.c.email,
                                                      false)
                                                      .then((value) =>
                                                      setState(() {
                                                        citizen = value;
                                                      }))
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),

                            Container(
                              //color: Colors.purple,
                              margin: EdgeInsets.fromLTRB(5, 0, 5, 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Cleaniness:",
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        (valueClean != null)
                                            ? Slider(
                                          value: valueClean,
                                          min: 0,
                                          max: 100,
                                          divisions: 100,
                                          //label: valueClean.round().toString(),
                                          activeColor:
                                          (valueClean == 50.0 ||
                                              voting[0])
                                              ? Colors.blue[900]
                                              : Colors.blue[900].withOpacity(0.4),
                                          onChangeEnd: (double value) {
                                            setState(() {
                                              color = Colors.blue[900].withOpacity(0.4);
                                              sendCleaning(
                                                  value,
                                                  _viewModel.c.email,
                                                  widget.station,
                                                  citizen)
                                                  .then((result) =>
                                                  setState(() {
                                                    valueMeanClean =
                                                        result;
                                                  }));
                                              voting[0] = false;
                                            });
                                          },
                                          onChangeStart: (double value) {
                                            setState(() {
                                              color = Colors.blue[900];
                                              voting[0] = true;
                                            });
                                          },
                                          onChanged: (double value) {
                                            setState(() {
                                              valueClean = value;
                                            });
                                          },
                                        )
                                            : Text("Loading"),
                                      ],
                                    ),
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
                                      child: Text((valueClean != null)? '${valueClean.round()}': '- -',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),

                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Text("Average cleaning voted by people"),
                            // (valueMeanClean != null)
                            //     ? Slider(
                            //         value: valueMeanClean,
                            //         min: 0,
                            //         max: 100,
                            //         divisions: 100,
                            //         label: valueMeanClean.round().toString(),
                            //         activeColor: Colors.green,
                            //       )
                            //     : Text("Loading"),
                            Container(
                              //color: Colors.purple,
                              margin: EdgeInsets.fromLTRB(5, 0, 5, 15),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Services inside:",
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        (valueDis != null)
                                            ? Slider(
                                            value: valueDis,
                                            min: 0,
                                            max: 100,
                                            divisions: 100,
                                            //label: valueDis.round().toString(),
                                            activeColor: (valueDis == 50.0 ||
                                                voting[1])
                                                ? Colors.blue[900]
                                                : Colors.blue[900].withOpacity(0.4),
                                            onChangeEnd: (double value) {
                                              setState(() {
                                                color =
                                                    Colors.blue[900].withOpacity(0.4);
                                                sendDis(value, _viewModel.c.email,
                                                    widget.station, citizen)
                                                    .then(
                                                        (result) => setState(() {
                                                      valueMeanDis =
                                                          result;
                                                    }));
                                                voting[1] = false;
                                              });
                                            },
                                            onChangeStart: (double value) {
                                              setState(() {
                                                color = Colors.black;
                                                voting[1] = true;
                                              });
                                            },
                                            onChanged: (double value) {
                                              setState(() {
                                                valueDis = value;
                                              });
                                            })
                                            : Text("Loading"),
                                      ],
                                    ),
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
                                      child: Text((valueDis != null)? '${valueDis.round()}': '- -',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),

                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Text("Average opinion about service for disabled"),
                            // (valueMeanDis != null)
                            //     ? Slider(
                            //         value: valueMeanDis,
                            //         min: 0,
                            //         max: 100,
                            //         divisions: 100,
                            //         label: valueMeanDis.round().toString(),
                            //         activeColor: Colors.green,
                            //       )
                            //     : Text("Loading"),
                            Container(
                              //color: Colors.purple,
                              margin: EdgeInsets.fromLTRB(5, 0, 5, 15),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Safety:",
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        (valueSafety != null)
                                            ? Slider(
                                            value: valueSafety,
                                            min: 0,
                                            max: 100,
                                            divisions: 100,
                                            //label: valueSafety.round().toString(),
                                            activeColor: (valueSafety == 50.0 ||
                                                voting[2])
                                                ? Colors.blue[900]
                                                : Colors.blue[900].withOpacity(0.4),
                                            onChangeEnd: (double value) {
                                              setState(() {
                                                color =
                                                    Colors.blue[900].withOpacity(0.4);
                                                sendSafety(
                                                    value,
                                                    _viewModel.c.email,
                                                    widget.station,
                                                    citizen)
                                                    .then(
                                                        (result) => setState(() {
                                                      valueMeanSafety =
                                                          result;
                                                    }));
                                                voting[2] = false;
                                              });
                                            },
                                            onChangeStart: (double value) {
                                              setState(() {
                                                color = Colors.black;
                                                voting[2] = true;
                                              });
                                            },
                                            onChanged: (double value) {
                                              setState(() {
                                                valueSafety = value;
                                              });
                                            })
                                            : Text("Loading"),
                                      ],
                                    ),
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
                                      child: Text((valueSafety != null)? '${valueSafety.round()}': '- -',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),

                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              //color: Colors.purple,
                              margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Overall:",
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        (valueArea != null)
                                            ? Slider(
                                            value: valueArea,
                                            min: 0,
                                            max: 100,
                                            divisions: 100,
                                            //label: valueArea.round().toString(),
                                            activeColor: (valueArea == 50.0 ||
                                                voting[3])
                                                ? Colors.blue[900]
                                                : Colors.blue[900].withOpacity(0.4),
                                            onChangeEnd: (double value) {
                                              setState(() {
                                                color =
                                                    Colors.blue[900].withOpacity(0.4);
                                                sendArea(
                                                    value,
                                                    _viewModel.c.email,
                                                    widget.station,
                                                    citizen)
                                                    .then(
                                                        (result) => setState(() {
                                                      valueMeanArea =
                                                          result;
                                                    }));
                                                voting[3] = false;
                                              });
                                            },
                                            onChangeStart: (double value) {
                                              setState(() {
                                                color = Colors.black;
                                                voting[3] = true;
                                              });
                                            },
                                            onChanged: (double value) {
                                              setState(() {
                                                valueArea = value;
                                              });
                                            })
                                            : Text("Loading"),
                                      ],
                                    ),
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
                                      child: Text((valueArea != null)? '${valueArea.round()}': '- -',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),

                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // FlatButton(
                            //   shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(15.0),
                            //   ),
                            //   color: Colors.blue[900],
                            //   child: Text(
                            //     "Submit",
                            //     style: TextStyle(
                            //       color: Colors.white,
                            //       fontSize: 15.0,
                            //     ),
                            //   ),
                            //   onPressed: () {
                            //     // var name = _viewModel.c.name;
                            //     // var email = _viewModel.c.email;
                            //     // var photo = _viewModel.c.photo;
                            //     // saveMessage(email, name, myController.text, photo,
                            //     //     widget.station);
                            //     // myController.clear();
                            //   },
                            // ),

                          ],
                        ),
                      ),
                    ),
                    Card(
                      //color: Colors.blue,
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      elevation: 3.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(
                          color: Colors.blue[900],
                          width: 2.0,
                        ),
                      ),
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        child: Column(children: [
                          Text(
                            'Comment',
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                                decoration: InputDecoration(
                                  isDense: true,
                                  hintText: 'Enter a comment',
                                  hintStyle: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey,
                                  ),
                                  // labelText: 'Enter a comment',
                                  // labelStyle: TextStyle(
                                  //   fontSize: 10.0,
                                  //   color: Colors.grey[700]
                                  // ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blue[900],
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blue[900],
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                controller: myController),
                          ),
                          SizedBox(height: 10.0),
                          FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: Colors.blue[900],
                            child: Text(
                              "Send comment",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                            onPressed: () {
                              var name = _viewModel.c.name;
                              var email = _viewModel.c.email;
                              var photo = _viewModel.c.photo;

                              saveMessage(email, name, myController.text, photo,
                                  widget.station, citizen);
                              myController.clear();
                            },
                          ),
                        ]),
                      ),
                    ),
                    Card(
                      //color: Colors.blue,
                      margin: EdgeInsets.all(10.0),
                      elevation: 3.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(
                          color: Colors.blue[900],
                          width: 2.0,
                        ),
                      ),
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        child: Column(children: [
                          Text(
                            'Report',
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                                decoration: InputDecoration(
                                  isDense: true,
                                  hintText: 'Enter a report',
                                  hintStyle: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey,
                                  ),
                                  // labelText: 'Enter a comment',
                                  // labelStyle: TextStyle(
                                  //   fontSize: 10.0,
                                  //   color: Colors.grey[700]
                                  // ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blue[900],
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blue[900],
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                controller: myController2),
                          ),
                          SizedBox(height: 10.0),
                          FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: Colors.blue[900],
                            child: Text(
                              "Send report",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                            onPressed: () {
                              var name = _viewModel.c.name;
                              var email = _viewModel.c.email;
                              var photo = _viewModel.c.photo;
                              saveSuggestion(email, name, myController2.text, photo, widget.station);
                              myController2.clear();

                            },
                          ),
                        ]),
                      ),
                    )
                  ]),
            );
      },
    );

  }
}
