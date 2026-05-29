import 'package:get/get.dart';
import '../../../core/network/cart_service.dart';
import '../../../data/models/product_model.dart';
import '../model/cart_item_model.dart';

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;
  var isLoading = false.obs;
  var totalPrice = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCart();
  }

  Future<void> fetchCart() async {
    try {
      isLoading.value = true;
      final result = await CartService.getCart();
      if (result['success'] == true) {
        final items = result['cart']['items'] as List? ?? [];
        cartItems.value = items.map((item) {
          final product = item['product'];
          final images = product['images'] as List?;
          return CartItem(
            productId: product['_id'],
            product: Product(
              name: product['name'] ?? '',
              description: product['name'] ?? '',
              price: item['price'].toString(),
              imagePath: (images != null && images.isNotEmpty) ? images[0] : '',
              unit: '',
            ),
            quantity: item['quantity'],
          );
        }).toList();
        totalPrice.value = (result['cart']['totalPrice'] ?? 0).toDouble();
      }
    } catch (e) {
      print('Cart fetch error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addItem(Product product, {String? productId}) async {
    try {
      if (productId == null) {
        int index = cartItems.indexWhere((item) => item.product.name == product.name);
        if (index != -1) {
          cartItems[index].quantity++;
          cartItems.refresh();
        } else {
          cartItems.add(CartItem(product: product));
        }
        return;
      }
      final result = await CartService.addToCart(productId, 1);
      if (result['success'] == true) {
        await fetchCart();
      }
    } catch (e) {
      print('Add to cart error: $e');
    }
  }

  Future<void> removeItem(int index) async {
    try {
      final productId = cartItems[index].productId;
      if (productId != null) {
        await CartService.removeFromCart(productId);
        await fetchCart();
      } else {
        cartItems.removeAt(index);
      }
    } catch (e) {
      print('Remove from cart error: $e');
    }
  }

  Future<void> incrementQuantity(int index) async {
    cartItems[index].quantity++;
    cartItems.refresh();
    totalPrice.value = cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  Future<void> decrementQuantity(int index) async {
    if (cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
      cartItems.refresh();
      totalPrice.value = cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
    } else {
      await removeItem(index);
    }
  }

  double get subtotal {
    return cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  String get totalFormatted {
    final String formatted = subtotal.toStringAsFixed(2);
    final parts = formatted.split('.');
    final RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    parts[0] = parts[0].replaceAllMapped(reg, (Match m) => '${m[1]},');
    return "₦${parts.join('.')}";
  }
}