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
  String line;

  void takeStationInformation (){
    informationStation(widget.station).then((information) => setState(() {
      line = information['line'];
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
        return Center(
            child: Column (
                children:[Text("${widget.station}"),
                  Text("$line"),
                  OutlineButton(
                    child: Text("Add to my stations"),
                    onPressed: () {
                      addMyStations(_viewModel.c.email, widget.station);
                    },
                  )]
            )
        );
      },
    );
  }
}