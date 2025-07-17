part of 'outlet_bloc.dart';

@immutable
sealed class OutletState {}

final class OutletInitial extends OutletState {}

final class OutletLoading extends OutletState {}

final class OutletLoaded extends OutletState {
  final List<Outlet> outlets;
  
  OutletLoaded(this.outlets);
}

final class OutletError extends OutletState {
  final String message;
  
  OutletError(this.message);
}

final class OutletSuccess extends OutletState {
  final String message;
  final Outlet? outlet;
  
  OutletSuccess(this.message, {this.outlet});
}