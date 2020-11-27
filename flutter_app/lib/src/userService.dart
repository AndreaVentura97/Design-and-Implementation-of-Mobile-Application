import 'db.dart' as DB;


insertUser (email, name) async {
  bool flag = false;
  var listUser = await DB.getDB().collection('users').find().toList();
  for (int i =0; i < listUser.length; i++){
    if (listUser[i]['email']==email){
      flag = true;
    }
  }
  List <String> myStations = [];
  if (!flag){
    await DB.getDB().collection('users').insertOne({'email': email, 'name': name, 'myStations': myStations});
  }
}

addMyStations (email, station) async {
  bool flag = false;
  var user = await DB.getDB().collection('users').findOne({'email': email});
  var list = user['myStations'].toList();
  if (list.length>0){
    for (int i=0; i < list.length; i++){
      if (list[i]==station){
        flag = true;
      }
    }
  }
  if (!flag){
    list.add(station);
    await DB.getDB().collection('users').update({'email': email}, {"\$set": {"myStations":list}});
  }
}

retrieveMyStations(email) async{
  print(email);
  var user = await DB.getDB().collection('users').findOne({'email': email});
  var myStations = user['myStations'].toList();
  return myStations;
}

