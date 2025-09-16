part of 'order_bloc.dart';

sealed class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object?> get props => [];
}

final class OrderInitial extends OrderState {}

final class OrderLoaded extends OrderState {
  const OrderLoaded({required this.orderList});

  final List<Order> orderList;

  @override
  List<Object?> get props => super.props..addAll([orderList]);
}

final class OrderLoading extends OrderState {
  const OrderLoading({this.message});

  final String? message;

  @override
  List<Object?> get props => super.props..addAll([message]);
}

final class OrderError extends OrderState {
  const OrderError({this.error});

  final Object? error;

  @override
  List<Object?> get props => super.props..addAll([error]);
}
