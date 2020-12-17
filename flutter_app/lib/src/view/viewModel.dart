import 'package:flutter_app/redux/model/AppState.dart';
import 'package:flutter_app/redux/model/customer.dart';
import 'package:redux/redux.dart';

class ViewModel {
  Customer c;
  ViewModel({this.c});
}

createViewModel(Store<AppState> store){
  return ViewModel(c: store.state.customer);
}