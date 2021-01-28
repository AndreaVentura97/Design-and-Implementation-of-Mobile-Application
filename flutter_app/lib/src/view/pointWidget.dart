import 'package:flutter/material.dart';
import 'package:flutter_app/redux/model/AppState.dart';
import 'package:flutter_app/src/services/stationServices.dart';
import 'package:flutter_app/src/services/userService.dart';
import 'package:flutter_app/src/view/viewModel.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/pointsServices.dart';
import '../services/userService.dart';


class PointWidget extends StatefulWidget {
  var point;
  PointWidget({Key key, this.point}) : super(key: key);
  PointWidgetState createState() => PointWidgetState();
}

class PointWidgetState extends State<PointWidget>{
  List myLikes = [];
  List myUnlikes = [];
  var distance;
  var latitudeStation;
  var longitudeStation;



  retrieveMyPoints(email,idPoint) {
    retrieveMyLikedPoints(email).then((netLikes) => setState(() {
      myLikes = netLikes;
    }));
    retrieveMyUnLikedPoints(email).then((netUnlikes) => setState(() {
      myUnlikes = netUnlikes;
    }));
    calculateDistance(idPoint).then((netDistance) => setState(() {
        distance = netDistance.toStringAsPrecision(2);
    }));
    informationStation(widget.point['station']).then((netStation) => setState ((){
      latitudeStation=netStation['latitude'];
      longitudeStation=netStation['longitude'];
    }));
  }



  bool checkLike(id) {
    for (int i = 0; i < myLikes.length; i++) {
      if (myLikes[i] == id) {
        return true;
      }
    }
    return false;
  }

  bool checkUnlike(id) {
    for (int i = 0; i < myUnlikes.length; i++) {
      if (myUnlikes[i] == id) {
        return true;
      }
    }
    return false;
  }

  Future<void> _launchMapsUrl(double lat, double lon) async {
    //final url1 = 'https://www.google.com/maps/dir/?api=1&origin=$latitudeStation,$longitudeStation&destination=$lat,$lon&travelmode=driving&dir_action=navigate';
    final url2 = 'https://www.google.it/maps/dir/$latitudeStation,$longitudeStation/$lat,$lon/@45.4727846,9.1004871,13z/data=!3m1!4b1!4m7!4m6!1m3!2m2!1d9.138377!2d45.489536!1m0!3e2';
    launch(url2);
    }

    Widget build(BuildContext context) {
     return new StoreConnector<AppState,ViewModel>(
         converter: (store) => createViewModel(store),
          onInit: (store) => retrieveMyPoints(store.state.customer.email,widget.point['_id']),
          builder: (context, _viewModel) {
           return Container(
        //height: 150.0,
        margin: EdgeInsets.symmetric(vertical: 5.0),
        //color: Colors.grey,
            child: IntrinsicHeight(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
                color: Colors.blue,
                child: Image.network(widget.point['photo'],
                  fit: BoxFit.cover,
                  height: 100,
                  width: 100),
                height: 100.0,
                width: 100.0,
              ),
              Expanded(
                child: Container(
                  //color: Colors.red,
                  child: Column(
                    //mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        //color: Colors.orange,
                        child: Row(
                          children: [
                            Icon(Icons.restaurant),
                            Text('${widget.point['name']}',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        //color: Colors.green[200],
                        child: InkWell(
                            child: Text('Link', style:TextStyle(color: Colors.blue,)),
                            onTap: () => {
                              launch(widget.point['webAddress']),
                            }
                      )),
                      Container(
                        //color: Colors.green[200],
                          child: Text('Distance from the station: $distance km', style:TextStyle(color: Colors.black,)),
                          ),
                      Container(
                        //color: Colors.green[200],
                          child: InkWell(
                              child: Text('Take me there', style:TextStyle(color: Colors.red,)),
                              onTap: () => {
                              //Navigator.push(context, MaterialPageRoute(builder:(context)=>PointToStation(point:widget.point,nameStation:widget.point['station'])))
                                _launchMapsUrl(widget.point['latitude'], (widget.point['longitude']))
                              }
                          )),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    icon: Icon(Icons.thumb_up,
                                      size: 25.0,
                                      color: ((checkLike(widget.point['_id'])))
                                           ? Colors.green
                                           : Colors.grey
                                    ),
                                    onPressed: () {
                                      if ((!checkLike(widget.point['_id']))) {
                                         if (checkUnlike(widget.point['_id'])) {
                                           removeUnlikePoints(_viewModel.c.email,
                                           widget.point['_id']);
                                           setState(() {
                                             myUnlikes.remove(widget.point['_id']);
                                           });
                                           widget.point['nu'] = widget.point['nu'] - 1;
                                           minusOne2Points(widget.point['_id']);
                                    }
                                    insertLikePoints(_viewModel.c.email, widget.point['_id']);
                                      setState(() {
                                         myLikes.add(widget.point['_id']);
                                       });
                                      plusOnePoints(widget.point['_id']);
                                         widget.point['nl'] =
                                             widget.point['nl'] + 1;
                                       } else {
                                         removeLikePoints(_viewModel.c.email,
                                             widget.point['_id']);
                                         setState(() {
                                           myLikes.remove(widget.point['_id']);
                                         });
                                         minusOnePoints(widget.point['_id']);
                                         widget.point['nl'] =
                                             widget.point['nl'] - 1;
                                       }
                                     }
                                ),
                                Text("${widget.point['nl']}"),
                                IconButton(
                                    icon: Icon(Icons.thumb_down,
                                      size: 25.0,
                                      color: ((checkUnlike(widget.point['_id'])))
                                           ? Colors.red
                                           : Colors.grey
                                    ),
                                    onPressed: () {
                                      if ((!checkUnlike(widget.point['_id']))) {
                                         if (checkLike((widget.point['_id']))) {
                                           removeLikePoints(_viewModel.c.email,
                                           widget.point['_id']);
                                           setState(() {
                                             myLikes.remove(widget.point['_id']);
                                           });
                                            widget.point['nl'] = widget.point['nl'] - 1;
                                           minusOnePoints(widget.point['_id']);
                                    }
                                      insertUnlikePoints(_viewModel.c.email,
                                      widget.point['_id']);
                                       setState(() {
                                         myUnlikes.add(widget.point['_id']);
                                       });
                                       plusOne2Points(widget.point['_id']);
                                      widget.point['nu'] = widget.point['nu'] + 1;
                                     } else {
                                       removeUnlikePoints(_viewModel.c.email, widget.point['_id']);
                                       setState(() {
                                         myUnlikes.remove(widget.point['_id']);
                                       });
                                       minusOne2Points(widget.point['_id']);
                                        widget.point['nu'] = widget.point['nu'] - 1;
                                     }
                                   }
                                ),
                                Text("${widget.point['nu']}"),
                              ],
                            ),
                          )
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),

        //   ],
        // ),
    );
    });

  }


}