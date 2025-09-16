import 'package:merchok/features/cart/cart.dart';

class CartRepositoryImpl implements CartRepository {
  final Map<String, CartItem> cartItems = {};

  @override
  Future<List<CartItem>> getCartItems() async => cartItems.values.toList();

  @override
  Future<void> addCartItem(String merchId) async =>
      cartItems.addAll({merchId: CartItem(merchId: merchId, quantity: 1)});

  @override
  Future<void> plusCartItem(String merchId) async {
    final cartItem = cartItems[merchId]!;
    cartItems.addAll({
      merchId: cartItem.copyWith(quantity: cartItem.quantity + 1),
    });
  }

  @override
  Future<void> minusCartItem(String merchId) async {
    final cartItem = cartItems[merchId]!;
    if (cartItem.quantity == 0) return;
    if (cartItem.quantity == 1) {
      cartItems.remove(merchId);
      return;
    }
    cartItems.addAll({
      merchId: cartItem.copyWith(quantity: cartItem.quantity - 1),
    });
  }

  @override
  Future<void> deleteCartItem(String cartItemId) async =>
      cartItems.remove(cartItemId);

  @override
  Future<void> clearCartItems() async => cartItems.clear();
}
