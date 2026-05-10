import 'package:flutter/material.dart';
import 'package:gdg_campus_coffee/cart/domain/entity/cart_item.dart';
import 'package:gdg_campus_coffee/cart/domain/use_case/cart_service.dart';

class CartViewModel extends ChangeNotifier {
  final CartService _cartService = CartService();

  List<CartItem> get items => _cartService.items;
  int get itemCount => _cartService.itemCount;
  double get totalPrice => _cartService.totalPrice;

  void addItem(CartItem item) {
    _cartService.addItem(item);
    notifyListeners();
  }

  void removeItem(String itemId) {
    _cartService.removeItem(itemId);
    notifyListeners();
  }

  void updateQuantity(String itemId, int quantity) {
    _cartService.updateQuantity(itemId, quantity);
    notifyListeners();
  }

  void clearCart() {
    _cartService.clearCart();
    notifyListeners();
  }
}
