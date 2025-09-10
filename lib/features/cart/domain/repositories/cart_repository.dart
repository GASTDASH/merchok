import 'package:merchok/features/cart/cart.dart';

abstract interface class CartRepository {
  Future<List<CartItem>> getCartItems();
  Future<void> addCartItem(String merchId);
  Future<void> plusCartItem(String merchId);
  Future<void> minusCartItem(String merchId);
  Future<void> deleteCartItem(String cartItemId);
}
