import '../db.dart' as DB;

informationStation (name) async {
  var response = await DB.getDB().collection('markers').findOne({'name': name});
  return response;
}

informationStationByName (name) async {
  var response = await DB.getDB().collection('markers').findOne({'name': name});
  return response;
}

lineStation (name) async {
  var response = await DB.getDB().collection('markers').findOne({'name': name});
  if (response['line'] == "Metro M1"){
    return "Red";
  }

}

pointsStation (name) async {
  var response = await DB.getDB().collection('points').find({'station': name}).toList();
  return response;
}

sendCleaning(value, email, station, citizen) async {
  var user = await DB.getDB().collection('votes').findOne({'vote': "cleaning", 'email':email, 'station': station});
  if (user!=null){
    await DB.getDB().collection('votes').update({'vote': "cleaning", 'email': email, 'station': station}, {"\$set": {"value":value}});
  }
  else {
    await DB.getDB().collection('votes').insertOne({'vote': "cleaning", 'email': email, 'value': value, 'station': station, 'citizen':citizen});
  }
  double avg = await updateMeanClean(station);
  return avg;
}

sendDis(value, email, station,citizen) async {
  var user = await DB.getDB().collection('votes').findOne({'vote': "dis", 'email':email, 'station': station});
  if (user!=null){
    await DB.getDB().collection('votes').update({'vote': "dis", 'email': email, 'station': station}, {"\$set": {"value":value}});
  }
  else {
    await DB.getDB().collection('votes').insertOne({'vote': "dis", 'email': email, 'value': value, 'station': station, 'citizen':citizen});
  }
  double avg = await updateMeanDis(station);
  return avg;
}

sendSafety(value, email, station,citizen) async {
  var user = await DB.getDB().collection('votes').findOne({'vote': "safety", 'email':email, 'station': station});
  if (user!=null){
    await DB.getDB().collection('votes').update({'vote': "safety", 'email': email, 'station': station}, {"\$set": {"value":value}});
  }
  else {
    await DB.getDB().collection('votes').insertOne({'vote': "safety", 'email': email, 'value': value, 'station': station, 'citizen':citizen});
  }
  double avg = await updateMeanSafety(station);
  return avg;
}

sendArea(value, email, station,citizen) async {
  var user = await DB.getDB().collection('votes').findOne({'vote': "area", 'email':email, 'station': station});
  if (user!=null){
    await DB.getDB().collection('votes').update({'vote': "area", 'email': email, 'station': station}, {"\$set": {"value":value}});
  }
  else {
    await DB.getDB().collection('votes').insertOne({'vote': "area", 'email': email, 'value': value, 'station': station,'citizen':citizen});
  }
  double avg = await updateMeanArea(station);
  return avg;
}

retrieveMyVoteCleaning (email,station) async {
  var response = await DB.getDB().collection('votes').findOne({'vote': "cleaning", 'email':email, 'station': station});
  if (response!=null){
    var vote = response['value'];
    return vote;
  }
  double fifty = 50.00;
  return fifty;
}

retrieveMyVoteDis (email,station) async {
  var response = await DB.getDB().collection('votes').findOne({'vote': "dis", 'email':email, 'station': station});
  if (response!=null){
    var vote = response['value'];
    return vote;
  }
  double fifty = 50.00;
  return fifty;
}

retrieveMyVoteSafety (email,station) async {
  var response = await DB.getDB().collection('votes').findOne({'vote': "safety", 'email':email, 'station': station});
  if (response!=null){
    var vote = response['value'];
    return vote;
  }
  double fifty = 50.00;
  return fifty;
}

retrieveMyVoteArea (email,station) async {
  var response = await DB.getDB().collection('votes').findOne({'vote': "area", 'email':email, 'station': station});
  if (response!=null){
    var vote = response['value'];
    return vote;
  }
  double fifty = 50.00;
  return fifty;
}

