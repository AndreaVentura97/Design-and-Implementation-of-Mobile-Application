import '../db.dart' as DB;

retrieveStations () async {
  var stations = await DB.getDB().collection('markers').find().toList();
  return stations;
}

setStatus (name, value) async {
  await DB.getDB().collection('markers').update({'name': name}, {"\$set": {"status":value}});
}

retrieveStatus (name) async {
  var station = await DB.getDB().collection('markers').findOne({'name': name});
  var status = station['status'];
  return status;
}