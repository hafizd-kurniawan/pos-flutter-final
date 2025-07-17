part of 'service_bloc.dart';

@immutable
sealed class ServiceEvent {}

class GetServicesEvent extends ServiceEvent {}

class GetServiceByIdEvent extends ServiceEvent {
  final int serviceId;
  
  GetServiceByIdEvent(this.serviceId);
}

class GetServicesByCategoryEvent extends ServiceEvent {
  final int categoryId;
  
  GetServicesByCategoryEvent(this.categoryId);
}

class SearchServicesEvent extends ServiceEvent {
  final String query;
  
  SearchServicesEvent(this.query);
}

class CreateServiceEvent extends ServiceEvent {
  final Map<String, dynamic> data;
  
  CreateServiceEvent(this.data);
}

class UpdateServiceEvent extends ServiceEvent {
  final int serviceId;
  final Map<String, dynamic> data;
  
  UpdateServiceEvent(this.serviceId, this.data);
}

class DeleteServiceEvent extends ServiceEvent {
  final int serviceId;
  
  DeleteServiceEvent(this.serviceId);
}