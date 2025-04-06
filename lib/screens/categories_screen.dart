import 'package:flutter/material.dart';
import 'package:enate_bet_food_delivery/models/category.dart';
import 'package:enate_bet_food_delivery/services/categories_service.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({super.key});

  final CategoriesService _categoriesService = CategoriesService();

  Future<Map<String, List<Category>>> _loadAllCategoryData() async {
    final results = await Future.wait([
      _categoriesService.getCategories(),
      _categoriesService.getPopularCategories(),
      _categoriesService.getRecommendedCategories(),
    ]);

    final allCategories = results[0];
    final popularCategories = results[1];
    final recommendedCategories = results[2];

    return {
      'all': allCategories,
      'popular': popularCategories,
      'recommended': recommendedCategories,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Categories',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: FutureBuilder<Map<String, List<Category>>>(
        future: _loadAllCategoryData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final allCategories = snapshot.data?['all'] ?? [];
          final popularCategories = snapshot.data?['popular'] ?? [];
          final recommendedCategories = snapshot.data?['recommended'] ?? [];

          if (allCategories.isEmpty &&
              popularCategories.isEmpty &&
              recommendedCategories.isEmpty) {
            return const Center(child: Text('No categories available'));
          }

          return ListView(
            children: [
              if (recommendedCategories.isNotEmpty) ...[
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Recommended Categories',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                ...recommendedCategories
                    .map((category) => _buildCategoryTile(context, category)),
              ],
              if (popularCategories.isNotEmpty) ...[
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Popular Categories',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                ...popularCategories
                    .map((category) => _buildCategoryTile(context, category)),
              ],
              if (allCategories.isNotEmpty) ...[
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'All Categories',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                ...allCategories
                    .map((category) => _buildCategoryTile(context, category)),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _buildCategoryTile(BuildContext context, Category category) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey[200],
        child: Image.asset(
          category.icon,
          width: 24,
          height: 24,
          errorBuilder: (context, error, stackTrace) {
            return Icon(
              Icons.restaurant,
              color: Colors.grey[600],
            );
          },
        ),
      ),
      title: Text(
        category.name,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: () {
        Navigator.pop(context, category.name);
      },
    );
  }
}
