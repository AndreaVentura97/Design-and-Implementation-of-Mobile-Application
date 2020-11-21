import 'package:flutter/material.dart';
import 'db.dart' as DB;
import 'map.dart';
import 'messages.dart';
import 'service.dart';

class Profile extends StatelessWidget {
  String name;
  String photo;
  String email;

  Profile({Key key,this.name, this.photo, this.email}): super(key:key);

  


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: Column (
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text ("$name"),
                Image.network(photo, height: 150.0, width: 150.0,),
                Text ("$email"),
                OutlineButton(
                  child: Text("See map"),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder:(context)=> Map()));

                  },
                ),
              ]
            )
        ),
      ),
    );
  }

}