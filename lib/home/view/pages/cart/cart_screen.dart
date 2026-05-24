import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/cart_controller.dart';
import '../../../model/cart_item_model.dart';
import 'order_accepted_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  static const primaryColor = Color(0xFF53B175);

  @override
  Widget build(BuildContext context) {
    final CartController controller = Get.put(CartController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        title: const Text(
          'My Cart',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.cartItems.isEmpty) {
          return _buildEmptyCart();
        }

        return Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: controller.cartItems.length,
                padding: const EdgeInsets.all(16),
                separatorBuilder: (context, index) => const Divider(height: 32, thickness: 1, color: Color(0xFFF2F3F2)),
                itemBuilder: (context, index) {
                  final item = controller.cartItems[index];
                  return _buildCartItem(item, index, controller);
                },
              ),
            ),
            _buildCheckoutButton(context, controller),
          ],
        );
      }),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 100, color: Colors.grey[300]),
          const SizedBox(height: 20),
          const Text(
            'Your cart is empty',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            'Add items to your cart to see them here',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(CartItem cartItem, int index, CartController controller) {
    return Row(
      children: [
        Image.asset(
          cartItem.product.imagePath,
          width: 70,
          height: 70,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 40, color: Colors.grey),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    cartItem.product.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => controller.removeItem(index),
                    child: const Icon(Icons.close, color: Color(0xFFB3B3B3), size: 20),
                  ),
                ],
              ),
              Text(
                cartItem.product.description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF7C7C7C),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildQuantityButton(
                    Icons.remove, 
                    onTap: () => controller.decrementQuantity(index),
                  ),
                  const SizedBox(width: 15),
                  Text(
                    '${cartItem.quantity}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(width: 15),
                  _buildQuantityButton(
                    Icons.add, 
                    color: primaryColor,
                    onTap: () => controller.incrementQuantity(index),
                  ),
                  const Spacer(),
                  Text(
                    '₦${(cartItem.totalPrice).toStringAsFixed(2).replaceAllMapped(RegExp(r"(\d{1,3})(?=(\d{3})+(?!\d))"), (Match m) => "${m[1]},")}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuantityButton(IconData icon, {Color? color, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color(0xFFE2E2E2)),
        ),
        child: Icon(icon, size: 20, color: color ?? const Color(0xFFB3B3B3)),
      ),
    );
  }

  Widget _buildCheckoutButton(BuildContext context, CartController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.05 * 255).toInt()),
            blurRadius: 15,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Material(
        color: primaryColor,
        borderRadius: BorderRadius.circular(19),
        child: InkWell(
          onTap: () => _showCheckoutBottomSheet(context, controller),
          borderRadius: BorderRadius.circular(19),
          child: SizedBox(
            height: 67,
            child: Stack(
              children: [
                const Center(
                  child: Text(
                    'Go to Checkout',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF489E67),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        controller.totalFormatted,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showCheckoutBottomSheet(BuildContext context, CartController controller) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Checkout',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const Divider(),
              _buildCheckoutRow('Delivery', 'Select Method'),
              _buildCheckoutRow('Payment', '', icon: Icons.payment),
              _buildCheckoutRow('Promo Code', 'Pick discount'),
              _buildCheckoutRow('Total Cost', controller.totalFormatted, isBold: true),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'By placing an order you agree to our\nTerms And Conditions',
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Color(0xFF7C7C7C), fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 25),
              Material(
                color: primaryColor,
                borderRadius: BorderRadius.circular(19),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Get.to(() => const OrderAcceptedScreen());
                  },
                  borderRadius: BorderRadius.circular(19),
                  child: Container(
                    height: 67,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: const Text(
                      'Place Order',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCheckoutRow(String title, String value, {IconData? icon, bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: Color(0xFF7C7C7C),
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          if (icon != null) ...[
            Icon(icon, size: 24, color: Colors.black),
            const SizedBox(width: 8),
          ],
          if (value.isNotEmpty)
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: isBold ? Colors.black : const Color(0xFF181725),
                fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
              ),
            ),
          const SizedBox(width: 10),
          const Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFF181725)),
        ],
      ),
    );
  }
}
