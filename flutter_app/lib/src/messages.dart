import 'package:flutter/material.dart';
import 'service.dart';




class Message extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        home: Scaffold(
          appBar: AppBar(
            title: Text("Messages"),
          ),
          body: Messages(),
        ));
  }
}



class Messages extends StatefulWidget {
  MessagesState createState() => MessagesState();
}


class MessagesState extends State<Messages> {
  List messages = [];



  void listMessages() {
    retrieveMessages().then((netMessages) => setState(() {
      messages = netMessages;
    }));
  }

  @override
  void initState() {
    super.initState();
    listMessages();
  }

  Widget build(BuildContext context) {
    return

      ListView.builder(
              //shrinkWrap: true,
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    contentPadding: EdgeInsets.all(10.0),
                    title: Text(messages[index],
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black)),

                    );
              },
            );


  }

}


