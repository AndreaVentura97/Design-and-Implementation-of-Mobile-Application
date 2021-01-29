// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_app/redux/model/AppState.dart';
import 'package:flutter_app/redux/model/customer.dart';
import 'package:flutter_app/redux/reducers/AppStateReducer.dart';
import 'package:flutter_app/src/view/login.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';
import 'package:flutter_app/main.dart';

Widget createWidgetForTesting({Widget child}){
  return MaterialApp(
    home: child,
  );
}

void main() {
  testWidgets('MainTest', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    Widget app = MyApp();
    await tester.pumpWidget(createWidgetForTesting(child: app));
    final childFinder = find.descendant(of: find.byWidget(app), matching: find.byType(Text));
    //final home = find.byType(Text,skipOffstage:false);
    //expect(home, findsOneWidget);

    // Verify that our counter starts at 0.
    //expect(find.text('Loading'), findsOneWidget);
    //expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    //await tester.tap(find.byIcon(Icons.add));
    //await tester.pump();

    // Verify that our counter has incremented.
    //expect(find.text('0'), findsNothing);
    //expect(find.text('1'), findsOneWidget);
  });
}
