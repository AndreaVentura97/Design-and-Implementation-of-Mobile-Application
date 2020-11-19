import 'package:mongo_dart/mongo_dart.dart';
import 'package:sevr/sevr.dart';

var db;
var string = 'mongodb+srv://dbuser:dbpass@cluster0.sxllj.mongodb.net/data?retryWrites=true&w=majority';

void start () async {
  db = await Db.create(
      string);
  await db.open();

  print("Connected to MongoDb");




}

getDB() {
  return db;
}