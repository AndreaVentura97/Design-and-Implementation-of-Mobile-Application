import 'package:flutter/material.dart';
import 'package:flutter_app/redux/reducers/AppStateReducer.dart';
import 'src/view/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'src/db.dart' as DB;
import 'package:sevr/sevr.dart';
import 'package:flutter_app/redux/model/AppState.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'src/checkLogin.dart';
import 'redux/model/customer.dart';


final server = new Sevr();
const port = 8081;
SharedPreferences prefs;
Store <AppState> store;
void main () async {
  server.listen(port, callback: () {
    print('Server listening on port: $port');
  });
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (await getLogged()==true){
    var user = await exportProfile();
    print("just logged");
    final Customer customer = new Customer(name: user[0], email: user[1], photo: user[2],notification:false);
    store = new Store(appReducer, initialState: AppState(customer:customer));
  }
  else {
    print("not logged");
    store = new Store(appReducer, initialState: AppState());
  }
  runApp(MyApp(store:store));
}


/*
class MyApp extends StatelessWidget {
  bool flag;
  MyApp({Key key, this.flag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Login ()
    );
  }
}
*/

class MyApp extends StatefulWidget {
  final Store<AppState> store;
  const MyApp({Key key, this.store}) : super(key: key);
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp>{
  bool ready = false;

  void setReady() {
    DB.start().then((result) => setState(() {
      ready = result;
    }));
  }
  @override
  void initState() {
    super.initState();
    setReady();
  }

  @override
  Widget build(BuildContext context) {
    return new StoreProvider <AppState>(
      store: widget.store,
      child: MaterialApp(
          title: 'Flutter App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: (ready) ? Login () :
              Center (
                child: Text("Loading")
              ),
        debugShowCheckedModeBanner:false


      ),
    );
  }

}


