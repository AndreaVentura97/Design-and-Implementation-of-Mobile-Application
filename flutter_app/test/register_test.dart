import 'package:delayed_display/delayed_display.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/view/login.dart';
import 'package:flutter_app/src/view/register.dart';
import 'package:flutter_test/flutter_test.dart';

Widget createWidgetForTesting({Widget child}){
  return MaterialApp(
    home: child,
  );
}


void main() {
  testWidgets('RegisterTest', (WidgetTester tester) async {
    Widget register = Register();
    await tester.pumpWidget(createWidgetForTesting(child: register));
    final childFinder = find.descendant(of: find.byWidget(register), matching: find.byType(Scaffold));
    expect(childFinder, findsOneWidget);
    final childFinder2 = find.descendant(of: find.byWidget(register), matching: find.byType(Container));
    expect(childFinder2, findsNWidgets(11));
    final childFinder3 = find.descendant(of: find.byWidget(register), matching: find.byType(Column));
    expect(childFinder3, findsNWidgets(3));
    final childFinder4 = find.descendant(of: find.byWidget(register), matching: find.byType(Row));
    expect(childFinder4, findsNWidgets(0));
  });
}