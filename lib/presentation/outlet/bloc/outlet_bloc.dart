import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos_responsive_app/data/datasource/outlet_remote_datasource.dart';
import 'package:flutter_pos_responsive_app/data/models/response/outlet_response_model.dart';

part 'outlet_event.dart';
part 'outlet_state.dart';

class OutletBloc extends Bloc<OutletEvent, OutletState> {
  final OutletRemoteDatasource _outletRemoteDatasource;

  OutletBloc(this._outletRemoteDatasource) : super(OutletInitial()) {
    on<GetOutletsEvent>((event, emit) async {
      emit(OutletLoading());
      final result = await _outletRemoteDatasource.getOutlets();
      result.fold(
        (error) => emit(OutletError(error)),
        (data) => emit(OutletLoaded(data.data ?? [])),
      );
    });

    on<GetOutletByIdEvent>((event, emit) async {
      emit(OutletLoading());
      final result = await _outletRemoteDatasource.getOutletById(event.outletId);
      result.fold(
        (error) => emit(OutletError(error)),
        (data) => emit(OutletLoaded(data.data ?? [])),
      );
    });

    on<CreateOutletEvent>((event, emit) async {
      emit(OutletLoading());
      final result = await _outletRemoteDatasource.createOutlet(event.data);
      result.fold(
        (error) => emit(OutletError(error)),
        (data) => emit(OutletSuccess(data.message ?? 'Outlet created successfully', 
            outlet: data.data?.first)),
      );
    });

    on<UpdateOutletEvent>((event, emit) async {
      emit(OutletLoading());
      final result = await _outletRemoteDatasource.updateOutlet(event.outletId, event.data);
      result.fold(
        (error) => emit(OutletError(error)),
        (data) => emit(OutletSuccess(data.message ?? 'Outlet updated successfully', 
            outlet: data.data?.first)),
      );
    });

    on<DeleteOutletEvent>((event, emit) async {
      emit(OutletLoading());
      final result = await _outletRemoteDatasource.deleteOutlet(event.outletId);
      result.fold(
        (error) => emit(OutletError(error)),
        (data) => emit(OutletSuccess(data.message ?? 'Outlet deleted successfully')),
      );
    });
  }
}