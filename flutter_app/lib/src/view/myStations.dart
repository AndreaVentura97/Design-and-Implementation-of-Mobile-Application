import 'package:flutter/material.dart';
import 'package:flutter_app/src/view/userAccountWidget.dart';
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

            drawer: UserAccount(),


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
                        //color: Colors.blue,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                              title: Row(
                                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: Image(
                                            image: AssetImage("assets/M1.png"),
                                            height: 40.0,
                                            width: 60.0,
                                          ),
                                        ),
                                        SizedBox(width: 10.0,),
                                        Flexible(
                                          child: Container(
                                              //color: Colors.green,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(myStations[index],
                                                      style: TextStyle(
                                                          fontSize: 25.0,
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
                                        ),
                                      ],
                                    ),
                              trailing: IconButton(
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
                            ),
                          ],
                        )
                      ),
                    ),
                  );

              },
            )



        );
  }



}