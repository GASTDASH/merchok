import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchok/features/cart/cart.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository _cartRepository;

  CartBloc({required CartRepository cartRepository})
    : _cartRepository = cartRepository,
      super(CartInitial()) {
    on<CartLoad>((event, emit) {
      try {
        // emit(CartLoading(message: S.current.cartLoading));
        final cartItems = _cartRepository.getCartItems();
        emit(CartLoaded(cartItems: cartItems));
      } catch (e) {
        emit(CartError(error: e));
      }
    });
    on<CartAdd>((event, emit) {
      try {
        // emit(CartLoading(message: S.current.addingToCart));
        _cartRepository.addCartItem(event.merchId);
        add(CartLoad());
      } catch (e) {
        emit(CartError(error: e));
      }
    });
    on<CartPlus>((event, emit) {
      try {
        _cartRepository.plusCartItem(event.merchId);
        add(CartLoad());
      } catch (e) {
        emit(CartError(error: e));
      }
    });
    on<CartMinus>((event, emit) {
      try {
        _cartRepository.minusCartItem(event.merchId);
        add(CartLoad());
      } catch (e) {
        emit(CartError(error: e));
      }
    });
    on<CartDelete>((event, emit) {
      try {
        _cartRepository.deleteCartItem(event.merchId);
        add(CartLoad());
      } catch (e) {
        emit(CartError(error: e));
      }
    });
    on<CartClear>((event, emit) {
      try {
        _cartRepository.clearCartItems();
        add(CartLoad());
      } catch (e) {
        emit(CartError(error: e));
      }
    });
  }
}
