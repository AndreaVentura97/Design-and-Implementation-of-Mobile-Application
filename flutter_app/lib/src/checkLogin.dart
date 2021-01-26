import 'package:shared_preferences/shared_preferences.dart';

var name;
var email;
var photo;

checkSession (name,email,photo) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("name", name);
  prefs.setString("email", email);
  if (photo!=null) prefs.setString("photo", photo);
  name = prefs.getString("name");
  email = prefs.getString("email");
  photo = prefs.getString("photo");
  prefs.setBool("log", true);
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
  n = prefs.getString("name");
  e = prefs.getString("email");
  p = prefs.getString("photo");
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
  //ToCheck
  prefs.setString("photo", null);
}

setPhoto(photo) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("photo", photo);
}









