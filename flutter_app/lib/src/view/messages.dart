import 'package:flutter/material.dart';
import '../services/service.dart';
import '../services/messagesService.dart';
import '../services/userService.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_app/redux/model/AppState.dart';
import 'package:flutter_app/redux/model/customer.dart';


class Messages extends StatefulWidget {
  String station = "";
  Messages({Key key, this.station}) : super(key: key);
  MessagesState createState() => MessagesState();
}


class MessagesState extends State<Messages> {
  List messages = [];
  List myLikes = [];
  List myUnlikes = [];



  void listMessages(station) {
    retrieveMessages(station).then((netMessages) => setState(() {
      messages = netMessages;
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

  bool checkUnlike (id){
    for (int i = 0; i < myUnlikes.length; i++) {
      if (myUnlikes[i] == id) {
        return true;
      }
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    listMessages(widget.station);

  }

  Widget build(BuildContext context) {
    return new StoreConnector <AppState,ViewModel>(
      converter : (store) => createViewModel(store),
      onInit: (store) => createViewModel(store),
      builder: (context,_viewModel) {
        var email = _viewModel.c.email;
        retrieveMyLikes(email).then((netLikes) => setState(() {
          myLikes = netLikes;
        }));
        retrieveMyUnlikes(email).then((netUnlikes) => setState(() {
          myUnlikes = netUnlikes;
        }));
        return Scaffold(
            appBar: AppBar(
              title: Text("Comments"),
            ),
            body: ListView.builder(
              //shrinkWrap: true,
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    contentPadding: EdgeInsets.all(10.0),
                    title: Row(
                      children: [
                        Text(messages[index]['text'],
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.black)),
                        IconButton(
                          icon: Icon(
                              Icons.thumb_up,
                              color: ((checkLike(messages[index]['_id']))) ? Colors.green : Colors.grey),
                          onPressed: () {
                            if ((!checkLike(messages[index]['_id']))){
                              removeUnlike(_viewModel.c.email, messages[index]['_id']);
                              insertLike(_viewModel.c.email, messages[index]['_id']);
                              }
                            else {
                              removeLike(_viewModel.c.email, messages[index]['_id']);
                            }
                          }
                          ),
                        Text("tot: ${messages[index]['nl']}"),
                        IconButton(
                            icon: Icon(
                                Icons.thumb_down,
                                color: ((checkUnlike(messages[index]['_id']))) ? Colors.red : Colors.grey),
                            onPressed: () {
                              if ((!checkUnlike(messages[index]['_id']))){
                                removeLike(_viewModel.c.email, messages[index]['_id']);
                                insertUnlike(_viewModel.c.email, messages[index]['_id']);
                              }
                              else {
                                removeUnlike(_viewModel.c.email, messages[index]['_id']);
                              }
                            }
                        ),

                      ],
                    )

                );
              },
            )
        );
      }

    );
  }
}


class ViewModel {
  Customer c;
  ViewModel({this.c});
}

createViewModel(Store<AppState> store){
  return ViewModel(c: store.state.customer);
}


