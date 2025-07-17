import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos_responsive_app/data/datasource/customer_remote_datasource.dart';
import 'package:flutter_pos_responsive_app/data/models/response/customer_response_model.dart';

part 'customer_event.dart';
part 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final CustomerRemoteDatasource _customerRemoteDatasource;

  CustomerBloc(this._customerRemoteDatasource) : super(CustomerInitial()) {
    on<GetCustomersEvent>((event, emit) async {
      emit(CustomerLoading());
      final result = await _customerRemoteDatasource.getCustomers();
      result.fold(
        (error) => emit(CustomerError(error)),
        (data) => emit(CustomerLoaded(data.data ?? [])),
      );
    });

    on<GetCustomerByIdEvent>((event, emit) async {
      emit(CustomerLoading());
      final result = await _customerRemoteDatasource.getCustomerById(event.customerId);
      result.fold(
        (error) => emit(CustomerError(error)),
        (data) => emit(CustomerLoaded(data.data ?? [])),
      );
    });

    on<SearchCustomersEvent>((event, emit) async {
      emit(CustomerLoading());
      final result = await _customerRemoteDatasource.searchCustomers(event.query);
      result.fold(
        (error) => emit(CustomerError(error)),
        (data) => emit(CustomerLoaded(data.data ?? [])),
      );
    });

    on<CreateCustomerEvent>((event, emit) async {
      emit(CustomerLoading());
      final result = await _customerRemoteDatasource.createCustomer(event.data);
      result.fold(
        (error) => emit(CustomerError(error)),
        (data) => emit(CustomerSuccess(data.message ?? 'Customer created successfully', 
            customer: data.data?.first)),
      );
    });

    on<UpdateCustomerEvent>((event, emit) async {
      emit(CustomerLoading());
      final result = await _customerRemoteDatasource.updateCustomer(event.customerId, event.data);
      result.fold(
        (error) => emit(CustomerError(error)),
        (data) => emit(CustomerSuccess(data.message ?? 'Customer updated successfully', 
            customer: data.data?.first)),
      );
    });

    on<DeleteCustomerEvent>((event, emit) async {
      emit(CustomerLoading());
      final result = await _customerRemoteDatasource.deleteCustomer(event.customerId);
      result.fold(
        (error) => emit(CustomerError(error)),
        (data) => emit(CustomerSuccess(data.message ?? 'Customer deleted successfully')),
      );
    });
  }
}