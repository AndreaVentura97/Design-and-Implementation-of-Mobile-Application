import 'package:flutter/material.dart';
import '../services/messagesService.dart';


class MessagesByDate extends StatefulWidget {
  String station;

  MessagesByDate({Key key, this.station}) : super(key: key);

  MessagesByDateState createState() => MessagesByDateState();
}


class MessagesByDateState extends State<MessagesByDate> {
  List messages = [];



  void listMessages(station) {
    retrieveMessagesByDate(station).then((netMessages) => setState(() {
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