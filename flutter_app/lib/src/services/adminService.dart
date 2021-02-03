import '../db.dart' as DB;

retrieveStations () async {
  var stations = await DB.getDB().collection('markers').find().toList();
  return stations;
}

retrieveStations2 () async {
  var stations = await DB.getDB().collection('markers').find().toList();
  for (int i = 0; i < stations.length;i++){
    var result = await checkSuggestions(stations[i]['name']);
    stations[i]['_id'] = result;
  }
  return stations;
}
checkSuggestions(station) async {
  var response = await DB.getDB().collection('suggestions').find({'station': station}).toList();
  if (response.length!=0){
    return true;
  }
  else {
    return false;
  }
}

setStatus (name, value) async {
  await DB.getDB().collection('markers').update({'name': name}, {"\$set": {"status":value}});
}

retrieveStatus (name) async {
  var station = await DB.getDB().collection('markers').findOne({'name': name});
  var status = station['status'];
  return status;
}

removeSuggestion(id) async {
  await DB.getDB().collection('suggestions').remove({'_id': id});
}