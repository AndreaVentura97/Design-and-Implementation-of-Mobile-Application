import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/services/stationServices.dart';
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
  String image;




  void takeMyStations (){
    retrieveMyStations(widget.email).then((stations)=> setState((){
      myStations = stations;
    }));
  }

  String checkLine(station){
    informationStation(station).then((result)=> setState((){
      if (result['line']=="Metro M1"){
        image =  "assets/M1.jpeg";
      }
      if (result['line']=="Metro M2"){
        image=  "assets/M2.jpeg";
      }
      if (result['line']=="Metro M3"){
        image =  "assets/M3.jpeg";
      }
      if (result['line']=="Metro M5"){
        image = "assets/M5.jpeg";
      }
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
                                            image: (image!=null) ? AssetImage(checkLine(myStations[index])) : AssetImage("assets/loading.jpg"),
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
                                icon: Icon(Icons.favorite,
                                  size: 20.0,
                                ),
                                onPressed: () {
                                  deleteMyStations(widget.email, myStations[index]);
                                  setState(() {
                                    myStations.remove(myStations[index]);
                                  });
                                   },
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