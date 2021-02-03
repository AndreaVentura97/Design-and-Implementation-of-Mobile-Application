import 'package:dio/dio.dart';
import '../db.dart' as DB;

var postUrl = "https://fcm.googleapis.com/fcm/send";

Future <void> sendNotification(receiver,ul,nameSender,textMessage,station) async {
  var token = await getToken(receiver);
  final data = {
  "notification": { "body": "You have received a $ul by $nameSender to your comment '$textMessage' on station $station",
                    "title": "New notification",
                    "station":station},
    "priority": "high",
  "data": {
    "click_action": "FLUTTER_NOTIFICATION_CLICK",
    "id": "1",
    "status": "done"
  },
  "to": token
};

final headers = {
  'content-type': 'application/json',
  'Authorization': 'key=AAAAVF9Z6L0:APA91bGbqWFZ64iZ4-eTVB24L9pDMoIOfmwNsSNnAummyfR1zF3seoGQErqs97bUFTZ2nastBOKUu6wVRWueEeUhYMFBUiMUZ1wjSsctUlZVQVmfNBaPAGgrf9iwN1yU49vcO790thXs'
};


BaseOptions options = new BaseOptions(
  connectTimeout: 5000,
  receiveTimeout: 3000,
  headers: headers,
);


try {
final response = await Dio(options).post(postUrl,
data: data);

if (response.statusCode == 200) {
  print('notification sending ok');
} else {
print('notification sending failed');
// on failure do sth
}
}
catch(e){
print('exception $e');
}

}
getToken (receiver) async {
  var user = await DB.getDB().collection('users').findOne({'email': receiver});
  return user['token'];
}

getTokens (station) async {
  var response = await DB.getDB().collection('users').find().toList();
  List tokens = [];
  for (int i=0; i<response.length;i++){
    if (response[i]['myStations'].contains(station)){
      tokens.add(response[i]['token']);
    }
  }
  return tokens;
}

Future <void> sendNotification2(station,st) async {
  List tokens = await getTokens(station);
  var body;
  if (st=="ok"){
    body = "The station $station guarantees regular service";
  }
  else {
    body = "The station $station is not providing regular service";
  }
  for (int i = 0; i < tokens.length; i++) {
    final data = {
      "notification": {
        "body": body,
        "station": station,
        "title": "One of your stations change status"
      },
      "priority": "high",
      "data": {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "id": "1",
        "status": "done"
      },
      "to": tokens[i]
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization': 'key=AAAAVF9Z6L0:APA91bGbqWFZ64iZ4-eTVB24L9pDMoIOfmwNsSNnAummyfR1zF3seoGQErqs97bUFTZ2nastBOKUu6wVRWueEeUhYMFBUiMUZ1wjSsctUlZVQVmfNBaPAGgrf9iwN1yU49vcO790thXs'
    };


    BaseOptions options = new BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 3000,
      headers: headers,
    );


    try {
      final response = await Dio(options).post(postUrl,
          data: data);

      if (response.statusCode == 200) {
        print('notification sending ok');
      } else {
        print('notification sending failed');
// on failure do sth
      }
    }
    catch (e) {
      print('exception $e');
    }
  }
}
