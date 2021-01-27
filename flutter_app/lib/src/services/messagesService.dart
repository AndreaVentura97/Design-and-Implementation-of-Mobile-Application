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
  nl = nl + 1;
  await DB.getDB().collection('messages').update(
      {'_id': idComment}, {"\$set": {"nl": nl}});
}

minusOne (idComment) async {
  var response = await DB.getDB().collection('messages').findOne({'_id': idComment});
  var nl = response['nl'];
  nl = nl - 1;
  await DB.getDB().collection('messages').update(
      {'_id': idComment}, {"\$set": {"nl": nl}});
}

plusOne2 (idComment) async {
  var response = await DB.getDB().collection('messages').findOne({'_id': idComment});
  var nu = response['nu'];
  nu = nu + 1;
  await DB.getDB().collection('messages').update(
      {'_id': idComment}, {"\$set": {"nu": nu}});
}

minusOne2 (idComment) async {
  var response = await DB.getDB().collection('messages').findOne({'_id': idComment});
  var nu = response['nu'];
  nu = nu  - 1;
  await DB.getDB().collection('messages').update(
      {'_id': idComment}, {"\$set": {"nu": nu}});
}

sortListByUp(list){
  var a=0;
  var b=0;
  List returnList = [];
  if(list.length<3) return list;
  for(int i=0;i<list.length;i++){
    a = list[i]['nl'];
    if(a>=b){
      returnList.add(list[i]);
      b = a;
      if(returnList.length==3) return returnList;
    }
  }
}

deleteMyComment(text,station,name) async {
  await DB.getDB().collection('messages').remove({'text': text,'station':station, 'name':name});
}
