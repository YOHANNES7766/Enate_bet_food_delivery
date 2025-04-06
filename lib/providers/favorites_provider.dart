import 'package:flutter/foundation.dart';

class FavoritesProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _favoriteItems = [];

  List<Map<String, dynamic>> get favoriteItems => _favoriteItems;

  bool isFavorite(Map<String, dynamic> item) {
    return _favoriteItems.any((favItem) => favItem['title'] == item['title']);
  }

  void toggleFavorite(Map<String, dynamic> item) {
    if (isFavorite(item)) {
      _favoriteItems
          .removeWhere((favItem) => favItem['title'] == item['title']);
    } else {
      _favoriteItems.add(item);
    }
    notifyListeners();
  }
}
