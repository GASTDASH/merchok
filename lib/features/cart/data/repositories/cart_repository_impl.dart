import 'package:merchok/features/cart/cart.dart';

class CartRepositoryImpl implements CartRepository {
  final Map<String, CartItem> cartItems = {};

  @override
  void addCartItem(String merchId) =>
      cartItems.addAll({merchId: CartItem(merchId: merchId, quantity: 1)});

  @override
  void clearCartItems() => cartItems.clear();

  @override
  void deleteCartItem(String cartItemId) => cartItems.remove(cartItemId);

  @override
  List<CartItem> getCartItems() => cartItems.values.toList();

  @override
  void minusCartItem(String merchId) {
    final cartItem = cartItems[merchId];
    if (cartItem == null) return;
    if (cartItem.quantity == 1) {
      cartItems.remove(merchId);
      return;
    }
    cartItems.addAll({
      merchId: cartItem.copyWith(quantity: cartItem.quantity - 1),
    });
  }

  @override
  void plusCartItem(String merchId) {
    final cartItem = cartItems[merchId]!;
    cartItems.addAll({
      merchId: cartItem.copyWith(quantity: cartItem.quantity + 1),
    });
  }
}
