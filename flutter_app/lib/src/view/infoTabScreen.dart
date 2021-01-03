import 'package:flutter/material.dart';
import 'package:flutter_app/redux/model/AppState.dart';
import 'package:flutter_app/src/services/userService.dart';
import 'package:flutter_app/src/view/pointWidget.dart';
import 'package:flutter_app/src/view/viewModel.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../services/stationServices.dart';

class InfoStation extends StatefulWidget {
  String station;
  InfoStation({Key key, this.station}) : super(key: key);
  InfoStationState createState() => InfoStationState();
}


class InfoStationState extends State<InfoStation> {
  bool _favStation = false;
  String line;
  String address;
  List points = [];

  void takeStationInformation (){
    informationStation(widget.station).then((information) => setState(() {
      line = information['line'];
      address = information['address'];
    }));
    pointsStation(widget.station).then((result) => setState(() {
      points = result;
    }));
  }

  updateFav(email,station){
    isMyStation(email,station).then((result) => setState(() {
      _favStation = result;
    }));
  }



  @override
  void initState() {
    takeStationInformation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector <AppState,ViewModel>(
      converter: (store) => createViewModel(store),
      onInit: (store) => updateFav(store.state.customer.email, widget.station),
      builder: (context,_viewModel){
        List<Widget> buildPoints (){
            List<Widget> list = new List();
            for (int i=0; i< points.length;i++){
              list.add(PointWidget(point:points[i]));
            }
            return list;
        }
        return Scaffold(
            body: SingleChildScrollView(
              child: Column (
                mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Card(
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
                        color: Colors.green,
                        child:
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                    color: Colors.blue,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${widget.station}",
                                          style: TextStyle(
                                            fontSize: 25.0,
                                            color: Colors.black,
                                          ),
                                        ),
                                        // Text("$line",
                                        //   style: TextStyle(
                                        //     fontSize: 16.0,
                                        //     color: Colors.grey,
                                        //   ),
                                        // ),
                                        Text("$address",
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(!_favStation ? Icons.favorite_outline : Icons.favorite,
                                size: 20.0,
                                color: Colors.black,
                              ),
                              onPressed: (!_favStation) ?  () {
                                addMyStations(_viewModel.c.email, widget.station);
                                setState(() {
                                  _favStation = true;
                                });
                              } : () {
                                deleteMyStations(_viewModel.c.email, widget.station);
                                setState(() {
                                  _favStation = false;
                                });
                              },
                            ),
                          )

                      ),
                    ),
                    Card(
                      elevation: 3.0,
                      margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(
                          color: Colors.blue[900],
                          width: 2.0,
                        ),
                      ),
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Related links',
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                            Divider(
                              color: Colors.black,
                              thickness: 1.0,
                            ),
                            SizedBox(height: 10.0),
                            Text('Railway:'),
                            SizedBox(height: 10.0),
                            Text('Tram:'),
                            SizedBox(height: 10.0),
                            Text('Bus:'),
                            SizedBox(height: 10.0),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      elevation: 3.0,
                      margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(
                          color: Colors.blue[900],
                          width: 2.0,
                        ),
                      ),
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Services:',
                              style: TextStyle(
                                fontSize: 18.0
                              ),
                            ),
                            Spacer(),
                            Icon(Icons.elevator, size: 30.0),
                            Icon(Icons.wc, size: 25.0)
                          ],
                        ),
                      ),
                    ),
                    Card(
                      elevation: 3.0,
                      margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(
                          color: Colors.blue[900],
                          width: 2.0,
                        ),
                      ),
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Points of interest:',
                              style: TextStyle(
                                  fontSize: 18.0
                              ),
                            ),
                            Divider(
                              color: Colors.black,
                              thickness: 1.0,
                            ),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: buildPoints(),
                            ),

                          ],
                        ),
                      ),
                    ),


                  ]
              ),
            )
        );
      },
    );
  }
}