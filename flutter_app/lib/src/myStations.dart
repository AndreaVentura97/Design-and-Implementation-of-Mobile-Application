import 'package:flutter/material.dart';


class MyStations extends StatelessWidget {
  List myStations = [];

  MyStations({Key key, this.myStations}) : super(key: key);

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

                );
              },
            )



        ));
  }



}