import 'package:delayed_display/delayed_display.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/db.dart' as DB;
import 'package:flutter_app/src/view/login.dart';
import 'package:flutter_app/src/view/register.dart';
import 'package:flutter_app/src/view/map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Widget createWidgetForTesting({Widget child}){
  return MaterialApp(
    home: child,
  );
}


void main() async  {
  await DB.start();
  testWidgets('MapTest', (WidgetTester tester) async {
    Widget map = Map();
    await tester.pumpWidget(createWidgetForTesting(child: map));
    final childFinder = find.descendant(of: find.byWidget(map), matching: find.byType(Scaffold));
    expect(childFinder, findsOneWidget);
    expect(find.text("Map"), findsOneWidget);
    var cameraPosition = CameraPosition(
      target:  LatLng(45.456532, 9.125001),
      zoom: 12.0,
    );
    final gmap = find.byType(GoogleMap);
    expect(gmap,findsOneWidget);
    expect(find.byType(Column),findsOneWidget);

  });
}