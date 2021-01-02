import 'package:flutter/material.dart';
import 'package:flutter_app/redux/model/AppState.dart';
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

  retrieveMyPoints(email) {
    retrieveMyLikedPoints(email).then((netLikes) => setState(() {
      myLikes = netLikes;
    }));
    retrieveMyUnLikedPoints(email).then((netUnlikes) => setState(() {
      myUnlikes = netUnlikes;
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





  Widget build(BuildContext context) {
     return new StoreConnector<AppState,ViewModel>(
         converter: (store) => createViewModel(store),
          onInit: (store) => retrieveMyPoints(store.state.customer.email),
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