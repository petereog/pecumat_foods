import '../../data/models/product_model.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });

  double get totalPrice {
    // Extract numbers from price string like "₦4,900" or "4.99"
    String priceString = product.price.replaceAll(RegExp(r'[^0-9.]'), '');
    double price = double.tryParse(priceString) ?? 0.0;
    return price * quantity;
  }
}
