import 'package:flutter/material.dart';
import 'userService.dart';
import 'displayMenuStation.dart';

class MyStations extends StatefulWidget {
  var email;
  MyStationsState createState() => MyStationsState();
  MyStations({Key key, this.email}) : super(key: key);

}


class MyStationsState extends State<MyStations> {
  List myStations = [];



  void takeMyStations (){
    retrieveMyStations(widget.email).then((stations)=> setState((){
      myStations = stations;
    }));
  }

  @override
  void initState() {
    super.initState();

    takeMyStations();
  }




  Widget build(BuildContext context) {
    return MaterialApp(

        home: Scaffold(
            appBar: AppBar(
              title: Text("My Stations"),
            ),
            body: ListView.builder(
              //shrinkWrap: true,
              itemCount: myStations.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  contentPadding: EdgeInsets.all(10.0),
                  title: Text(myStations[index],
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)),

                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder:(context)=>MenuStation(name:myStations[index])));
                  },
                );
              },
            )



        ));
  }



}