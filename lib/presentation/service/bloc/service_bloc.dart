import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos_responsive_app/data/datasource/service_remote_datasource.dart';
import 'package:flutter_pos_responsive_app/data/models/response/service_response_model.dart';

part 'service_event.dart';
part 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  final ServiceRemoteDatasource _serviceRemoteDatasource;

  ServiceBloc(this._serviceRemoteDatasource) : super(ServiceInitial()) {
    on<GetServicesEvent>((event, emit) async {
      emit(ServiceLoading());
      final result = await _serviceRemoteDatasource.getServices();
      result.fold(
        (error) => emit(ServiceError(error)),
        (data) => emit(ServiceLoaded(data.data ?? [])),
      );
    });

    on<GetServiceByIdEvent>((event, emit) async {
      emit(ServiceLoading());
      final result = await _serviceRemoteDatasource.getServiceById(event.serviceId);
      result.fold(
        (error) => emit(ServiceError(error)),
        (data) => emit(ServiceLoaded(data.data ?? [])),
      );
    });

    on<GetServicesByCategoryEvent>((event, emit) async {
      emit(ServiceLoading());
      final result = await _serviceRemoteDatasource.getServicesByCategory(event.categoryId);
      result.fold(
        (error) => emit(ServiceError(error)),
        (data) => emit(ServiceLoaded(data.data ?? [])),
      );
    });

    on<SearchServicesEvent>((event, emit) async {
      emit(ServiceLoading());
      final result = await _serviceRemoteDatasource.searchServices(event.query);
      result.fold(
        (error) => emit(ServiceError(error)),
        (data) => emit(ServiceLoaded(data.data ?? [])),
      );
    });

    on<CreateServiceEvent>((event, emit) async {
      emit(ServiceLoading());
      final result = await _serviceRemoteDatasource.createService(event.data);
      result.fold(
        (error) => emit(ServiceError(error)),
        (data) => emit(ServiceSuccess(data.message ?? 'Service created successfully', 
            service: data.data?.first)),
      );
    });

    on<UpdateServiceEvent>((event, emit) async {
      emit(ServiceLoading());
      final result = await _serviceRemoteDatasource.updateService(event.serviceId, event.data);
      result.fold(
        (error) => emit(ServiceError(error)),
        (data) => emit(ServiceSuccess(data.message ?? 'Service updated successfully', 
            service: data.data?.first)),
      );
    });

    on<DeleteServiceEvent>((event, emit) async {
      emit(ServiceLoading());
      final result = await _serviceRemoteDatasource.deleteService(event.serviceId);
      result.fold(
        (error) => emit(ServiceError(error)),
        (data) => emit(ServiceSuccess(data.message ?? 'Service deleted successfully')),
      );
    });
  }
}