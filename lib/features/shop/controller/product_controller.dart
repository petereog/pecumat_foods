import 'package:get/get.dart';
import '../../../core/network/product_service.dart';

class ProductController extends GetxController {
  final products = [].obs;
  final categories = [].obs;
  final isLoading = false.obs;
  final searchResults = [].obs;
  final isSearching = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
    fetchCategories();
  }

  Future<void> fetchProducts({String? category, String? search}) async {
    try {
      isLoading.value = true;
      final result = await ProductService.getProducts(
        category: category,
        search: search,
      );
      products.value = result;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load products',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCategories() async {
    try {
      final result = await ProductService.getCategories();
      categories.value = result;
    } catch (e) {
      print('Failed to load categories: $e');
    }
  }

  Future<void> searchProducts(String query) async {
    try {
      isSearching.value = true;
      final result = await ProductService.getProducts(search: query);
      searchResults.value = result;
    } catch (e) {
      Get.snackbar('Error', 'Search failed',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isSearching.value = false;
    }
  }
}