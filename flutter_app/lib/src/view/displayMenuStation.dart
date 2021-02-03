import 'package:flutter/material.dart';
import 'package:flutter_app/redux/model/AppState.dart';
import 'package:flutter_app/src/view/commentTabScreen.dart';
import 'package:flutter_app/src/services/userService.dart';
import 'package:flutter_app/src/view/pointWidget.dart';
import 'package:flutter_app/src/view/infoTabScreen.dart';
import 'package:flutter_app/src/view/userAccountWidget.dart';
import 'package:flutter_app/src/view/viewModel.dart';
import 'package:flutter_app/src/view/votingTabScreen.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'animatedAppBar.dart';
import 'commentsTabScreen.dart';
import '../services/stationServices.dart';


class MenuStation extends StatefulWidget {
  final String name;
 // String station;
  MenuStation({Key key, this.name}) : super(key: key);
  _MenuStationState createState() => _MenuStationState();
}

class _MenuStationState extends State<MenuStation> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  String line;
  String address;
  List points = [];
  //var RGBStation = new List(3);
  List RGBStation = [0, 0, 0];
  AnimationController _animationController;
  Animation _colorTween;

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }


  void takeStationInformation (){
    informationStation(widget.name).then((information) => setState(() {
      line = information['line'];
      address = information['address'];
      checkLine(line);
      print('${RGBStation[0]}');
    }));
    pointsStation(widget.name).then((result) => setState(() {
      points = result;
    }));
  }

  void checkLine(line){
    if (line=="Metro M1"){
      setState(() {
        RGBStation = [236, 44, 32] ;
      });
    }
    if (line=="Metro M2"){
      setState(() {
        RGBStation = [92, 148, 51];
      });
    }
    if (line=="Metro M3"){
      setState(() {
        RGBStation = [251, 186, 20];
      });
    }
    if (line=="Metro M5"){
      setState(() {
        RGBStation = [154, 140, 195];
      });
    }
    if (line=="Metro M1-M2"){
      //colore neutro TODO
      RGBStation = [0, 0, 0];
    }
  }

  Animatable<Color> background = TweenSequence<Color>([
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(
        begin: Colors.red,
        end: Colors.green,
      ),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(
        begin: Colors.green,
        end: Colors.blue,
      ),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(
        begin: Colors.blue,
        end: Colors.pink,
      ),
    ),
  ]);

  @override
  void initState() {
    takeStationInformation ();
    super.initState();
    _animationController =
        AnimationController(vsync:this, duration: Duration(seconds: 3))..repeat();
    _colorTween = ColorTween(begin: Colors.red, end: Colors.green)
        .animate(_animationController);
  }





  @override
  Widget build(BuildContext context) {

    return new StoreConnector<AppState, ViewModel>(
        converter: (store) => createViewModel(store),
        builder: (context,_viewModel){
          final tabs =[
            InfoStation(station: widget.name),
            Comments(station: widget.name),
            Voting(station:widget.name),
          ];
          return AnimatedBuilder(
            animation:_animationController,
              builder : (context,child){
                return Scaffold(
                  resizeToAvoidBottomPadding: false,
                  resizeToAvoidBottomInset: true,
                  appBar: AppBar(
                    title: Text("${widget.name}"),
                    centerTitle: true,
                    backgroundColor: Color.fromRGBO(RGBStation[0],RGBStation[1],RGBStation[2],  1.0),
                    //backgroundColor: _colorTween.value
                  ),
                  drawer: UserAccount(),
                  body: Stack(
                    children: [
                      Stack(children: [
                        Container(
                          color: Colors.white,
                          child: Center(
                            child: Container(
                              height: 300,
                              width: 200,
                              child: FittedBox(
                                child: Image.asset(
                                  'assets/Logo_Name.jpeg',
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          color: Color.fromRGBO(255, 255, 255, 0.3),
                        )
                      ]),
                      tabs[_currentIndex],
                    ],
                  ),
                  bottomNavigationBar: BottomNavigationBar(
                    currentIndex: _currentIndex,
                    //type: BottomNavigationBarType.fixed,
                    selectedFontSize: 15,
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home,
                          color: Colors.blue[900],
                        ),
                        title: Text("Info Station",
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.3,
                              color: Colors.blue[900]
                          ),
                        ),
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.search,
                          color: Colors.blue[900],
                        ),
                        title: Text("Comments",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.3,
                            color: Colors.blue[900],
                          ),
                        ),
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.how_to_vote_outlined,
                          color: Colors.blue[900],
                        ),
                        title: Text("Voting",
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.3,
                              color: Colors.blue[900]
                          ),
                        ),
                      ),
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

    );

  }
}


