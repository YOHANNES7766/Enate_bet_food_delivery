import 'package:enate_bet_food_delivery/models/category.dart';

class CategoriesService {
  Future<List<Category>> getCategories() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Category(name: 'Chicken', icon: 'assets/icons/chicken.png'),
      Category(name: 'Curry', icon: 'assets/icons/curry.png'),
      Category(name: 'Pizza', icon: 'assets/icons/pizza.png'),
      Category(name: 'Burgers', icon: 'assets/icons/burger.png'),
      Category(name: 'Pasta', icon: 'assets/icons/pasta.png'),
      Category(name: 'Beverages', icon: 'assets/icons/beverages.png'),
      Category(name: 'Fried Rice', icon: 'assets/icons/fried_rice.png'),
    ];
  }

  Future<List<Category>> getPopularCategories() async {
    await Future.delayed(const Duration(seconds: 1));
    // Select a few popular ones (you can adjust the logic or make it dynamic later)
    return [
      Category(name: 'Pizza', icon: 'assets/icons/pizza.png'),
      Category(name: 'Burgers', icon: 'assets/icons/burger.png'),
      Category(name: 'Fried Rice', icon: 'assets/icons/fried_rice.png'),
    ];
  }
}
