import 'package:flutter/material.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  static const primaryColor = Color(0xFF53B175);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Image.asset(
          'assets/images/Group (2).png',
          height: 30,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              // Location Selector
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/Vector (1).png',
                      height: 18,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Obawole, Ifako ijaiye',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4C4F4D),
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down, size: 20),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Search Bar
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
              // Promo Banner
              Container(
                width: double.infinity,
                height: 115,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/banner.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              // Exclusive Offer Section
              _buildSectionHeader('Exclusive Offer', () {}),
              const SizedBox(height: 15),
              SizedBox(
                height: 250,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildProductCard('Organic Bananas', '7pcs, Price', '₦4,900', 'assets/images/banna.png'),
                    const SizedBox(width: 15),
                    _buildProductCard('Red Apple', '1kg, Price', '₦4,900', 'assets/images/red apple.png'),
                    const SizedBox(width: 15),
                    _buildProductCard('Ginger', '250g, Price', '₦2,900', 'assets/images/ginger.png'),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              _buildSectionHeader('Best Selling', () {}),
              const SizedBox(height: 15),
              SizedBox(
                height: 250,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildProductCard('Beef Bone', '1kg, Price', '₦4,900', 'assets/images/beefbone.png'),
                    const SizedBox(width: 15),
                    _buildProductCard('Broiler Chicken', '1kg, Price', '₦4,900', 'assets/images/broiler.png'),
                    const SizedBox(width: 15),
                    _buildProductCard('Red Pepper', '1kg, Price', '₦4,900', 'assets/images/pepper.png'),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              _buildSectionHeader('Groceries', () {}),
              const SizedBox(height: 15),
              SizedBox(
                height: 105,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildCategoryItem('Pulses', const Color(0xFFF8A44C).withAlpha(30), 'assets/images/8-82858_download-sack-of-rice-png 1.png'),
                    const SizedBox(width: 15),
                    _buildCategoryItem('Rice', const Color(0xFF53B175).withAlpha(30), 'assets/images/rice.png'),
                    const SizedBox(width: 15),
                    _buildCategoryItem('Pulses', const Color(0xFFF8A44C).withAlpha(30), 'assets/images/8-82858_download-sack-of-rice-png 1.png'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryItem(String title, Color color, String imagePath) {
    return Container(
      width: 250,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Image.asset(
            imagePath,
            width: 70,
            height: 70,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.broken_image, size: 40, color: Colors.grey);
            },
          ),
          const SizedBox(width: 15),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF3E423F),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onSeeAll) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        TextButton(
          onPressed: onSeeAll,
          child: const Text(
            'See all',
            style: TextStyle(
              color: primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard(String name, String weight, String price, String imagePath) {
    return Container(
      width: 173,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E2E2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.broken_image, size: 50, color: Colors.grey);
                },
              ),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            weight,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                price,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(17),
                ),
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
