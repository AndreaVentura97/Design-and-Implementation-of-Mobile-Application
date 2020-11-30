import 'db.dart' as DB;

retrieveMessagesByDate (station) async {
  print(station);
  var response = await DB.getDB().collection('messages').find({'station': station}).toList();
  return new List.from(response.reversed);

}