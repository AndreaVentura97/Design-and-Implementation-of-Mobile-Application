import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/services/stationServices.dart';
import 'package:flutter_app/src/view/userAccountWidget.dart';
import '../services/userService.dart';
import 'displayMenuStation.dart';
import 'notificationWidget.dart';

class InfoProfile extends StatefulWidget {
  var email;
  InfoProfileState createState() => InfoProfileState();
  InfoProfile({Key key, this.email}) : super(key: key);

}


class InfoProfileState extends State<InfoProfile> {
  var numberComments;
  var totalLikes = 0;
  var totalUnlikes = 0;
  var commentMostLike;
  var commentMostUnLike;
  var win;


  void takeMyStatistics () async {
    getNumberOfMyComments(widget.email).then((result)=>setState((){
      numberComments = result;
    }));
    getNumberOfLikes(widget.email).then((result)=>setState((){
      totalLikes = result;
    }));
    getNumberOfUnLikes(widget.email).then((result)=>setState((){
      totalUnlikes = result;
    }));
    getCommentWithMostLike(widget.email).then((result)=>setState((){
      commentMostLike = result;
    }));
    getCommentWithMostUnLike(widget.email).then((result)=>setState((){
      commentMostUnLike = result;
    }));
  }



  @override
  void initState() {
    takeMyStatistics();
    super.initState();


  }




  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text("My Profile"),
            ],
          ),
        ),

        drawer: UserAccount(),
      body: Column(
        children: [
          Text("Total Comment: $numberComments "),
          Text("Total likes: $totalLikes"),
          Text("Total don't like: $totalUnlikes"),
          (commentMostLike==null) ? Text("You don't have comment") : Text("Comment with most likes: <<${commentMostLike['text']}>> about station ${commentMostLike['station']} with ${commentMostLike['nl']} likes"),
          (commentMostUnLike==null) ? Text("You don't have comment") : Text("Comment with most don't like: <<${commentMostUnLike['text']}>> about station ${commentMostUnLike['station']} with ${commentMostUnLike['nu']} don't like"),
          Text("If the difference between your likes and your don't like is greater than 50 you win a ticket!!!"),
          (totalLikes-totalUnlikes>=50) ? Text("You have won a ticket!! Get it") : Text("You miss ${50-(totalLikes-totalUnlikes)} likes to win!!")
        ],

      ) ,


    );
  }



}