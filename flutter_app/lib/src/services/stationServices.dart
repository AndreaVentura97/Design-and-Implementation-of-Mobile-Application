import '../db.dart' as DB;

informationStation (name) async {
  var response = await DB.getDB().collection('markers').findOne({'name': name});
  return response;
}

sendCleaning(value, email, station) async {
  var user = await DB.getDB().collection('votes').findOne({'vote': "cleaning", 'email':email, 'station': station});
  if (user!=null){
    await DB.getDB().collection('votes').update({'vote': "cleaning", 'email': email, 'station': station}, {"\$set": {"value":value}});
  }
  else {
    await DB.getDB().collection('votes').insertOne({'vote': "cleaning", 'email': email, 'value': value, 'station': station});
  }
  double avg = await updateMeanClean(station);
  return avg;
}

sendDis(value, email, station) async {
  var user = await DB.getDB().collection('votes').findOne({'vote': "dis", 'email':email, 'station': station});
  if (user!=null){
    await DB.getDB().collection('votes').update({'vote': "dis", 'email': email, 'station': station}, {"\$set": {"value":value}});
  }
  else {
    await DB.getDB().collection('votes').insertOne({'vote': "dis", 'email': email, 'value': value, 'station': station});
  }
  double avg = await updateMeanDis(station);
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
