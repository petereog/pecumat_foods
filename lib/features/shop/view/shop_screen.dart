import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../cart/controller/cart_controller.dart';
import '../controller/product_controller.dart';
import '../../../data/models/product_model.dart';
import '../../product_details/view/product_detail_screen.dart';
import '../../explore/view/search_screen.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  static const primaryColor = Color(0xFF53B175);

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.put(CartController());
    final ProductController productController = Get.put(ProductController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Image.asset('assets/images/Group (2).png', height: 30),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/Vector (1).png', height: 18),
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
              GestureDetector(
                onTap: () => Get.to(() => const SearchScreen()),
                child: AbsorbPointer(
                  child: TextField(
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
                ),
              ),
              const SizedBox(height: 20),
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
              _buildSectionHeader('All Products', () {}),
              const SizedBox(height: 15),
              Obx(() {
                if (productController.isLoading.value) {
                  return const SizedBox(
                    height: 250,
                    child: Center(child: CircularProgressIndicator(color: primaryColor)),
                  );
                }
                if (productController.products.isEmpty) {
                  return const SizedBox(
                    height: 250,
                    child: Center(child: Text('No products found')),
                  );
                }
                return SizedBox(
                  height: 250,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: productController.products.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 15),
                    itemBuilder: (context, index) {
                      final product = productController.products[index];
                      return _buildApiProductCard(product, cartController);
                    },
                  ),
                );
              }),
              const SizedBox(height: 25),
              Obx(() {
                if (productController.categories.isEmpty) return const SizedBox();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader('Categories', () {}),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 105,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: productController.categories.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 15),
                        itemBuilder: (context, index) {
                          final category = productController.categories[index];
                          return GestureDetector(
                            onTap: () => productController.fetchProducts(category: category['name']),
                            child: _buildCategoryItem(
                              category['name'],
                              const Color(0xFF53B175).withAlpha(30),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildApiProductCard(dynamic product, CartController controller) {
    final images = product['images'] as List?;
    final hasImage = images != null && images.isNotEmpty;

    return GestureDetector(
      onTap: () {
        final p = Product(
          name: product['name'] ?? '',
          description: product['description'] ?? '',
          price: product['price'].toString(),
          imagePath: hasImage ? images[0] : '',
          unit: product['category'] ?? '',
        );
        Get.to(() => ProductDetailScreen(product: p));
      },
      child: Container(
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
                child: hasImage
                    ? CachedNetworkImage(
                  imageUrl: images[0],
                  fit: BoxFit.contain,
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                  const Icon(Icons.broken_image, size: 50, color: Colors.grey),
                )
                    : const Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              product['name'] ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              product['category'] ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '₦${product['price']}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                InkWell(
                  onTap: () {
                    final p = Product(
                      name: product['name'] ?? '',
                      description: product['description'] ?? '',
                      price: product['price'].toString(),
                      imagePath: hasImage ? images[0] : '',
                      unit: product['category'] ?? '',
                    );
                    controller.addItem(p);
                    Get.snackbar(
                      "Added to Cart",
                      "${product['name']} has been added.",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: const Color(0xFF53B175),
                      colorText: Colors.white,
                      duration: const Duration(seconds: 1),
                    );
                  },
                  borderRadius: BorderRadius.circular(17),
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      color: const Color(0xFF53B175),
                      borderRadius: BorderRadius.circular(17),
                    ),
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(String title, Color color) {
    return Container(
      width: 150,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF3E423F),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onSeeAll) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        TextButton(
          onPressed: onSeeAll,
          child: const Text(
            'See all',
            style: TextStyle(
              color: Color(0xFF53B175),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}