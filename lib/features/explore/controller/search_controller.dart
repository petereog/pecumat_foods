import 'package:get/get.dart';
import '../../../data/models/product_model.dart';

class ProductSearchController extends GetxController {
  var allProducts = <Product>[].obs;
  var searchResults = <Product>[].obs;
  var searchText = "".obs;

  @override
  void onInit() {
    super.onInit();
    _loadAllProducts();
  }

  void _loadAllProducts() {
    allProducts.addAll([
      Product(name: 'Organic Bananas', description: '7pcs, Price', price: '4.99', imagePath: 'assets/images/banna.png', unit: '7pcs'),
      Product(name: 'Red Apple', description: '1kg, Price', price: '4.99', imagePath: 'assets/images/red apple.png', unit: '1kg'),
      Product(name: 'Ginger', description: '250g, Price', price: '2.99', imagePath: 'assets/images/ginger.png', unit: '250g'),
      Product(name: 'Beef Bone', description: '1kg, Price', price: '4.99', imagePath: 'assets/images/beefbone.png', unit: '1kg'),
      Product(name: 'Broiler Chicken', description: '1kg, Price', price: '4.99', imagePath: 'assets/images/broiler.png', unit: '1kg'),
      Product(name: 'Red Pepper', description: '1kg, Price', price: '4.99', imagePath: 'assets/images/pepper.png', unit: '1kg'),
      Product(name: 'Diet Coke', description: '355ml, Price', price: '1.99', imagePath: 'assets/images/diet coke.png', unit: '355ml'),
      Product(name: 'Sprite Can', description: '325ml, Price', price: '1.50', imagePath: 'assets/images/sprite can.png', unit: '325ml'),
      Product(name: 'Apple & Grape Juice', description: '2L, Price', price: '15.99', imagePath: 'assets/images/tree-top-juice-apple-grape-64oz 1.png', unit: '2L'),
      Product(name: 'Orange Juice', description: '2L, Price', price: '15.99', imagePath: 'assets/images/beverages.png', unit: '2L'),
      Product(name: 'Coca Cola Can', description: '325ml, Price', price: '4.99', imagePath: 'assets/images/cococola can.png', unit: '325ml'),
      Product(name: 'Pepsi Can', description: '330ml, Price', price: '4.99', imagePath: 'assets/images/pepsi.png', unit: '330ml'),
      Product(name: 'Egg Chicken Red', description: '4pcs, Price', price: '1.99', imagePath: 'assets/images/dairy and eggs.png', unit: '4pcs'),
      Product(name: 'Egg Chicken White', description: '180g, Price', price: '1.50', imagePath: 'assets/images/dairy and eggs.png', unit: '180g'),
      Product(name: 'Egg Pasta', description: '30gm, Price', price: '15.99', imagePath: 'assets/images/dairy and eggs.png', unit: '30gm'),
      Product(name: 'Egg Noodles', description: '2L, Price', price: '15.99', imagePath: 'assets/images/dairy and eggs.png', unit: '2L'),
    ]);
    searchResults.assignAll(allProducts);
  }

  void search(String query) {
    searchText.value = query;
    if (query.isEmpty) {
      searchResults.assignAll(allProducts);
    } else {
      searchResults.assignAll(allProducts.where((p) => 
        p.name.toLowerCase().contains(query.toLowerCase()) || 
        p.description.toLowerCase().contains(query.toLowerCase())
      ).toList());
    }
  }
}
