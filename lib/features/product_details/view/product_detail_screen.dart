import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                    child: Hero(
                      tag: widget.product.name,
                      child: Image.asset(
                        widget.product.imagePath,
                        fit: BoxFit.contain,
                      ),
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
                            Text(
                              widget.product.name,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF181725),
                              ),
                            ),
                            Obx(() => IconButton(
                              icon: Icon(
                                favouriteController.isFavourite(widget.product)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: favouriteController.isFavourite(widget.product)
                                    ? Colors.red
                                    : Colors.grey,
                                size: 30,
                              ),
                              onPressed: () => favouriteController.toggleFavourite(widget.product),
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
                            _buildQuantityButton(Icons.add, () {
                              setState(() => quantity++);
                            }, color: const Color(0xFF53B175)),
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
                        _buildExpandableSection('Product Detail', widget.product.description),
                        const Divider(thickness: 1),
                        _buildExpandableSection('Nutritions', '100gr', trailing: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEBEBEB),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Text('100gr', style: TextStyle(fontSize: 12)),
                        )),
                        const Divider(thickness: 1),
                        _buildExpandableSection('Review', '⭐⭐⭐⭐⭐', trailing: Row(
                          children: List.generate(5, (index) => const Icon(Icons.star, color: Color(0xFFF3603F), size: 18)),
                        )),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildAddToBasketButton(),
        ],
      ),
    );
  }

  Widget _buildQuantityButton(IconData icon, VoidCallback onTap, {Color? color}) {
    return InkWell(
      onTap: onTap,
      child: Icon(icon, color: color ?? Colors.grey, size: 30),
    );
  }

  Widget _buildExpandableSection(String title, String content, {Widget? trailing}) {
    return ExpansionTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color(0xFF181725),
        ),
      ),
      trailing: trailing ?? const Icon(Icons.keyboard_arrow_right, color: Colors.black),
      tilePadding: EdgeInsets.zero,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF7C7C7C),
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddToBasketButton() {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Material(
        color: const Color(0xFF53B175),
        borderRadius: BorderRadius.circular(19),
        child: InkWell(
          onTap: () {
            for (int i = 0; i < quantity; i++) {
              cartController.addItem(widget.product);
            }
            Get.snackbar(
              "Success",
              "${widget.product.name} added to basket",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: const Color(0xFF53B175),
              colorText: Colors.white,
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
    );
  }
}
