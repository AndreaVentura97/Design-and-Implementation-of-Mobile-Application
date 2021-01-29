import 'package:delayed_display/delayed_display.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/redux/model/AppState.dart';
import 'package:flutter_app/redux/model/customer.dart';
import 'package:flutter_app/redux/reducers/AppStateReducer.dart';
import 'package:flutter_app/src/db.dart' as DB;
import 'package:flutter_app/src/view/login.dart';
import 'package:flutter_app/src/view/register.dart';
import 'package:flutter_app/src/view/map.dart';
import 'package:flutter_app/src/view/votingTabScreen.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_test/flutter_test.dart';
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
  testWidgets('VotingTab', (WidgetTester tester) async {
    Widget voting = Voting();
    await tester.pumpWidget(createWidgetForTesting(child: voting));
    VotingState votingState = tester.state(find.byWidget(voting));
    BuildContext context;
    await tester.pumpWidget(createWidgetForTesting(child:votingState.build(context)));
    final scaffold = find.byType(Scaffold);
    final columns = find.byType(Column);
    final cards = find.byType(Card);
    final containers = find.byType(Container);
    expect(scaffold, findsOneWidget);
    expect(columns, findsNWidgets(9));
    expect(cards, findsNWidgets(2));
    expect(containers, findsNWidgets(17));


  });
}