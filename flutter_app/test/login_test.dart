import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/view/login.dart';
import 'package:flutter_test/flutter_test.dart';

Widget createWidgetForTesting({Widget child}){
  return MaterialApp(
    home: child,
  );
}


void main() {
  testWidgets('LoginTest', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    Widget login = Login();
    //await tester.pumpWidget(login);
    //await tester.pumpWidget(Login());
    await tester.pumpWidget(createWidgetForTesting(child: login));
    // Verify that our counter starts at 0.

    final childFinder = find.descendant(of: find.byWidget(login), matching: find.byType(DelayedDisplay));
    expect(childFinder, findsOneWidget);
    final grandChildFinder = find.descendant(of: find.byWidget(login), matching: find.byType(Scaffold));
    expect(grandChildFinder, findsOneWidget);
    final grandChildFinder2 = find.descendant(of: find.byWidget(login), matching: find.byType(OutlineButton));
    expect(grandChildFinder2, findsNothing);
    final grandChildFinder3 = find.descendant(of: find.byWidget(login), matching: find.byType(Container));
    expect(grandChildFinder3, findsNWidgets(13));
    expect(find.text('Google'), findsOneWidget);
    expect(find.text('Facebook'), findsOneWidget);
    final grandChildFinder4 = find.descendant(of: find.byWidget(login), matching: find.byType(TextSpan));
    expect(grandChildFinder4, findsNWidgets(0));
    // Tap the '+' icon and trigger a frame.
    //await tester.tap(find.byIcon(Icons.add));
    //await tester.pump();

    // Verify that our counter has incremented.
    //expect(find.text('0'), findsNothing);
    //expect(find.text('1'), findsOneWidget);
  });
}