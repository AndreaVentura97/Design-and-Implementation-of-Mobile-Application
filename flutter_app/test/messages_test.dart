import 'package:delayed_display/delayed_display.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/redux/model/AppState.dart';
import 'package:flutter_app/redux/model/customer.dart';
import 'package:flutter_app/redux/reducers/AppStateReducer.dart';
import 'package:flutter_app/src/db.dart' as DB;
import 'package:flutter_app/src/view/login.dart';
import 'package:flutter_app/src/view/messages.dart';
import 'package:flutter_app/src/view/register.dart';
import 'package:flutter_app/src/view/map.dart';
import 'package:flutter_app/src/view/userAccountWidget.dart';
import 'package:flutter_app/src/view/votingTabScreen.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_test_utils/image_test_utils.dart';
import 'package:redux/redux.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Widget createWidgetForTesting({Widget child}){
  final Customer customer = new Customer(name: "", email: "venturaandrea31@gmail.com", photo: "",notification:false);
  Store <AppState> store = new Store(appReducer, initialState: AppState(customer:customer));
  return new StoreProvider <AppState>(
      store: store,
      child : MaterialApp(
        home: child,
      ));
}


void main() async  {
  await DB.start();
  testWidgets('MessagesTest', (WidgetTester tester) async {
    provideMockedNetworkImages (() async{
      Widget messages = Messages(station:"Primaticcio");
      await tester.pumpWidget(createWidgetForTesting(child: messages));
      MessagesState msState = tester.state(find.byWidget(messages));
      BuildContext context;
      await tester.pumpWidget(createWidgetForTesting(child:msState.build(context)));
      final scaffold = find.byType(Scaffold);
      final listView = find.byType(ListView);
      final columns = find.byType(Column);
      final cards = find.byType(Card);
      final texts = find.byType(Text);
      final iconButtons = find.byType(IconButton);
      final tiles = find.byType(ListTile);
      final containers = find.byType(Container);
      expect(scaffold, findsOneWidget);
      expect(listView, findsNWidgets(1));
      expect(columns, findsNWidgets(0));
      expect(cards, findsNWidgets(0));
      expect(containers, findsNWidgets(0));
      expect(tiles, findsNWidgets(0));
      expect(texts, findsNWidgets(0));
      expect(iconButtons, findsNWidgets(0));
    });
  });
}