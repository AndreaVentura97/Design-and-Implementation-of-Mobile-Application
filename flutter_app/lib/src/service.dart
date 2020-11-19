import 'db.dart' as DB;
import 'dart:convert';

retrieveMessages() async {

  var response = await DB.getDB().collection('messages').findOne({'name': "andrea"});
  var list = response['messages'];

  //print('elenco messaggi: $b');
  return list;
}