import 'package:merchok/features/cart/cart.dart';

abstract interface class CartRepository {
  List<CartItem> getCartItems();
  void addCartItem(String merchId);
  void plusCartItem(String merchId);
  void minusCartItem(String merchId);
  void deleteCartItem(String cartItemId);
  void clearCartItems();
}
