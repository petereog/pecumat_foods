import 'package:get/get.dart';

class FilterController extends GetxController {
  var categories = {
    'Eggs': false,
    'Noodles & Pasta': false,
    'Chips & Crisps': false,
    'Fast Food': false,
  }.obs;

  var brands = {
    'Individual Collection': false,
    'Cocola': false,
    'Ifad': false,
    'Kazi Farmas': false,
  }.obs;

  void toggleCategory(String key) {
    categories[key] = !categories[key]!;
    categories.refresh();
  }

  void toggleBrand(String key) {
    brands[key] = !brands[key]!;
    brands.refresh();
  }

  void applyFilters() {
    Get.back();
  }
}
