import '../db.dart' as DB;

informationStation (name) async {
  var response = await DB.getDB().collection('markers').findOne({'name': name});
  return response;
}

pointsStation (name) async {
  var response = await DB.getDB().collection('points').find({'station': name}).toList();
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

sendSafety(value, email, station) async {
  var user = await DB.getDB().collection('votes').findOne({'vote': "safety", 'email':email, 'station': station});
  if (user!=null){
    await DB.getDB().collection('votes').update({'vote': "safety", 'email': email, 'station': station}, {"\$set": {"value":value}});
  }
  else {
    await DB.getDB().collection('votes').insertOne({'vote': "safety", 'email': email, 'value': value, 'station': station});
  }
  double avg = await updateMeanSafety(station);
  return avg;
}

sendArea(value, email, station) async {
  var user = await DB.getDB().collection('votes').findOne({'vote': "area", 'email':email, 'station': station});
  if (user!=null){
    await DB.getDB().collection('votes').update({'vote': "area", 'email': email, 'station': station}, {"\$set": {"value":value}});
  }
  else {
    await DB.getDB().collection('votes').insertOne({'vote': "area", 'email': email, 'value': value, 'station': station});
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
