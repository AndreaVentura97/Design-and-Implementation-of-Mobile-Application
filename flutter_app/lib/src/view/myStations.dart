import 'package:delayed_display/delayed_display.dart';
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
  List myFullStations = [];
  //bool _favStation = false;
  String line;
  String address;





  void takeMyStations () {
    retrieveMyStations(widget.email).then((stations) =>
        setState(() {
          myStations = stations;
          for (int i = 0; i < myStations.length; i++) {
            informationStationByName(myStations[i]).then((result) =>
                setState(() {
                  myFullStations.add(result);
                }));
        }}));

    }


  String getAsset(name){
    if (name == "Metro M1"){
      return "assets/M1.jpeg";
    }
    if (name == "Metro M2"){
      return "assets/M2.jpeg";
    }
    if (name == "Metro M3"){
      return "assets/M3.jpeg";
    }
    if (name == "Metro M5"){
      return "assets/M5.jpeg";
    }
  }




  @override
  void initState() {
    super.initState();
    takeMyStations();
    print(myFullStations);
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


            body: DelayedDisplay(
              delay: Duration(seconds: 1),
              child: ListView.builder(
                //shrinkWrap: true,
                itemCount: myFullStations.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder:(context)=>MenuStation(name:myFullStations[index]['name'])));
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
                                            child: DelayedDisplay(
                                              delay: Duration(milliseconds: 500),
                                              child: Image(
                                                image: AssetImage(getAsset(myFullStations[index]['line'])),
                                                height: 40.0,
                                                width: 60.0,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10.0,),
                                          Flexible(
                                            child: Container(
                                                //color: Colors.green,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(myFullStations[index]['name'],
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
                                    deleteMyStations(widget.email, myFullStations[index]['name']);
                                    setState(() {
                                      myFullStations.remove(myFullStations[index]);
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
              ),
            )
    );
  }



}