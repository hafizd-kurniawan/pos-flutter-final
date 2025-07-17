part of 'customer_bloc.dart';

@immutable
sealed class CustomerState {}

final class CustomerInitial extends CustomerState {}

final class CustomerLoading extends CustomerState {}

final class CustomerLoaded extends CustomerState {
  final List<Customer> customers;
  
  CustomerLoaded(this.customers);
}

final class CustomerError extends CustomerState {
  final String message;
  
  CustomerError(this.message);
}

final class CustomerSuccess extends CustomerState {
  final String message;
  final Customer? customer;
  
  CustomerSuccess(this.message, {this.customer});
}