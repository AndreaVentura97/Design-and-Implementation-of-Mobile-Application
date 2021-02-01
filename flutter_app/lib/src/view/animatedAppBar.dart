import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double _preferredHeight = 60.0;
  final String name;
  final Size value;
  @override
  Size get preferredSize => Size.fromHeight(_preferredHeight);
  AnimatedAppBar ({Key key,this.name,this.value}) : super(key: key);
  AnimatedAppBarState createState() => AnimatedAppBarState();
}

class AnimatedAppBarState extends State<AnimatedAppBar> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _colorTween;



  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  void initState() {
    _animationController =
        AnimationController(vsync:this, duration: Duration(milliseconds: 300));
    _colorTween = ColorTween(begin: Colors.red, end: Colors.green)
        .animate(_animationController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
          children: [
            AppBar(
              title: Text('${widget.name}'),
              actions: <Widget>[
              AnimatedBuilder(
              animation: _colorTween,
                builder: (context, child) => RaisedButton(
                  child: Text("Change my color"),
                  color: _colorTween.value,
                onPressed: () {
                  if (_animationController.status == AnimationStatus.completed) {
                  _animationController.reverse();
                  } else {
                  _animationController.forward();
                }
              },
          ),
          )
              ],
            ),
          ]
      );
    }
  }



