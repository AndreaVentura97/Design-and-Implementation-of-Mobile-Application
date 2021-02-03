import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_app/redux/actions/actions.dart';
import 'package:flutter_app/redux/model/AppState.dart';
import 'package:flutter_app/src/tabView/tabStationPage.dart';
import 'package:flutter_app/src/view/viewModel.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../checkLogin.dart' as ch;
import 'notificationScreen.dart' as Not;



class NotificationWidget extends StatefulWidget {
  @override
  _NotificationWidgetState createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool yes = false;
  List<String> messages = [];

  _registerOnFirebase() {
    _firebaseMessaging.getToken().then((token) => print(token));
  }

  @override
  void initState() {

    super.initState();
  }


  void getMessage(store) {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        if(message["notification"]["body"]!=null) {
          print('received message');
          setState(() => messages.add(message["notification"]["body"]));
          ch.addMessage(message["notification"]["body"]).then((result) => setState((){
            yes = result;
          }));
          store.dispatch(updateCustomer(name:store.state.customer.name, email:store.state.customer.email, photo: store.state.customer.photo,notification: true));

        }

      }, onResume: (Map<String, dynamic> message) async {
      print('on resume $message');
      if(message["notification"]["body"]!=null){
        setState(() => messages.add(message["notification"]["body"]));
        ch.addMessage(message["notification"]["body"]).then((result) => setState((){
          yes = result;
        }));
        print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa ${message["notification"]["body"]}");
        Navigator.push(context, MaterialPageRoute(builder:(context)=>MenuStation(name:message["notification"]["station"])));
      }
      //store.dispatch(updateCustomer(name:store.state.customer.name, email:store.state.customer.email, photo: store.state.customer.photo,notification: true));
      //setState(() => yes = true);
    }, onLaunch: (Map<String, dynamic> message) async {
      if(message["notification"]["body"]!=null) {
        print('on launch $message');
        print(
            "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa ${message["notification"]["body"]}");
        setState(() => messages.add(message["notification"]["body"]));
        ch.addMessage(message["notification"]["body"]).then((result) => setState((){
          yes = result;
        }));
        Navigator.push(context, MaterialPageRoute(builder:(context)=>MenuStation(name:message["notification"]["station"])));
        //store.dispatch(updateCustomer(name:store.state.customer.name, email:store.state.customer.email, photo: store.state.customer.photo,notification: true));
        //setState(() => yes = true);
      }


    },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector <AppState, ViewModel> (
        converter: (store) => createViewModel(store),
        onInit: (store) => getMessage(store),
        builder: (context, _viewModel) {
          yes = _viewModel.c.notification;
          return IconButton(
            icon: Icon(Icons.notifications,
              color: (yes) ? Colors.red : Colors.blue[900],
            ),
            onPressed: () {
              StoreProvider.of<AppState>(context).dispatch(updateCustomer(name:_viewModel.c.name, email:_viewModel.c.email, photo: _viewModel.c.photo,notification: false));
              setState((){yes=false;});

              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)
              {
                return Not.Notification();
              }));

        });



  });
}
}

