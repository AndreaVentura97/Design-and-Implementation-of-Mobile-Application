import 'package:flutter/material.dart';
import 'package:flutter_app/redux/model/AppState.dart';
import 'package:flutter_app/src/view/commentTabScreen.dart';
import 'package:flutter_app/src/view/viewModel.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'messages.dart';



class Comments extends StatefulWidget {
  final String station;
  Comments ({Key key, this.station}) : super(key: key);
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, ViewModel>(
        converter: (store) => createViewModel(store),
        builder: (context,_viewModel) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                bottom: TabBar(
                  tabs: [
                    Tab(icon: Icon(Icons.email)),
                    Tab(icon: Icon(Icons.assignment)),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  Messages(station: widget.station),
                  Comment(station: widget.station),
                ],
              ),
            ),
          );
        });
        }
      }

