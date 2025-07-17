part of 'service_bloc.dart';

@immutable
sealed class ServiceState {}

final class ServiceInitial extends ServiceState {}

final class ServiceLoading extends ServiceState {}

final class ServiceLoaded extends ServiceState {
  final List<Service> services;
  
  ServiceLoaded(this.services);
}

final class ServiceError extends ServiceState {
  final String message;
  
  ServiceError(this.message);
}

final class ServiceSuccess extends ServiceState {
  final String message;
  final Service? service;
  
  ServiceSuccess(this.message, {this.service});
}