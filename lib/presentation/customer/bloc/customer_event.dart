part of 'customer_bloc.dart';

@immutable
sealed class CustomerEvent {}

class GetCustomersEvent extends CustomerEvent {}

class GetCustomerByIdEvent extends CustomerEvent {
  final int customerId;
  
  GetCustomerByIdEvent(this.customerId);
}

class SearchCustomersEvent extends CustomerEvent {
  final String query;
  
  SearchCustomersEvent(this.query);
}

class CreateCustomerEvent extends CustomerEvent {
  final Map<String, dynamic> data;
  
  CreateCustomerEvent(this.data);
}

class UpdateCustomerEvent extends CustomerEvent {
  final int customerId;
  final Map<String, dynamic> data;
  
  UpdateCustomerEvent(this.customerId, this.data);
}

class DeleteCustomerEvent extends CustomerEvent {
  final int customerId;
  
  DeleteCustomerEvent(this.customerId);
}