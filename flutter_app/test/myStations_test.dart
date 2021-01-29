import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/db.dart' as DB;
import 'package:flutter_app/src/view/login.dart';
import 'package:flutter_app/src/view/myStations.dart';
import 'package:flutter_app/src/view/userAccountWidget.dart';
import 'package:flutter_test/flutter_test.dart';

Widget createWidgetForTesting({Widget child}){
  return MaterialApp(
    home: child,
  );
}


void main() async {
  await DB.start();
  testWidgets('MyStationsTest', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    Widget stations = MyStations(email:"tea_il_grande@hotmail.it");
    await tester.pumpWidget(createWidgetForTesting(child: stations));
    final childFinder = find.descendant(of: find.byWidget(stations), matching: find.byType(Scaffold));
    expect(childFinder, findsOneWidget);
    final childFinder2 = find.descendant(of: find.byWidget(stations), matching: find.byType(ListView));
    expect(childFinder2, findsOneWidget);
    //expect(find.byElementType(UserAccount), findsOneWidget);
    final button = find.byType(IconButton);
    expect(button, findsOneWidget);
    final ua = find.byWidget(UserAccount());
    print(ua);
    await tester.tap(button);
    final childFinder3 = find.descendant(of: find.byWidget(stations), matching: find.byType(ListView));
    expect(childFinder3, findsOneWidget);
    final dd = find.byType(DelayedDisplay, skipOffstage: false);
    expect(dd, findsOneWidget);



    // Tap the '+' icon and trigger a frame.
    //await tester.tap(find.byIcon(Icons.add));
    //await tester.pump();

    // Verify that our counter has incremented.
    //expect(find.text('0'), findsNothing);
    //expect(find.text('1'), findsOneWidget);
  });
}