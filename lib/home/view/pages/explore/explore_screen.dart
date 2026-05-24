import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'category_products_screen.dart';
import '../../../../data/models/product_model.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {
        'title': 'Fresh Fruits\n& Vegetable',
        'image': 'assets/images/frash fruit.png',
        'color': const Color(0xFF53B175),
      },
      {
        'title': 'Cooking Oil\n& Ghee',
        'image': 'assets/images/cooking oil.png',
        'color': const Color(0xFFF8A44C),
      },
      {
        'title': 'Meat & Fish',
        'image': 'assets/images/fish and meat.png',
        'color': const Color(0xFFF7A593),
      },
      {
        'title': 'Bakery & Snacks',
        'image': 'assets/images/backery and snacks.png',
        'color': const Color(0xFFD3B0E0),
      },
      {
        'title': 'Dairy & Eggs',
        'image': 'assets/images/dairy and eggs.png',
        'color': const Color(0xFFFDE598),
      },
      {
        'title': 'Beverages',
        'image': 'assets/images/beverages.png',
        'color': const Color(0xFFB7DFF5),
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Find Products',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              // Search bar
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search Store',
                  prefixIcon: const Icon(Icons.search, color: Colors.black),
                  filled: true,
                  fillColor: const Color(0xFFF2F3F2),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.9,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return _buildCategoryCard(
                    context,
                    category['title'],
                    category['color'].withAlpha(30),
                    category['image'],
                    category['color'],
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, String title, Color bgColor, String imagePath, Color borderColor) {
    return GestureDetector(
      onTap: () {
        if (title.contains('Beverages')) {
          Get.to(() => CategoryProductsScreen(
            title: 'Beverages',
            products: [
              Product(name: 'Diet Coke', description: '355ml, Price', price: '1.99', imagePath: 'assets/images/diet coke.png', unit: '355ml'),
              Product(name: 'Sprite Can', description: '325ml, Price', price: '1.50', imagePath: 'assets/images/sprite can.png', unit: '325ml'),
              Product(name: 'Apple & Grape Juice', description: '2L, Price', price: '15.99', imagePath: 'assets/images/tree-top-juice-apple-grape-64oz 1.png', unit: '2L'),
              Product(name: 'Orange Juice', description: '2L, Price', price: '15.99', imagePath: 'assets/images/beverages.png', unit: '2L'),
              Product(name: 'Coca Cola Can', description: '325ml, Price', price: '4.99', imagePath: 'assets/images/cococola can.png', unit: '325ml'),
              Product(name: 'Pepsi Can', description: '330ml, Price', price: '4.99', imagePath: 'assets/images/pepsi.png', unit: '330ml'),
            ],
          ));
        } else if (title.contains('Dairy & Eggs')) {
          Get.to(() => CategoryProductsScreen(
            title: 'Egg',
            products: [
              Product(name: 'Egg Chicken Red', description: '4pcs, Price', price: '1.99', imagePath: 'assets/images/dairy and eggs.png', unit: '4pcs'),
              Product(name: 'Egg Chicken White', description: '180g, Price', price: '1.50', imagePath: 'assets/images/dairy and eggs.png', unit: '180g'),
              Product(name: 'Egg Pasta', description: '30gm, Price', price: '15.99', imagePath: 'assets/images/dairy and eggs.png', unit: '30gm'),
              Product(name: 'Egg Noodles', description: '2L, Price', price: '15.99', imagePath: 'assets/images/dairy and eggs.png', unit: '2L'),
              Product(name: 'Mayonnais Eggless', description: '325ml, Price', price: '4.99', imagePath: 'assets/images/dairy and eggs.png', unit: '325ml'),
              Product(name: 'Egg Noodles Spicy', description: '330ml, Price', price: '4.99', imagePath: 'assets/images/dairy and eggs.png', unit: '330ml'),
            ],
          ));
        }
      },
      child: Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor.withAlpha((0.7 * 255).toInt())),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, height: 80),
          const SizedBox(height: 15),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    ));
  }
}
