import 'package:flutter/material.dart';

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

  Widget _buildCategoryCard(String title, Color bgColor, String imagePath, Color borderColor) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor.withOpacity(0.7)),
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
    );
  }
}
