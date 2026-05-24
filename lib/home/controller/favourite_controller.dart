import 'package:get/get.dart';
import '../../data/models/product_model.dart';

class FavouriteController extends GetxController {
  var favouriteItems = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    addDemoFavourites();
  }

  void addDemoFavourites() {
    favouriteItems.clear(); // Clear existing to avoid duplicates
    favouriteItems.addAll([
      Product(
        name: 'Sprite Can',
        description: '325ml, Price',
        price: '1500',
        imagePath: 'assets/images/sprite can.png',
        unit: '325ml',
      ),
      Product(
        name: 'Diet Coke',
        description: '355ml, Price',
        price: '1990',
        imagePath: 'assets/images/diet coke.png',
        unit: '355ml',
      ),
      Product(
        name: 'Apple & Grape Juice',
        description: '2L, Price',
        price: '15500',
        imagePath: 'assets/images/tree-top-juice-apple-grape-64oz 1.png',
        unit: '2L',
      ),
      Product(
        name: 'Coca Cola Can',
        description: '325ml, Price',
        price: '4990',
        imagePath: 'assets/images/cococola can.png',
        unit: '325ml',
      ),
      Product(
        name: 'Pepsi Can',
        description: '330ml, Price',
        price: '4990',
        imagePath: 'assets/images/pepsi.png',
        unit: '330ml',
      ),
    ]);
  }

  void removeItem(int index) {
    favouriteItems.removeAt(index);
  }

  void toggleFavourite(Product product) {
    int index = favouriteItems.indexWhere((item) => item.name == product.name);
    if (index != -1) {
      favouriteItems.removeAt(index);
    } else {
      favouriteItems.add(product);
    }
  }

  bool isFavourite(Product product) {
    return favouriteItems.any((item) => item.name == product.name);
  }
}