updateMeanClean (station) async {
  var allComments = await DB.getDB().collection('votes').find({'vote': "cleaning", 'station': station}).toList();
  var n = allComments.length;
  double total = 0;
  for (int i=0;i<allComments.length; i++){
    total = total + allComments[i]['value'];
  }
  double avg;
  if (n==0){
    avg = 50.0;
    return avg;
  }
  avg = total/n;
  await DB.getDB().collection('markers').update({'name': station}, {"\$set": {"avgClean":avg}});
  return avg;
}

updateMeanDis (station) async {
  var allComments = await DB.getDB().collection('votes').find({'vote': "dis", 'station': station}).toList();
  var n = allComments.length;
  double total = 0;
  for (int i=0;i<allComments.length; i++){
    total = total + allComments[i]['value'];
  }
  double avg;
  if (n==0){
    avg = 50.0;
    return avg;
  }
  avg = total/n;
  await DB.getDB().collection('markers').update({'name': station}, {"\$set": {"avgDis":avg}});
  return avg;
}

updateMeanSafety (station) async {
  var allComments = await DB.getDB().collection('votes').find({'vote': "safety", 'station': station}).toList();
  var n = allComments.length;
  double total = 0;
  for (int i=0;i<allComments.length; i++){
    total = total + allComments[i]['value'];
  }
  double avg;
  if (n==0){
    avg = 50.0;
    return avg;
  }
  avg = total/n;
  await DB.getDB().collection('markers').update({'name': station}, {"\$set": {"avgSafety":avg}});
  return avg;
}

updateMeanArea (station) async {
  var allComments = await DB.getDB().collection('votes').find({'vote': "area", 'station': station}).toList();
  var n = allComments.length;
  double total = 0;
  for (int i=0;i<allComments.length; i++){
    total = total + allComments[i]['value'];
  }
  double avg;
  if (n==0){
    avg = 50.0;
    return avg;
  }
  avg = total/n;
  await DB.getDB().collection('markers').update({'name': station}, {"\$set": {"avgArea":avg}});
  return avg;
}

buildMeanCitizen(station,type) async {
  var allComments = await DB.getDB().collection('votes').find({'vote': type, 'station': station, 'citizen': true}).toList();
  var n = allComments.length;
  double total = 0;
  for (int i=0;i<allComments.length; i++){
    total = total + allComments[i]['value'];
  }
  double avg;
  if (n==0){
    avg = 50.0;
    return avg;
  }
  avg = total/n;
  return avg;
}

buildMeanVisitor(station,type) async {
  var allComments = await DB.getDB().collection('votes').find({'vote': type, 'station': station, 'citizen': false}).toList();
  var n = allComments.length;
  double total = 0;
  for (int i=0;i<allComments.length; i++){
    total = total + allComments[i]['value'];
  }
  double avg;
  if (n==0){
    avg = 50.0;
    return avg;
  }
  avg = total/n;
  return avg;
}

searchStationByName(String name) async {
  if (name == "") return [];
  var response = await DB.getDB().collection('markers').find({"name":{"\$regex": name}}).toList();
  if(response.length==0) {
    String Name = name[0].toUpperCase() + name.substring(1);
    var response2 = await DB.getDB().collection('markers')
        .find({"name":{"\$regex": Name}})
        .toList();
    if (response2.length != 0) {
      return response2;
    }
    else {
      String Name2 = name[0].toUpperCase()+ name[1].toUpperCase() + name.substring(2);
      var response3 = await DB.getDB().collection('markers')
          .find({"name":{"\$regex": Name2}})
          .toList();
      if (response3.length!=0){
        return response3;
      }
    }
  }


  return response;
}

searchStationByLine(String line) async {
  var response = await DB.getDB().collection('markers').find({'line':line}).toList();
  return response;
}

getBusLinks(station) async {
  var response = await DB.getDB().collection('markers').findOne({'name':station});
  return response['bus'];
}

getRailwayLinks(station) async {
  var response = await DB.getDB().collection('markers').findOne({'name':station});
  return response['railway'];
}

getTramLinks(station) async {
  var response = await DB.getDB().collection('markers').findOne({'name':station});
  return response['tram'];
}

getServices(station) async {
  var response = await DB.getDB().collection('markers').findOne({'name':station});
  return response['services'];
}
