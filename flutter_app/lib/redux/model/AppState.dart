import 'package:meta/meta.dart';
import 'customer.dart';

@immutable
class AppState {
  Customer customer;


  AppState({
    this.customer,
  });

  AppState.copyWith({AppState prev, Customer customer}) {
    //this.isLoading = isLoading ?? prev.isLoading;
    this.customer = customer ?? prev.customer;
  }




}