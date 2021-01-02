import 'package:flutter_app/redux/model/AppState.dart';
import 'customerReducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    //isLoading: loadingReducer(state.isLoading, action),
    customer: customerReducer(state.customer, action),
  );
}