import 'package:flutter/material.dart';
import 'package:flutter_app/redux/model/AppState.dart';
import 'package:flutter_app/src/view/viewModel.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../services/stationServices.dart';

class Voting extends StatefulWidget {
  String station;
  Voting({Key key, this.station}) : super(key: key);
  VotingState createState() => VotingState();
}


class VotingState extends State<Voting> {
  var color = Colors.black;
  double valueClean;
  double valueMeanClean;
  bool voting = false;

  void takeStationInformation (){
    informationStation(widget.station).then((information) => setState(() {
      //line = information['line'];
      if (information['avgClean']!=null){
        valueMeanClean = information['avgClean'];
      }
      else {
        valueMeanClean = 50.0;
      }
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
      onInit: (store) => retrieveMyVoteCleaning(store.state.customer.email, widget.station).then((vote) => setState ((){
        valueClean = vote;
      })),
      builder: (context,_viewModel){
        return Center(
            child: Column (
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
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
                          sendCleaning(value, _viewModel.c.email, widget.station).then((result) => setState((){
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
        );
      },

    );


  }
}

