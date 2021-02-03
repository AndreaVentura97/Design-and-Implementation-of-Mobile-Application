import 'package:flutter/material.dart';
import 'package:flutter_app/src/view/commentTabScreen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  LoadingState createState() => LoadingState();
  }


class LoadingState extends State<Loading>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: 140,
                child: FittedBox(
                  child: Image.asset(
                    'assets/Logo_MeMiQ_2.png',
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20,),
              SpinKitRing(
                color: Colors.grey[200],
                size: 50,
              )
            ],
          ),

      ),
    );
  }
}