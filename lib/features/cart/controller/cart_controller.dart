import 'package:get/get.dart';
import '../model/cart_item_model.dart';
import '../../../data/models/product_model.dart';

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    addDemoItems();
  }

  void addDemoItems() {
    cartItems.clear();
    cartItems.addAll([
      CartItem(
        product: Product(
          name: 'Bell Pepper Red',
          description: '1kg, Price',
          price: '4.99',
          imagePath: 'assets/images/pepper.png',
          unit: '1kg',
        ),
      ),
      CartItem(
        product: Product(
          name: 'Egg Chicken Red',
          description: '4pcs, Price',
          price: '1.99',
          imagePath: 'assets/images/dairy and eggs.png',
          unit: '4pcs',
        ),
      ),
      CartItem(
        product: Product(
          name: 'Organic Bananas',
          description: '12kg, Price',
          price: '3.00',
          imagePath: 'assets/images/banna.png',
          unit: '12kg',
        ),
      ),
      CartItem(
        product: Product(
          name: 'Ginger',
          description: '250gm, Price',
          price: '2.99',
          imagePath: 'assets/images/ginger.png',
          unit: '250gm',
        ),
      ),
    ]);
  }

  void addItem(Product product) {
    int index = cartItems.indexWhere((item) => item.product.name == product.name);
    if (index != -1) {
      cartItems[index].quantity++;
      cartItems.refresh();
    } else {
      cartItems.add(CartItem(product: product));
    }
  }

  void removeItem(int index) {
    cartItems.removeAt(index);
  }

  void incrementQuantity(int index) {
    cartItems[index].quantity++;
    cartItems.refresh();
  }

  void decrementQuantity(int index) {
    if (cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
      cartItems.refresh();
    } else {
      removeItem(index);
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
