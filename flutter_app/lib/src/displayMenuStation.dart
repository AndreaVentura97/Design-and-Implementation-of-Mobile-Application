import 'package:flutter/material.dart';
import 'service.dart';
import 'checkLogin.dart';
import 'messages.dart';
import 'userService.dart';
import 'messagesByDate.dart';
import 'stationServices.dart';
import 'checkLogin.dart';

class MenuStation extends StatefulWidget {
  var profile;
  final String name;

  MenuStation({Key key, this.name}) : super(key: key);
  _MenuStationState createState() => _MenuStationState();

}

class _MenuStationState extends State<MenuStation> {
  final myController = TextEditingController();
  String line;
  var color = Colors.black;
  double valueClean;
  double valueMeanClean;
  bool voting = false;

  void check() {
    exportProfile().then((myProfile) => setState(() {
      widget.profile = myProfile;

    }));
  }
  void takeStationInformation (){
    informationStation(widget.name).then((information) => setState(() {
      line = information['line'];
      if (information['avgClean']!=null){
        valueMeanClean = information['avgClean'];
      }
      else {
        valueMeanClean = 50.0;
      }
    }));
  }

  void myVoteCleaning(){
    retrieveMyVoteCleaning(getEmail(), widget.name).then((vote) => setState ((){
      valueClean = vote;
    }));
  }




  @override
  void initState() {
    super.initState();
    myVoteCleaning();
    check();
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
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: Column (
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text ("${widget.name}"),
                  Text ("${line}"),
                  TextField(
                    decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter a comment', ),
                      controller: myController
            ),
                  OutlineButton(
                    child: Text("Send comment"),
                    onPressed: () {
                      var name = widget.profile[0];
                      var email = widget.profile[1];
                      saveMessage(name, email, myController.text, widget.name);
                    },
                  ),
                  OutlineButton(
                    child: Text("Retrieve all comments about this station "),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder:(context)=>
                          Messages(station: widget.name)),);
                    },
                  ),
                  OutlineButton(
                    child: Text("Retrieve the most recent comments about this station "),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder:(context)=>
                          MessagesByDate(station: widget.name)),);
                    },
                  ),
                  OutlineButton(
                    child: Text("Add to my stations"),
                    onPressed: () {
                      addMyStations(widget.profile[1], widget.name);
                    },
                  ),
                  Text("Vote cleaning"),
                  (valueClean!=null) ? Slider(
                    value: valueClean,
                    min:0,
                    max:100,
                    divisions: 100,
                    label: valueClean.round().toString(),
                    activeColor: (valueClean == 50.0 || voting) ? Colors.black: Colors.black.withOpacity(0.2),
                    onChangeEnd: (double value){
                      setState(() {
                        color = Colors.black.withOpacity(0.2);
                        sendCleaning(value, widget.profile[1], widget.name).then((result) => setState((){
                          valueMeanClean = result;
                        }));
                        voting = false;
                      });

                      },
                      onChangeStart: (double value){
                      setState(() {
                        color = Colors.black;
                        voting = true;
                      });
                    },
                    onChanged: (double value) {
                      setState(() {
                        valueClean = value;
                      });

                    })
                      : Text("Loading"),
                      Text("Average cleaning voted by people"),
                      (valueMeanClean!=null) ? Slider(
                      value: valueMeanClean,
                      min:0,
                      max:100,
                      divisions:100,
                      label: valueMeanClean.round().toString(),
                      activeColor: Colors.green,
                      ) : Text("Loading")
                ]
            )
        ),
      ),
    );
  }
}


