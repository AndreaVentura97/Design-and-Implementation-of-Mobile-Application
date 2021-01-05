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
    return Scaffold(
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

