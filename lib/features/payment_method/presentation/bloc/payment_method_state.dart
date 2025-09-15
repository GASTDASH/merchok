part of 'payment_method_bloc.dart';

sealed class PaymentMethodState extends Equatable {
  const PaymentMethodState();

  @override
  List<Object?> get props => [];
}

final class PaymentMethodInitial extends PaymentMethodState {}

final class PaymentMethodLoaded extends PaymentMethodState {
  const PaymentMethodLoaded({required this.paymentMethodList});

  final List<PaymentMethod> paymentMethodList;

  @override
  List<Object?> get props => super.props..addAll([paymentMethodList]);
}

final class PaymentMethodLoading extends PaymentMethodState {
  const PaymentMethodLoading({this.message});

  final String? message;

  @override
  List<Object?> get props => super.props..addAll([message]);
}

final class PaymentMethodError extends PaymentMethodState {
  const PaymentMethodError({required this.error});

  final Object error;

  @override
  List<Object?> get props => super.props..addAll([error]);
}
