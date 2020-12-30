import '../db.dart' as DB;

insertLikePoints (email, idPoints) async {
  var response = await DB.getDB().collection('users').findOne({'email': email});
  var myLikedPoints = response['myLikedPoints'];
  var list;
  if (myLikedPoints==null){
    list = new List();
    list.add(idPoints);

    await DB.getDB().collection('users').update({'email': email}, {"\$set": {"myLikedPoints":list}});
    return;
  }
  else {
    list = myLikedPoints.toList();
    bool flag = false;
    for (int i = 0; i < list.length; i++) {
      if (list[i] == idPoints) {
        flag = true;
        return false;
      }
    }
    if (!flag) {
      list.add(idPoints);
      await DB.getDB().collection('users').update(
          {'email': email}, {"\$set": {"myLikedPoints": list}});
      return true;
    }
  }
}

insertUnlikePoints (email, idPoints) async {
  var response = await DB.getDB().collection('users').findOne({'email': email});
  var myUnlikedPoints = response['myUnlikedPoints'];
  var list;
  if (myUnlikedPoints==null){
    list = new List();
    list.add(idPoints);
    await DB.getDB().collection('users').update({'email': email}, {"\$set": {"myUnLikedPoints":list}});
    return;
  }
  else {
    list = myUnlikedPoints.toList();
    bool flag = false;
    //removeLike(email, idComment);
    for (int i = 0; i < list.length; i++) {
      if (list[i] == idPoints) {
        flag = true;
        return false;
      }
    }
    if (!flag) {
      list.add(idPoints);
      await DB.getDB().collection('users').update(
          {'email': email}, {"\$set": {"myUnlikedPoints": list}});
      return true;
    }
  }
}

removeLikePoints (email, idPoints) async {
  var response = await DB.getDB().collection('users').findOne({'email': email});
  var myLikedPoints = response['myLikedPoints'];
  var list;
  if (myLikedPoints==null){
    return;
  }
  else {
    list = myLikedPoints.toList();
    for (int i = 0; i < list.length; i++) {
      if (list[i]==idPoints) {
        list.remove(idPoints);
        await DB.getDB().collection('users').update(
            {'email': email}, {"\$set": {"myLikedPoints": list}});
      }
    }
  }
  return;
}

removeUnlikePoints (email, idPoints) async {
  var response = await DB.getDB().collection('users').findOne({'email': email});
  var myUnlikedPoints = response['myUnlikedPoints'];
  var list;
  if (myUnlikedPoints==null){
    return;
  }
  else {
    list = myUnlikedPoints.toList();
    for (int i = 0; i < list.length; i++) {
      if (list[i] == idPoints) {
        list.remove(idPoints);
        await DB.getDB().collection('users').update(
            {'email': email}, {"\$set": {"myUnlikedPoints": list}});
      }
    }
  }
  return;
}

plusOnePoints (id) async {
  var response = await DB.getDB().collection('points').findOne({'_id': id});
  var nl = response['nl'];
  nl = nl + 1;
  await DB.getDB().collection('points').update(
      {'_id': id}, {"\$set": {"nl": nl}});
}

minusOnePoints (id) async {
  var response = await DB.getDB().collection('points').findOne({'_id': id});
  var nl = response['nl'];
  nl = nl - 1;
  await DB.getDB().collection('points').update(
      {'_id': id}, {"\$set": {"nl": nl}});
}

plusOne2Points (id) async {
  var response = await DB.getDB().collection('points').findOne({'_id': id});
  var nu = response['nu'];
  nu = nu + 1;
  await DB.getDB().collection('points').update(
      {'_id': id}, {"\$set": {"nu": nu}});
}

minusOne2Points (id) async {
  var response = await DB.getDB().collection('points').findOne({'_id': id});
  var nu = response['nu'];
  nu = nu  - 1;
  await DB.getDB().collection('points').update(
      {'_id': id}, {"\$set": {"nu": nu}});
}