part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

final class CartLoad extends CartEvent {}

final class CartAdd extends CartEvent {
  const CartAdd({required this.merchId});

  final String merchId;

  @override
  List<Object> get props => super.props..addAll([merchId]);
}

final class _CartChangeQuantity extends CartEvent {
  const _CartChangeQuantity({required this.merchId});

  final String merchId;

  @override
  List<Object> get props => super.props..addAll([merchId]);
}

final class CartPlus extends _CartChangeQuantity {
  const CartPlus({required super.merchId});

  @override
  List<Object> get props => super.props..addAll([merchId]);
}

final class CartMinus extends _CartChangeQuantity {
  const CartMinus({required super.merchId});

  @override
  List<Object> get props => super.props..addAll([merchId]);
}

final class CartDelete extends CartEvent {
  const CartDelete({required this.merchId});

  final String merchId;

  @override
  List<Object> get props => super.props..addAll([merchId]);
}
