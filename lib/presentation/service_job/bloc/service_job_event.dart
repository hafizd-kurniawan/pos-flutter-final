part of 'service_job_bloc.dart';

@immutable
sealed class ServiceJobEvent {}

class GetServiceJobsEvent extends ServiceJobEvent {}

class GetServiceJobByIdEvent extends ServiceJobEvent {
  final int serviceJobId;
  
  GetServiceJobByIdEvent(this.serviceJobId);
}

class GetServiceJobsByStatusEvent extends ServiceJobEvent {
  final String status;
  
  GetServiceJobsByStatusEvent(this.status);
}

class GetServiceJobsByCustomerEvent extends ServiceJobEvent {
  final int customerId;
  
  GetServiceJobsByCustomerEvent(this.customerId);
}

class CreateServiceJobEvent extends ServiceJobEvent {
  final Map<String, dynamic> data;
  
  CreateServiceJobEvent(this.data);
}

class UpdateServiceJobEvent extends ServiceJobEvent {
  final int serviceJobId;
  final Map<String, dynamic> data;
  
  UpdateServiceJobEvent(this.serviceJobId, this.data);
}

class DeleteServiceJobEvent extends ServiceJobEvent {
  final int serviceJobId;
  
  DeleteServiceJobEvent(this.serviceJobId);
}