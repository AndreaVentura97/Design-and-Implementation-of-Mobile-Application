import 'package:flutter/material.dart';
import 'package:flutter_app/src/services/stationServices.dart';


class DropDownWidget extends StatefulWidget {
  final String station;

  DropDownWidget({Key key, this.station}) : super(key: key);
  DropDownState createState() => DropDownState();

}

class DropDownState extends State<DropDownWidget> {
  var avgClean;
  var avgDis;
  var avgSafety;
  var avgArea;
  var valueDrop = "All";

  void takeStationInformation (){
    informationStation(widget.station).then((information) => setState(() {
      if(information['avgClean']==50.0){
        avgClean = double.tryParse("--");
      }
      else {
        avgClean = information['avgClean'].toStringAsFixed(1);
      }
      if(information['avgSafety']==50.0){
        print(information['avgSafety']);
        avgSafety = double.tryParse("--");
      }
      else {
        avgSafety = information['avgSafety'].toStringAsFixed(1);
      }
      if(information['avgDis']==50){
        avgDis = double.tryParse("--");
      }
      else {
        avgDis = information['avgDis'].toStringAsFixed(1);
      }
      if(information['avgArea']==50){
        avgClean = double.tryParse("--");
      }
      else {
        avgArea = information['avgArea'].toStringAsFixed(1);
      }

    }));
  }

  @override
  void initState() {
    takeStationInformation();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    Widget meanValues(String Title, MeanValue) {
      return Expanded(
        child: Container(
          //color: Colors.grey,
          child: Column(
            children: [
              Text(Title,
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 50,
                width: 50,
                decoration:
                BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.blue[900],
                    width: 2,
                  ),
                  //boxShadow: [BoxShadow( blurRadius: 10, spreadRadius: 10)],
                ),
                child: Center(
                  //child: Text( '${MeanValue.round()}', //(valueClean != null)? '${valueClean.round()}': '- -',
                  child: (MeanValue!=null) ? Text(MeanValue,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ) : Text("--",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              )
            ],
          ),
        ),
      );
    }
    Widget drop = DropdownButton(
        value: valueDrop,
        items: [
          DropdownMenuItem(
            child: Text("All users"),
            value: "All",
          ),
          DropdownMenuItem(
            child: Text("Citizens"),
            value: "Citizens",
          ),
          DropdownMenuItem(
            child: Text("Visitors"),
            value: "Visitors",
          ),
        ],
        onChanged: (value) {
          setState(() {
            valueDrop = value;
            if(value=="Visitors"){
              buildMeanVisitor(widget.station, "cleaning").then((result)=>setState((){
                if (result!=50){
                  avgClean = result.toStringAsFixed(1);
                }
                else {
                  avgClean = "--";
                }
              }));
              buildMeanVisitor(widget.station, "dis").then((result)=>setState((){
                if (result!=50){
                  avgDis = result.toStringAsFixed(1);
                }
                else {
                  avgDis = "--";
                }
              }));
              buildMeanVisitor(widget.station, "safety").then((result)=>setState((){
                if (result!=50){
                  avgSafety = result.toStringAsFixed(1);
                }
                else {
                  avgSafety = "--";
                }
              }));
              buildMeanVisitor(widget.station, "area").then((result)=>setState((){
                if (result!=50){
                  avgArea = result.toStringAsFixed(1);
                }
                else {
                  avgArea = "--";
                }
              }));
            }
            if (value=="Citizens"){
              buildMeanCitizen(widget.station, "cleaning").then((result)=>setState((){
                if (result!=50){
                  avgClean = result.toStringAsFixed(1);
                }
                else {
                  avgClean = "--";
                }
              }));
              buildMeanCitizen(widget.station, "dis").then((result)=>setState((){
                if (result!=50){
                  avgDis = result.toStringAsFixed(1);
                }
                else {
                  avgDis = "--";
                }
              }));
              buildMeanCitizen(widget.station, "safety").then((result)=>setState((){
                if (result!=50){
                  avgSafety = result.toStringAsFixed(1);
                }
                else {
                  avgSafety = "--";
                }
              }));
              buildMeanCitizen(widget.station, "area").then((result)=>setState((){
                if (result!=50){
                  avgArea = result.toStringAsFixed(1);
                }
                else {
                  avgArea = "--";
                }
              }));
            }
            if(value=="All") {
              updateMeanClean(widget.station).then((result)=>setState((){
                if (result!=50){
                  avgClean = result.toStringAsFixed(1);
                }
                else {
                  avgClean = "--";
                }
              }));
              updateMeanDis(widget.station).then((result)=>setState((){
                if (result!=50){
                  avgDis = result.toStringAsFixed(1);
                }
                else {
                  avgDis = "--";
                }
              }));
              updateMeanSafety(widget.station).then((result)=>setState((){
                if (result!=50){
                  avgSafety = result.toStringAsFixed(1);
                }
                else {
                  avgSafety = "--";
                }
              }));
              updateMeanArea(widget.station).then((result)=>setState((){
                if (result!=50){
                  avgArea = result.toStringAsFixed(1);
                }
                else {
                  avgArea = "--";
                }
              }));
            }
          });
        });
    return Card(
      elevation: 3,
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Colors.blue[900],
            width: 2,
          )
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Ratings:',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                ),
                Spacer(),
                Container(
                    child: drop
                )
              ],
            ),
            Divider(
              color: Colors.black,
              thickness: 2,
            ),
            Container(
              //color: Colors.orange,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  meanValues('Cleaniness', avgClean),
                  meanValues('Services', avgDis),
                  meanValues('Safety', avgSafety),
                  meanValues('Area', avgArea)
                ],
              ),
            )
          ],
        ),
      ),
    );


    }
  }


