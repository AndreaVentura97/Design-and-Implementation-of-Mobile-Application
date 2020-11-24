import 'package:flutter/material.dart';
import 'service.dart';








class Messages extends StatefulWidget {
  String station = "";

  Messages({Key key, this.station}) : super(key: key);

  MessagesState createState() => MessagesState();
}


class MessagesState extends State<Messages> {
  List messages = [];



  void listMessages(station) {
    retrieveMessages(station).then((netMessages) => setState(() {
      messages = netMessages;
    }));
  }

  @override
  void initState() {
    super.initState();
    listMessages(widget.station);
  }

  Widget build(BuildContext context) {
    return MaterialApp(

        home: Scaffold(
          appBar: AppBar(
            title: Text("Messages"),
          ),
          body: ListView.builder(
          //shrinkWrap: true,
          itemCount: messages.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
            contentPadding: EdgeInsets.all(10.0),
              title: Text(messages[index]['text'],
              style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.black)),

    );
    },
    )



        ));
  }



}


