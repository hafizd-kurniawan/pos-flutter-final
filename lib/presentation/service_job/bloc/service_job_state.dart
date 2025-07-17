part of 'service_job_bloc.dart';

@immutable
sealed class ServiceJobState {}

final class ServiceJobInitial extends ServiceJobState {}

final class ServiceJobLoading extends ServiceJobState {}

final class ServiceJobLoaded extends ServiceJobState {
  final List<ServiceJob> serviceJobs;
  
  ServiceJobLoaded(this.serviceJobs);
}

final class ServiceJobError extends ServiceJobState {
  final String message;
  
  ServiceJobError(this.message);
}

final class ServiceJobSuccess extends ServiceJobState {
  final String message;
  final ServiceJob? serviceJob;
  
  ServiceJobSuccess(this.message, {this.serviceJob});
}