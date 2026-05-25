import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/favourite_controller.dart';
import '../../cart/controller/cart_controller.dart';
import '../../../data/models/product_model.dart';
import '../../product_details/view/product_detail_screen.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  static const primaryColor = Color(0xFF53B175);

  @override
  Widget build(BuildContext context) {
    final FavouriteController favouriteController = Get.put(FavouriteController());
    final CartController cartController = Get.put(CartController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        title: const Text(
          'Favourite',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Obx(() {
        if (favouriteController.favouriteItems.isEmpty) {
          return _buildEmptyState();
        }

        return Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: favouriteController.favouriteItems.length,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                separatorBuilder: (context, index) => const Divider(height: 32, thickness: 1, color: Color(0xFFF2F3F2)),
                itemBuilder: (context, index) {
                  final item = favouriteController.favouriteItems[index];
                  return _buildFavouriteItem(item, favouriteController, cartController);
                },
              ),
            ),
            _buildAddAllButton(favouriteController, cartController),
          ],
        );
      }),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 100, color: Colors.grey[300]),
          const SizedBox(height: 20),
          const Text(
            'No Favorites yet',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            'Explore products and mark them as favorites!',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildFavouriteItem(Product product, FavouriteController favController, CartController cartController) {
    String priceString = product.price.replaceAll(RegExp(r'[^0-9.]'), '');
    double price = double.tryParse(priceString) ?? 0.0;
    final String formattedPrice = price.toStringAsFixed(2).replaceAllMapped(
      RegExp(r"(\d{1,3})(?=(\d{3})+(?!\d))"), 
      (Match m) => "${m[1]},"
    );

    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailScreen(product: product)),
      child: Row(
        children: [
          Hero(
            tag: product.name,
            child: SizedBox(
              width: 60,
              height: 60,
              child: Image.asset(
                product.imagePath,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 30, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF181725),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  product.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF7C7C7C),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                '₦$formattedPrice',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF181725),
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                icon: const Icon(Icons.add_shopping_cart, color: primaryColor, size: 24),
                onPressed: () {
                  cartController.addItem(product);
                  Get.snackbar(
                    "Added to Cart",
                    "${product.name} added.",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: primaryColor,
                    colorText: Colors.white,
                    duration: const Duration(seconds: 1),
                  );
                },
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF181725)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddAllButton(FavouriteController favouriteController, CartController cartController) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Material(
        color: primaryColor,
        borderRadius: BorderRadius.circular(19),
        child: InkWell(
          onTap: () {
            for (var item in favouriteController.favouriteItems) {
              cartController.addItem(item);
            }
            Get.snackbar(
              "Success", 
              "All favorites added to cart!",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: primaryColor,
              colorText: Colors.white,
              duration: const Duration(seconds: 2),
            );
          },
          borderRadius: BorderRadius.circular(19),
          child: Container(
            height: 67,
            width: double.infinity,
            alignment: Alignment.center,
            child: const Text(
              'Add All To Cart',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
