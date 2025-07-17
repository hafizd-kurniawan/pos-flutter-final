part of 'outlet_bloc.dart';

@immutable
sealed class OutletEvent {}

class GetOutletsEvent extends OutletEvent {}

class GetOutletByIdEvent extends OutletEvent {
  final int outletId;
  
  GetOutletByIdEvent(this.outletId);
}

class CreateOutletEvent extends OutletEvent {
  final Map<String, dynamic> data;
  
  CreateOutletEvent(this.data);
}

class UpdateOutletEvent extends OutletEvent {
  final int outletId;
  final Map<String, dynamic> data;
  
  UpdateOutletEvent(this.outletId, this.data);
}

class DeleteOutletEvent extends OutletEvent {
  final int outletId;
  
  DeleteOutletEvent(this.outletId);
}