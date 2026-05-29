import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/product_model.dart';
import '../../../core/network/product_service.dart';

class FavouriteController extends GetxController {
  var favouriteItems = <Product>[].obs;
  var favouriteIds = <String>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchFavourites();
  }

  Future<void> fetchFavourites() async {
    try {
      isLoading.value = true;
      final result = await ProductService.getFavourites();
      favouriteItems.value = result.map((item) {
        final images = item['images'] as List?;
        return Product(
          name: item['name'] ?? '',
          description: item['category'] ?? '',
          price: item['price'].toString(),
          imagePath: (images != null && images.isNotEmpty) ? images[0] : '',
          unit: item['category'] ?? '',
        );
      }).toList();
      favouriteIds.value = result.map<String>((item) => item['_id'].toString()).toList();
    } catch (e) {
      print('Fetch favourites error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> toggleFavourite(Product product, String productId) async {
    try {
      if (isFavouriteById(productId)) {
        favouriteIds.remove(productId);
        favouriteItems.removeWhere((item) => item.name == product.name);
      } else {
        final result = await ProductService.addToFavourites(productId);
        if (result['success'] == true) {
          favouriteIds.add(productId);
          favouriteItems.add(product);
          Get.snackbar(
            'Added to Favourites',
            '${product.name} added to favourites',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color(0xFF53B175),
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      print('Toggle favourite error: $e');
    }
  }

  bool isFavouriteById(String productId) {
    return favouriteIds.contains(productId);
  }

  bool isFavourite(Product product) {
    return favouriteItems.any((item) => item.name == product.name);
  }

  void removeItem(int index) {
    favouriteItems.removeAt(index);
  }
}