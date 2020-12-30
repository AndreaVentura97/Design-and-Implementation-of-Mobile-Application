import 'package:flutter_app/redux/actions/actions.dart';
import 'package:flutter_app/redux/model/customer.dart';

customerReducer(stateLoading, dynamic action){
  if (action is updateCustomer){
    return Customer(name:action.name, email:action.email, photo: action.photo, notification: action.notification);
  }
}