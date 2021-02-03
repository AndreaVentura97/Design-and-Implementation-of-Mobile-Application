import 'package:shared_preferences/shared_preferences.dart';

var name;
var email;
var photo;
List <String> messages = [];

checkSession (name,email,photo) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("name", name);
  prefs.setString("email", email);
  List <String> mes = [];
  prefs.setStringList("messages", mes);
  if (photo!=null) {prefs.setString("photo", photo);};
  name = prefs.getString("name");
  email = prefs.getString("email");
  photo = prefs.getString("photo");
  prefs.setBool("log", true);
  print(prefs.getBool('log'));
  return true;
}

getLogged() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var flag = prefs.getBool("log");
  return flag;
}

exportProfile() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String n,p,e;
  var m;
  n = prefs.getString("name");
  e = prefs.getString("email");
  p = prefs.getString("photo");
  m = prefs.getStringList("messages");
  messages = m;
  name = p;
  email = e;
  photo = p;
  var profile = [n, e, p];
  return profile;
}

getName() {
  return name;
}

getEmail() {
  return email;
}

getPhoto (){
  return photo;
}

setLogged(flag) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("log", flag);
  List<String> m = [];
  messages = m;
  prefs.setStringList("messages",m);
  //ToCheck
  prefs.setString("photo", null);
  //prefs.setString("name", null);
  //prefs.setString("email", null);
}

setPhoto(photo) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("photo", photo);
}

addMessage(message) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  messages.add(message);
  prefs.setStringList("messages", messages);
  print('aggiuntoooooooooooooooooooooooooooooooooooooooooooooooo');
  return true;
}

getMessages () async {

  SharedPreferences prefs = await SharedPreferences.getInstance();
  print(prefs.getStringList("messages"));
  return prefs.getStringList("messages");
}









