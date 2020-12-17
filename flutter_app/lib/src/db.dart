import 'package:mongo_dart/mongo_dart.dart';
import 'package:sevr/sevr.dart';

var db;
var string = 'mongodb+srv://dbuser:dbpass@cluster0.sxllj.mongodb.net/data?retryWrites=true&w=majority';

start () async {
  db = await Db.create(
      string);
  await db.open(secure:true);
  print("Connected to MongoDb");
  return true;
}

getDB() {
  return db;
}