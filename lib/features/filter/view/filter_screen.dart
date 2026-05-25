import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/filter_controller.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  static const primaryColor = Color(0xFF53B175);

  @override
  Widget build(BuildContext context) {
    final FilterController controller = Get.put(FilterController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Filters',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFFF2F3F2),
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF181725),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Obx(() => Column(
                      children: controller.categories.keys.map((String key) {
                        return _buildFilterItem(
                          key,
                          controller.categories[key]!,
                          () => controller.toggleCategory(key),
                        );
                      }).toList(),
                    )),
                    const SizedBox(height: 30),
                    const Text(
                      'Brand',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF181725),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Obx(() => Column(
                      children: controller.brands.keys.map((String key) {
                        return _buildFilterItem(
                          key,
                          controller.brands[key]!,
                          () => controller.toggleBrand(key),
                        );
                      }).toList(),
                    )),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Material(
                color: primaryColor,
                borderRadius: BorderRadius.circular(19),
                child: InkWell(
                  onTap: () => controller.applyFilters(),
                  borderRadius: BorderRadius.circular(19),
                  child: Container(
                    height: 67,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: const Text(
                      'Apply Filter',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterItem(String title, bool isSelected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isSelected ? primaryColor : const Color(0xFFC2C2C2),
                  width: 2,
                ),
                color: isSelected ? primaryColor : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                  : null,
            ),
            const SizedBox(width: 15),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isSelected ? primaryColor : const Color(0xFF181725),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
