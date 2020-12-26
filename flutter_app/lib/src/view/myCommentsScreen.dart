import 'package:flutter/material.dart';
import 'package:flutter_app/src/services/sendNotification.dart';
import 'package:flutter_app/src/view/viewModel.dart';
import '../services/service.dart';
import '../services/messagesService.dart';
import '../services/userService.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_app/redux/model/AppState.dart';
import 'package:flutter_app/redux/model/customer.dart';


class MyComments extends StatefulWidget {

  MyCommentsState createState() => MyCommentsState();
}


class MyCommentsState extends State<MyComments> {
  List myComments = [];




  void retrieveMyComments(email) {
    getMyComments(email).then((mounted) ? ((netComments) => setState(() {
        myComments = netComments;
    })): null);
  }


  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return new StoreConnector <AppState,ViewModel>(
        converter : (store) => createViewModel(store),
        onInit: (store) => retrieveMyComments(store.state.customer.email),
        builder: (context,_viewModel) {
          return Scaffold(
              appBar: AppBar(
                title: Text("Comments"),
              ),
              body: ListView.builder(
                //shrinkWrap: true,
                itemCount: myComments.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      contentPadding: EdgeInsets.all(10.0),
                      title: Row(
                        children: [
                          Text(myComments[index]['station'],
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black)),
                          Text(":  "),
                          Text(myComments[index]['text'],
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black)),
                          Text("Tot Like: ${myComments[index]['nl']}"),
                          Text("Tot UnLike: ${myComments[index]['nu']}"),
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