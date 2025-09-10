part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}

final class CartLoaded extends CartState {
  const CartLoaded({required this.cartItems});

  final List<CartItem> cartItems;

  @override
  List<Object> get props => super.props..addAll([cartItems]);
}

final class CartLoading extends CartState {
  const CartLoading({this.message});

  final String? message;

  @override
  List<Object> get props => super.props..addAll([message ?? '']);
}

final class CartError extends CartState {
  const CartError({required this.error});

  final Object error;

  @override
  List<Object> get props => super.props..addAll([error]);
}
