import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/theme_provider.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';
import 'orders_screen.dart';
import 'favorites_screen.dart';
import 'delivery_address_screen.dart';
import 'payment_methods_screen.dart';
import 'notifications_screen.dart';
import 'help_support_screen.dart';
import 'settings_screen.dart';
import '../providers/favorites_provider.dart';
import 'categories_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  MenuScreenState createState() => MenuScreenState();
}

class MenuScreenState extends State<MenuScreen>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> _categories = [
    {
      "name": "Pizza",
      "icon": Icons.local_pizza,
      "items": [
        {
          "title": "Margherita Pizza",
          "description": "Classic tomato and mozzarella",
          "price": "₹299",
          "imageUrl": "assets/images/cheese_pizza.jpg",
        },
        {
          "title": "Pepperoni Pizza",
          "description": "Spicy pepperoni with cheese",
          "price": "₹399",
          "imageUrl": "assets/images/pepperoni_pizza.jpg",
        },
      ],
    },
    {
      "name": "Burgers",
      "icon": Icons.lunch_dining,
      "items": [
        {
          "title": "Chicken Burger",
          "description": "Juicy chicken patty with fresh veggies",
          "price": "₹199",
          "imageUrl": "assets/images/fried_chicken.jpg",
        },
        {
          "title": "Cheese Burger",
          "description": "Classic beef with extra cheese",
          "price": "₹249",
          "imageUrl": "assets/images/cheese_burger.jpg",
        },
      ],
    },
    {
      "name": "Salads",
      "icon": Icons.eco,
      "items": [
        {
          "title": "Caesar Salad",
          "description": "Fresh romaine lettuce with caesar dressing",
          "price": "₹249",
          "imageUrl": "assets/images/chicken_caesar_salad.jpg",
        },
        {
          "title": "Greek Salad",
          "description": "Mediterranean style with feta cheese",
          "price": "₹299",
          "imageUrl": "assets/images/greek_salad.jpg",
        },
      ],
    },
  ];

  String _selectedCategory = "Pizza";
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _showAddedToCartSnackbar(BuildContext context, String itemName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$itemName added to cart'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'View Cart',
          textColor: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartScreen()),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Text(
          'Menu',
          style: TextStyle(
            fontSize: isPortrait ? size.width * 0.06 : size.width * 0.03,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  );
                },
              ),
              if (cart.itemCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: BoxConstraints(
                      minWidth: size.width * 0.05,
                      minHeight: size.width * 0.05,
                    ),
                    child: Text(
                      cart.itemCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.orange,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    const CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Jo',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Set Emoji Status',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              ListTile(
                leading: const Icon(Icons.person_outline, color: Colors.orange),
                title: Text('My Profile',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge?.color)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileScreen()),
                  );
                },
              ),
              ListTile(
                leading:
                    const Icon(Icons.category_outlined, color: Colors.orange),
                title: Text('Categories',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge?.color)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CategoriesScreen()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.shopping_bag_outlined,
                    color: Colors.orange),
                title: Text('My Orders',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge?.color)),
                trailing: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    '2',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OrdersScreen()),
                  );
                },
              ),
              ListTile(
                leading:
                    const Icon(Icons.favorite_border, color: Colors.orange),
                title: Text('Favorites',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge?.color)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FavoritesScreen()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.location_on_outlined,
                    color: Colors.orange),
                title: Text('Delivery Addresses',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge?.color)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DeliveryAddressScreen()),
                  );
                },
              ),
              ListTile(
                leading:
                    const Icon(Icons.payment_outlined, color: Colors.orange),
                title: Text('Payment Methods',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge?.color)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PaymentMethodsScreen()),
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.notifications_outlined,
                    color: Colors.orange),
                title: Text('Notifications',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge?.color)),
                trailing: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    '3',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationsScreen()),
                  );
                },
              ),
              ListTile(
                leading:
                    const Icon(Icons.settings_outlined, color: Colors.orange),
                title: Text('Settings',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge?.color)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsScreen()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.help_outline, color: Colors.orange),
                title: Text('Help & Support',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge?.color)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HelpSupportScreen()),
                  );
                },
              ),
              ListTile(
                leading:
                    const Icon(Icons.nightlight_outlined, color: Colors.orange),
                title: Text('Night Mode',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge?.color)),
                trailing: Consumer<ThemeProvider>(
                  builder: (context, themeProvider, child) {
                    return Switch(
                      value: themeProvider.isDarkMode,
                      onChanged: (value) {
                        themeProvider.toggleTheme();
                      },
                      activeColor: Colors.orange,
                    );
                  },
                ),
                onTap: () {
                  final themeProvider =
                      Provider.of<ThemeProvider>(context, listen: false);
                  themeProvider.toggleTheme();
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title:
                    const Text('Logout', style: TextStyle(color: Colors.red)),
                onTap: () {
                  // Show logout confirmation dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Logout'),
                        content: const Text('Are you sure you want to logout?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Close dialog
                              Navigator.pop(context); // Close drawer
                              // Add logout logic here
                            },
                            child: const Text('Logout',
                                style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = category["name"] == _selectedCategory;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategory = category["name"];
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.orange : Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          category["icon"],
                          color: isSelected ? Colors.white : Colors.grey[700],
                        ),
                        const SizedBox(width: 8),
                        Text(
                          category["name"],
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _categories
                  .firstWhere(
                      (cat) => cat["name"] == _selectedCategory)["items"]
                  .length,
              itemBuilder: (context, index) {
                final category = _categories
                    .firstWhere((cat) => cat["name"] == _selectedCategory);
                final item = category["items"][index];
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: Card(
                    margin: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          item["imageUrl"],
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 200,
                              width: double.infinity,
                              color: Colors.orange.shade100,
                              child: Icon(
                                Icons.restaurant,
                                size: 80,
                                color: Colors.orange.shade300,
                              ),
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item["title"],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                item["description"],
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item["price"],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Consumer<FavoritesProvider>(
                                        builder: (context, favoritesProvider,
                                            child) {
                                          final isFavorite = favoritesProvider
                                              .isFavorite(item);
                                          return IconButton(
                                            icon: Icon(
                                              isFavorite
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: Colors.red,
                                            ),
                                            onPressed: () {
                                              favoritesProvider
                                                  .toggleFavorite(item);
                                            },
                                          );
                                        },
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          cart.addItem(item);
                                          _showAddedToCartSnackbar(
                                              context, item["title"]);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.orange,
                                        ),
                                        child: const Text('Add to Cart'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
