import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../data/models/product_model.dart';
import '../../cart/controller/cart_controller.dart';
import '../../favourite/controller/favourite_controller.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;
  late final CartController cartController;
  late final FavouriteController favouriteController;

  @override
  void initState() {
    super.initState();
    cartController = Get.isRegistered<CartController>()
        ? Get.find<CartController>()
        : Get.put(CartController());
    favouriteController = Get.isRegistered<FavouriteController>()
        ? Get.find<FavouriteController>()
        : Get.put(FavouriteController());
  }

  bool get isNetworkImage =>
      widget.product.imagePath.startsWith('http');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F3F2),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 250,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF2F3F2),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(25),
                      ),
                    ),
                    child: isNetworkImage
                        ? CachedNetworkImage(
                      imageUrl: widget.product.imagePath,
                      fit: BoxFit.contain,
                      placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                      const Icon(Icons.broken_image, size: 80),
                    )
                        : Image.asset(
                      widget.product.imagePath,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 80),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                widget.product.name,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF181725),
                                ),
                              ),
                            ),
                            Obx(() => IconButton(
                              icon: Icon(
                                favouriteController
                                    .isFavourite(widget.product)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: favouriteController
                                    .isFavourite(widget.product)
                                    ? Colors.red
                                    : Colors.grey,
                                size: 30,
                              ),
                              onPressed: () =>
                                  favouriteController.toggleFavourite(
                                      widget.product, ''),
                            )),
                          ],
                        ),
                        Text(
                          widget.product.unit,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF7C7C7C),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            _buildQuantityButton(Icons.remove, () {
                              if (quantity > 1) setState(() => quantity--);
                            }),
                            const SizedBox(width: 20),
                            Text(
                              '$quantity',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 20),
                            _buildQuantityButton(
                              Icons.add,
                                  () => setState(() => quantity++),
                              color: const Color(0xFF53B175),
                            ),
                            const Spacer(),
                            Text(
                              '₦${widget.product.price}',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF181725),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        const Divider(thickness: 1),
                        _buildExpandableSection(
                            'Product Detail', widget.product.description),
                        const Divider(thickness: 1),
                        _buildExpandableSection('Nutritions', '100gr',
                            trailing: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEBEBEB),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Text('100gr',
                                  style: TextStyle(fontSize: 12)),
                            )),
                        const Divider(thickness: 1),
                        _buildExpandableSection('Review', '⭐ 5.0'),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Material(
              color: const Color(0xFF53B175),
              borderRadius: BorderRadius.circular(19),
              child: InkWell(
                onTap: () {
                  for (int i = 0; i < quantity; i++) {
                    cartController.addItem(widget.product);
                  }
                  Get.snackbar(
                    'Added to Cart',
                    '${widget.product.name} added to cart',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: const Color(0xFF53B175),
                    colorText: Colors.white,
                    duration: const Duration(seconds: 1),
                  );
                },
                borderRadius: BorderRadius.circular(19),
                child: Container(
                  height: 67,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: const Text(
                    'Add To Basket',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton(IconData icon, VoidCallback onTap,
      {Color color = const Color(0xFFE2E2E2)}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(17),
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(17),
          border: Border.all(color: const Color(0xFFE2E2E2)),
        ),
        child: Icon(icon, size: 20),
      ),
    );
  }

  Widget _buildExpandableSection(String title, String content,
      {Widget? trailing}) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color(0xFF181725),
        ),
      ),
      trailing: trailing ?? const Icon(Icons.keyboard_arrow_down),
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF7C7C7C),
            ),
          ),
        ),
      ],
    );
  }
}