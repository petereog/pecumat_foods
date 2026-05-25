import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/search_controller.dart';
import '../../cart/controller/cart_controller.dart';
import '../../product_details/view/product_detail_screen.dart';
import '../../filter/view/filter_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductSearchController searchController = Get.put(ProductSearchController());
    final CartController cartController = Get.put(CartController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Get.back(),
        ),
        title: TextField(
          autofocus: true,
          onChanged: (value) => searchController.search(value),
          decoration: InputDecoration(
            hintText: 'Search Store',
            prefixIcon: const Icon(Icons.search, color: Colors.black),
            suffixIcon: IconButton(
              icon: const Icon(Icons.tune, color: Colors.black),
              onPressed: () => Get.to(() => const FilterScreen()),
            ),
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
      body: Obx(() => GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
        itemCount: searchController.searchResults.length,
        itemBuilder: (context, index) {
          final product = searchController.searchResults[index];
          return GestureDetector(
            onTap: () => Get.to(() => ProductDetailScreen(product: product)),
            child: Container(
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
                      child: Hero(
                        tag: 'search_${product.name}',
                        child: Image.asset(
                          product.imagePath,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    product.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF7C7C7C),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '₦${product.price}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          cartController.addItem(product);
                          Get.snackbar(
                            "Added",
                            "${product.name} added to cart",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: const Color(0xFF53B175),
                            colorText: Colors.white,
                            duration: const Duration(seconds: 1),
                          );
                        },
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
        },
      )),
    );
  }
}
