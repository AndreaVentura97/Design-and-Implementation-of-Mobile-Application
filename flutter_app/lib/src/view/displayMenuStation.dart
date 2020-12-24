import 'package:flutter/material.dart';
import 'package:flutter_app/redux/model/AppState.dart';
import 'package:flutter_app/src/view/commentTabScreen.dart';
import 'package:flutter_app/src/view/infoTabScreen.dart';
import 'package:flutter_app/src/view/viewModel.dart';
import 'package:flutter_app/src/view/votingTabScreen.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../services/service.dart';
import '../checkLogin.dart';
import 'messages.dart';
import '../services/userService.dart';
import 'messagesByDate.dart';
import '../services/stationServices.dart';


class MenuStation extends StatefulWidget {
  final String name;
  MenuStation({Key key, this.name}) : super(key: key);
  _MenuStationState createState() => _MenuStationState();
}

class _MenuStationState extends State<MenuStation> {
  int _currentIndex = 0;
  //Color StationColor;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    // switch(widget.line){
    //   case
    // }

    return new StoreConnector<AppState, ViewModel>(
      converter: (store) => createViewModel(store),
      builder: (context,_viewModel){
        final tabs =[
          InfoStation(station: widget.name),
          Messages(station: widget.name),
          Comment(station: widget.name),
          Voting(station:widget.name),
        ];
        return Scaffold(
          appBar: AppBar(
              title: Center(
                  child: Text("${widget.name}")
              ),
            backgroundColor: Colors.red,
          ),
          body: tabs[_currentIndex],


          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            //type: BottomNavigationBarType.fixed,
            selectedFontSize: 15,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title: Text("Info Station"),
                  backgroundColor: Colors.blue
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  title: Text("Comments"),
                  backgroundColor: Colors.blue
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.how_to_vote_outlined),
                  title: Text("Voting"),
                  backgroundColor: Colors.blue
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  title: Text("Something else"),
                  backgroundColor: Colors.blue,
              )
            ],
            onTap: (index){
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        );
      }

    );

  }
}


