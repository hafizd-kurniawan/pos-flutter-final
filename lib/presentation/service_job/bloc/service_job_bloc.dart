import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos_responsive_app/data/datasource/service_job_remote_datasource.dart';
import 'package:flutter_pos_responsive_app/data/models/response/service_job_response_model.dart';

part 'service_job_event.dart';
part 'service_job_state.dart';

class ServiceJobBloc extends Bloc<ServiceJobEvent, ServiceJobState> {
  final ServiceJobRemoteDatasource _serviceJobRemoteDatasource;

  ServiceJobBloc(this._serviceJobRemoteDatasource) : super(ServiceJobInitial()) {
    on<GetServiceJobsEvent>((event, emit) async {
      emit(ServiceJobLoading());
      final result = await _serviceJobRemoteDatasource.getServiceJobs();
      result.fold(
        (error) => emit(ServiceJobError(error)),
        (data) => emit(ServiceJobLoaded(data.data ?? [])),
      );
    });

    on<GetServiceJobByIdEvent>((event, emit) async {
      emit(ServiceJobLoading());
      final result = await _serviceJobRemoteDatasource.getServiceJobById(event.serviceJobId);
      result.fold(
        (error) => emit(ServiceJobError(error)),
        (data) => emit(ServiceJobLoaded(data.data ?? [])),
      );
    });

    on<GetServiceJobsByStatusEvent>((event, emit) async {
      emit(ServiceJobLoading());
      final result = await _serviceJobRemoteDatasource.getServiceJobsByStatus(event.status);
      result.fold(
        (error) => emit(ServiceJobError(error)),
        (data) => emit(ServiceJobLoaded(data.data ?? [])),
      );
    });

    on<GetServiceJobsByCustomerEvent>((event, emit) async {
      emit(ServiceJobLoading());
      final result = await _serviceJobRemoteDatasource.getServiceJobsByCustomer(event.customerId);
      result.fold(
        (error) => emit(ServiceJobError(error)),
        (data) => emit(ServiceJobLoaded(data.data ?? [])),
      );
    });

    on<CreateServiceJobEvent>((event, emit) async {
      emit(ServiceJobLoading());
      final result = await _serviceJobRemoteDatasource.createServiceJob(event.data);
      result.fold(
        (error) => emit(ServiceJobError(error)),
        (data) => emit(ServiceJobSuccess(data.message ?? 'Service job created successfully', 
            serviceJob: data.data?.first)),
      );
    });

    on<UpdateServiceJobEvent>((event, emit) async {
      emit(ServiceJobLoading());
      final result = await _serviceJobRemoteDatasource.updateServiceJob(event.serviceJobId, event.data);
      result.fold(
        (error) => emit(ServiceJobError(error)),
        (data) => emit(ServiceJobSuccess(data.message ?? 'Service job updated successfully', 
            serviceJob: data.data?.first)),
      );
    });

    on<DeleteServiceJobEvent>((event, emit) async {
      emit(ServiceJobLoading());
      final result = await _serviceJobRemoteDatasource.deleteServiceJob(event.serviceJobId);
      result.fold(
        (error) => emit(ServiceJobError(error)),
        (data) => emit(ServiceJobSuccess(data.message ?? 'Service job deleted successfully')),
      );
    });
  }
}