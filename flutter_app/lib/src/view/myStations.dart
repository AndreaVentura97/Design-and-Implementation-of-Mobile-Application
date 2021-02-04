import 'package:delayed_display/delayed_display.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/services/stationServices.dart';
import 'package:flutter_app/src/view/userAccountWidget.dart';
import '../services/userService.dart';
import 'displayMenuStation.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
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
  bool show = false;





  void takeMyStations () {
    retrieveMyStations(widget.email).then((stations) =>
        setState(() {
          myStations = stations;
          for (int i = 0; i < myStations.length; i++) {
            informationStationByName(myStations[i]).then((result) =>
                setState(() {
                  myFullStations.add(result);
                }));
        }
        }));

    }

  getColor2(stat){
    if (stat == true){
      return true;
    }
    else {
      return false;
    }
  }


  String getAsset(name){
    if (name == "Metro M1-M2"){
      return "assets/M1-M2.jpeg";
    }
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
    if (name == "Metro M1-M3"){
      return "assets/M1-M3.jpeg";
    }
    if (name == "Metro M1-M2"){
      return "assets/M1-M2.jpeg";
    }
    if (name == "Metro M2-M3"){
      return "assets/M2-M3.jpeg";
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
              backgroundColor: Colors.blue[900],
              title: Text("My Stations"),
            ),


            drawer: UserAccount(),
        body: DelayedDisplay(
              delay: Duration(seconds: 1),
              child: Stack(
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
                              'assets/Logo_MeMiQ_2.png',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: Color.fromRGBO(255, 255, 255, 0.3),
                    )
                  ]),
                  ListView.builder(
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
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        Text(myFullStations[index]['name'],
                                                            style: TextStyle(
                                                                fontSize: 22.0,
                                                                fontWeight: FontWeight.w500,
                                                                color: Colors.black
                                                            )
                                                        ),
                                                        SizedBox(width: 5,),
                                                        Icon(
                                                          Icons.circle,
                                                          color: (getColor2(myFullStations[index]['status'])) ? Colors.green : Colors.red,
                                                          size: 15,
                                                        ),
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
                                          show = true;
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
                  showAlert(),
                ],
              ),
            )
    );
  }

  Widget showAlert() {
    if (show){
      return Container(
        padding: EdgeInsets.all(8.0),
        child: Container(
          color: Colors.amber,
          width: double.infinity,
          height: 50.0,
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(Icons.error_outline),
              ),
              Expanded(
                child: AutoSizeText(
                  "Removed from your stations",
                  maxLines: 3,
                ),
              ),
              IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      show = false;
                    });
                  })
            ],
          ),
        ),
      );
    }
    else {
      return SizedBox(
        height: 0.0,
      );
}}

}