import 'package:flutter/material.dart';
import 'package:flutter_app/redux/model/AppState.dart';
import 'package:flutter_app/src/services/service.dart';
import 'package:flutter_app/src/view/viewModel.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../services/stationServices.dart';

class Comment extends StatefulWidget {
  String station;
  Comment({Key key, this.station}) : super(key: key);
  CommentState createState() => CommentState();
}


class CommentState extends State<Comment> {
  final myController = TextEditingController();


  @override
  void initState() {
    super.initState();
  }


  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, ViewModel>(
      converter: (store) => createViewModel(store),
      builder: (context,_viewModel){
        return Column(children: [TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter a comment', ),
            controller: myController
        ),OutlineButton(
          child: Text("Send comment"),
          onPressed: () {
            var name = _viewModel.c.name;
            var email = _viewModel.c.email;
            var photo = _viewModel.c.photo;
            saveMessage(email, name, myController.text,photo, widget.station);
            myController.clear();

          },
        ),
          /*
          OutlineButton(
            child: Text("Retrieve the most recent comments about this station "),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder:(context)=>
                  MessagesByDate(station: widget.name)),);
            },
          ),

           */
          /*
          OutlineButton(
            child: Text("Retrieve all the comments about this station "),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder:(context)=>
                  Messages(station: widget.name)),);
            },
          ),

           */

        ]);
        },

    );
  }
}