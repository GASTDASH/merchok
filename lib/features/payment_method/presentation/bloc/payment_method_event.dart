part of 'payment_method_bloc.dart';

sealed class PaymentMethodEvent extends Equatable {
  const PaymentMethodEvent();

  @override
  List<Object> get props => [];
}

final class PaymentMethodLoad extends PaymentMethodEvent {}

final class PaymentMethodAdd extends PaymentMethodEvent {
  const PaymentMethodAdd({required this.paymentMethod});

  final PaymentMethod paymentMethod;

  @override
  List<Object> get props => super.props..addAll([paymentMethod]);
}

final class PaymentMethodEdit extends PaymentMethodEvent {
  const PaymentMethodEdit({required this.paymentMethod});

  final PaymentMethod paymentMethod;

  @override
  List<Object> get props => super.props..addAll([paymentMethod]);
}

final class PaymentMethodDelete extends PaymentMethodEvent {
  const PaymentMethodDelete({required this.paymentMethodId});

  final String paymentMethodId;

  @override
  List<Object> get props => super.props..addAll([paymentMethodId]);
}
