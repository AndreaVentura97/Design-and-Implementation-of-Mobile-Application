import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'MapWidget.dart';
import 'BuilderWidget.dart';
//import '../view/InfoProfileScreen.dart';

class HomeTab extends StatefulWidget {
  HomeTabState createState() => HomeTabState();
}

class HomeTabState extends State<HomeTab>{

  @override
  void initState() {
    HomeTabState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Flexible(
              flex: 4,
              child: BuilderWidget(),
            ),
            Flexible(
              flex: 7,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                ),
                  child: MapWidget()),
            ),
          ],
        ),
      ),
    );
  }

}