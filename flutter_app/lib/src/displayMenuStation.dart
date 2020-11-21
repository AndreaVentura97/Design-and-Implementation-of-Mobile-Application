import 'package:flutter/material.dart';

class MenuStation extends StatelessWidget {
  String name;
  String line;
  MenuStation({Key key,this.name, this.line}): super(key:key);

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
                  Text ("$line"),
                ]
            )
        ),
      ),
    );
  }

}


