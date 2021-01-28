import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/redux/model/AppState.dart';
import 'package:flutter_app/redux/model/customer.dart';
import 'package:flutter_app/redux/reducers/AppStateReducer.dart';
import 'package:flutter_app/src/db.dart' as DB;
import 'package:flutter_app/src/view/login.dart';
import 'package:flutter_app/src/view/myCommentsScreen.dart';
import 'package:flutter_app/src/view/myStations.dart';
import 'package:flutter_app/src/view/userAccountWidget.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';

Widget createWidgetForTesting({Widget child}){
  final Customer customer = new Customer(name: "", email: "venturaandrea31@gmail.com", photo: "",notification:false);
  Store <AppState> store = new Store(appReducer, initialState: AppState(customer:customer));
  return new StoreProvider <AppState>(
    store: store,
    child : MaterialApp(
      home: child,
  ));
}


void main() async {
  await DB.start();
  testWidgets('MyCommentsTest', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    Widget comments = MyComments();
    await tester.pumpWidget(createWidgetForTesting(child: comments));
    final childFinder = find.descendant(of: find.byWidget(comments), matching: find.byType(Scaffold));
    expect(childFinder, findsOneWidget);
    final text = find.byType(Text);
    expect(text, findsOneWidget);
    MyCommentsState commentsState = tester.state(find.byWidget(comments));
    commentsState.setState(() {
      commentsState.ready = true;
    });
    BuildContext context;
    await tester.pumpWidget(createWidgetForTesting(child: commentsState.build(context)));
    final body = find.byType(ListView);
    expect(body, findsOneWidget);
    final body2 = find.byType(DelayedDisplay);
    expect(body2, findsOneWidget);


  });
}