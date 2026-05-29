import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/network/order_service.dart';

class OrderController extends GetxController {
  final orders = [].obs;
  final isLoading = false.obs;
  final isPlacingOrder = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMyOrders();
  }

  Future<void> fetchMyOrders() async {
    try {
      isLoading.value = true;
      final result = await OrderService.getMyOrders();
      orders.value = result;
    } catch (e) {
      print('Fetch orders error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> placeOrder({
    required String street,
    required String city,
    required String state,
    required String zipCode,
    required String country,
    required String paymentMethod,
  }) async {
    try {
      isPlacingOrder.value = true;

      final result = await OrderService.createOrder(
        shippingAddress: {
          'street': street,
          'city': city,
          'state': state,
          'zipCode': zipCode,
          'country': country,
        },
        paymentMethod: paymentMethod,
      );

      if (result['success'] == true) {
        orders.insert(0, result['order']);
        Get.snackbar(
          'Order Placed',
          'Your order has been placed successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF53B175),
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Error',
          result['message'] ?? 'Failed to place order',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'Network error. Please try again.',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isPlacingOrder.value = false;
    }
  }
}