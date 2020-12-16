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
    //removeUnlike(email, idComment);
    bool flag = false;
    for (int i = 0; i < list.length; i++) {
      if (list[i] == idComment) {
        flag = true;
        return false;
      }
    }
    if (!flag) {
      list.add(idComment);
      plusOne(idComment);
      await DB.getDB().collection('users').update(
          {'email': email}, {"\$set": {"myLiked": list}});
      return true;
    }
  }
}

insertUnlike (email, idComment) async {
  var response = await DB.getDB().collection('users').findOne({'email': email});
  var myUnliked = response['myUnliked'];
  var list;
  if (myUnliked==null){
    list = new List();
    list.add(idComment);
    await DB.getDB().collection('users').update({'email': email}, {"\$set": {"myUnLiked":list}});
    return;
  }
  else {
    list = myUnliked.toList();
    bool flag = false;
    //removeLike(email, idComment);
    for (int i = 0; i < list.length; i++) {
      if (list[i] == idComment) {
        flag = true;
        return false;
      }
    }
    if (!flag) {
      list.add(idComment);
      await DB.getDB().collection('users').update(
          {'email': email}, {"\$set": {"myUnliked": list}});
      print('incremento');

      return true;
    }
  }
}

removeLike (email, idComment) async {
  var response = await DB.getDB().collection('users').findOne({'email': email});
  var myLiked = response['myLiked'];
  var list;
  if (myLiked==null){
    return;
  }
  else {
    list = myLiked.toList();
    for (int i = 0; i < list.length; i++) {
      if (list[i]==idComment) {
        list.remove(idComment);
        await DB.getDB().collection('users').update(
            {'email': email}, {"\$set": {"myLiked": list}});
      }
    }
  }
  return;
}

removeUnlike (email, idComment) async {
  var response = await DB.getDB().collection('users').findOne({'email': email});
  var myUnliked = response['myUnliked'];
  var list;
  if (myUnliked==null){
    return;
  }
  else {
    list = myUnliked.toList();
    for (int i = 0; i < list.length; i++) {
      if (list[i] == idComment) {
        list.remove(idComment);
        await DB.getDB().collection('users').update(
            {'email': email}, {"\$set": {"myUnliked": list}});
      }
    }
  }
  return;
}

plusOne (idComment) async {
  var response = await DB.getDB().collection('messages').findOne({'_id': idComment});
  var nl = response['nl'];
  if(nl==null){
    print('incremento2');
    await DB.getDB().collection('messages').update(
        {'_id': idComment}, {"\$set": {"nl": 1}});
    return;
  }
  print('incremento3');
  nl = nl + 1;
  await DB.getDB().collection('messages').update(
      {'_id': idComment}, {"\$set": {"nl": nl}});
}