import '../db.dart' as DB;

retrieveMessagesByDate (station) async {
  print(station);
  var response = await DB.getDB().collection('messages').find({'station': station}).toList();
  return new List.from(response.reversed);

}

insertLike (email, idComment) async {
  var response = await DB.getDB().collection('users').findOne({'email': email});
  var myLiked = response['myLiked'];
  var list;
  if (myLiked==null){
    list = new List();
    list.add(idComment);

    await DB.getDB().collection('users').update({'email': email}, {"\$set": {"myLiked":list}});
    return;
  }
  else {
    list = myLiked.toList();
    bool flag = false;
    for (int i = 0; i < list.length; i++) {
      if (list[i] == idComment) {
        flag = true;
        return false;
      }
    }
    if (!flag) {
      list.add(idComment);
      await DB.getDB().collection('users').update(
          {'email': email}, {"\$set": {"myLiked": list}});
      return true;
    }
  }
}