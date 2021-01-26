import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/services/service.dart';
import 'package:flutter_app/src/services/stationServices.dart';
import 'package:flutter_app/src/view/userAccountWidget.dart';
import '../services/userService.dart';
import 'displayMenuStation.dart';
import 'notificationWidget.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ListViewAd extends StatefulWidget {
  var name;
  ListViewAdState createState() => ListViewAdState();
  ListViewAd({Key key, this.name}) : super(key: key);

}


class ListViewAdState extends State<ListViewAd> {
  List suggestions = [];

  void listSuggestions(station) {
    retrieveSuggestions(station).then((netMessages) => setState(() {
      suggestions = netMessages;
    }));
  }







  @override
  void initState() {
    super.initState();
    listSuggestions(widget.name);
  }




  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        //shrinkWrap: true,
        itemCount: suggestions.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
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
                  child: Container(
                    //color: Colors.red,
                    margin: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          //color: Colors.pink,
                          child: ListTile(
                              dense: true,
                              contentPadding: EdgeInsets.all(0.0),
                              title: Row(
                                children: [
                                  CircleAvatar(
                                    //backgroundColor: Colors.blue[900],
                                    backgroundImage: new NetworkImage(suggestions[index]['photo']),
                                    radius: 15.0,
                                  ),
                                  SizedBox(width: 10.0,),
                                  IntrinsicWidth(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                            child: Text(suggestions[index]['name'],
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black)),
                                            onTap: (){
                                              showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    //return PopupVote(email: messages[index]['email'], station: widget.station);
                                                  });
                                            }
                                        ),
                                        Container(
                                          color: Colors.black,
                                          child: Text(suggestions[index]['date'],
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              trailing: SmoothStarRating(
                                rating: 5,
                                starCount: 5,
                                isReadOnly: true,
                                color: Colors.amber,
                              )
                          ),
                        ),
                        Container(
                          color: Colors.green[100],
                          child: InkWell(
                            child: Text(suggestions[index]['text'],
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black)),
                          ),

                        ),
                      ],
                    ),
                  )
              ),
            ],
          );
        },
      ),
    );
  }



}