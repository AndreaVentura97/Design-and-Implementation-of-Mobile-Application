import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/services/adminService.dart';
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

                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // InkWell(
                                      //     child:
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(suggestions[index]['name'],
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.w500,
                                                        color: Colors.black)
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.close,),
                                            onPressed: () {
                                              removeSuggestion(suggestions[index]['_id']);
                                              setState(() {
                                                suggestions.remove(suggestions[index]);
                                              });

                                            },

                                          ),
                                        ],
                                      ),

                                        //),
                                        Row(
                                          children: [
                                            Text(' (',
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Text(suggestions[index]['date'],
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            Text(')',
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),


                                      ],
                                    ),
                                  ),
                                ],
                              ),
                          ),
                        ),
                        Container(
                          //color: Colors.green[100],
                          child: Text(suggestions[index]['text'],
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  letterSpacing: 0.1
                                )
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