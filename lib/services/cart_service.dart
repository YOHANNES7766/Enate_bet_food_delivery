import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';

class CartService extends ChangeNotifier {
  final List<CartItem> _items = [];
  static const double _deliveryFee = 40.0;
  static const double _taxRate = 0.18; // 18% tax

  List<CartItem> get items => _items;

  double get subtotal => _items.fold(0, (sum, item) => sum + item.totalPrice);

  double get tax => subtotal * _taxRate;

  double get deliveryFee => _deliveryFee;

  double get total => subtotal + tax + deliveryFee;

  void addItem(CartItem item) {
    final existingIndex = _items.indexWhere((i) => i.name == item.name);
    if (existingIndex >= 0) {
      _items[existingIndex].quantity += item.quantity;
    } else {
      _items.add(item);
    }
    notifyListeners();
  }

  void updateQuantity(int index, int quantity) {
    if (index >= 0 && index < _items.length) {
      if (quantity > 0) {
        _items[index].quantity = quantity;
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  void removeItem(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  double getSubtotal() {
    return _items.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }
}
