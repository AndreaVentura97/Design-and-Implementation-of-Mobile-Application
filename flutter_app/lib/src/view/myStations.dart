import 'package:flutter/material.dart';
import 'package:flutter_app/src/view/userAccountWidget.dart';
<<<<<<< HEAD
=======
import 'package:flutter_app/redux/model/AppState.dart';
import 'package:flutter_app/src/view/pointWidget.dart';
import 'package:flutter_app/src/view/viewModel.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../services/stationServices.dart';
>>>>>>> 7544a1657651c3210c12bc374f5048aca8be625a
import '../services/userService.dart';
import 'displayMenuStation.dart';
import 'notificationWidget.dart';

class MyStations extends StatefulWidget {
  var email;
  MyStationsState createState() => MyStationsState();
  MyStations({Key key, this.email}) : super(key: key);

}


class MyStationsState extends State<MyStations> {
  List myStations = [];
  bool _favStation = false;
  String line;
  String address;



  void takeMyStations (){
    retrieveMyStations(widget.email).then((stations)=> setState((){
      myStations = stations;
    }));
  }

  updateFav(email,station){
    isMyStation(email,station).then((result) => setState(() {
      _favStation = result;
    }));
  }

  @override
  void initState() {
    super.initState();

    takeMyStations();
  }




  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  Text("My Stations"),
                  NotificationWidget(),
                ],
              ),
            ),
<<<<<<< HEAD
            drawer: UserAccount(),
=======

>>>>>>> 7544a1657651c3210c12bc374f5048aca8be625a
            body: ListView.builder(
              //shrinkWrap: true,
              itemCount: myStations.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder:(context)=>MenuStation(name:myStations[index])));
                    },
                    child: Card(
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Image(
                                      image: AssetImage("assets/M1.png"),
                                      height: 50.0,
                                      width: 75.0,
                                    ),
                                  ),
                                  SizedBox(width: 10.0,),
                                  Container(
                                      //color: Colors.green,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(myStations[index],
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black
                                              )
                                          ),
                                          // Text("${widget.station}",
                                          //   style: TextStyle(
                                          //     fontSize: 25.0,
                                          //     color: Colors.black,
                                          //   ),
                                          // ),
                                          // Text("$line",
                                          //   style: TextStyle(
                                          //     fontSize: 16.0,
                                          //     color: Colors.grey,
                                          //   ),
                                          // ),
                                          // Text("$address",
                                          //   style: TextStyle(
                                          //     fontSize: 16.0,
                                          //     color: Colors.grey,
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  Spacer(),
                                  IconButton(
                                    icon: Icon(!_favStation ? Icons.favorite_outline : Icons.favorite,
                                      size: 20.0,
                                    ),
                                    // onPressed: (!_favStation) ?  () {
                                    //   addMyStations(_viewModel.c.email, widget.station);
                                    //   setState(() {
                                    //     _favStation = true;
                                    //   });
                                    // } : () {
                                    //   deleteMyStations(_viewModel.c.email, widget.station);
                                    //   setState(() {
                                    //     _favStation = false;
                                    //   });
                                    // },
                                  ),
                                ],
                              )
                            ]
                        ),
                      ),
                    ),
                  );

              },
            )



        );
  }



}