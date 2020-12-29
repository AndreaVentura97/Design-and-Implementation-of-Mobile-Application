import 'package:flutter/material.dart';
import 'package:flutter_app/redux/model/AppState.dart';
import 'package:flutter_app/src/view/viewModel.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../services/stationServices.dart';
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
  List<bool> voting = [false, false];

  //bool voting = false;
  final myController = TextEditingController();

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
        }));
  }

  retrieveMyVotes(email) {
    retrieveMyVoteCleaning(email, widget.station).then((vote) => setState(() {
          valueClean = vote;
        }));
    retrieveMyVoteDis(email, widget.station).then((vote2) => setState(() {
          valueDis = vote2;
        }));
  }

  @override
  void initState() {
    super.initState();
    takeStationInformation();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, ViewModel>(
      converter: (store) => createViewModel(store),
      onInit: (store) => retrieveMyVotes(store.state.customer.email),
      builder: (context, _viewModel) {
        return Scaffold(
            resizeToAvoidBottomPadding: false,
            resizeToAvoidBottomInset: true,
            //backgroundColor: Colors.green,
            body: SingleChildScrollView(
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
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Voting',
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 15.0,),

                            Container(
                              //color: Colors.purple,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Cleaniness:",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  (valueClean != null)
                                      ? Slider(
                                          value: valueClean,
                                          min: 0,
                                          max: 100,
                                          divisions: 100,
                                          label: valueClean.round().toString(),
                                          activeColor:
                                              (valueClean == 50.0 || voting[0])
                                                  ? Colors.black
                                                  : Colors.black.withOpacity(0.2),
                                          onChangeEnd: (double value) {
                                            setState(() {
                                              color =
                                                  Colors.black.withOpacity(0.2);
                                              sendCleaning(
                                                      value,
                                                      _viewModel.c.email,
                                                      widget.station)
                                                  .then((result) => setState(() {
                                                        valueMeanClean = result;
                                                      }));
                                              voting[0] = false;
                                            });
                                          },
                                          onChangeStart: (double value) {
                                            setState(() {
                                              color = Colors.black;
                                              voting[0] = true;
                                            });
                                          },
                                          onChanged: (double value) {
                                            setState(() {
                                              valueClean = value;
                                            });
                                          })
                                      : Text("Loading"),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.0,),
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
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Services inside:",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  (valueDis != null)
                                      ? Slider(
                                          value: valueDis,
                                          min: 0,
                                          max: 100,
                                          divisions: 100,
                                          label: valueDis.round().toString(),
                                          activeColor:
                                              (valueDis == 50.0 || voting[1])
                                                  ? Colors.black
                                                  : Colors.black.withOpacity(0.2),
                                          onChangeEnd: (double value) {
                                            setState(() {
                                              color =
                                                  Colors.black.withOpacity(0.2);
                                              sendDis(value, _viewModel.c.email,
                                                      widget.station)
                                                  .then((result) => setState(() {
                                                        valueMeanDis = result;
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
                              child: Text('Safety:'),
                            ),
                            SizedBox(height: 10.0,),
                            Container(
                              child: Text('Surrounding area:'),
                            )

                          ],
                        ),
                      ),
                    ),
                    Card(
                      //color: Colors.blue,
                      margin: EdgeInsets.all(10.0),
                      elevation: 3.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
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
                          SizedBox(height: 15.0,),
                          TextFormField(
                              decoration: InputDecoration(
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
                          SizedBox(height: 10.0),
                          FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: Colors.blue[900],
                            child: Text("Send comment",
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
                                  widget.station);
                              myController.clear();
                            },
                          ),
                        ]),
                      ),
                    ),
                  ]),
            ));
      },
    );
  }
}
