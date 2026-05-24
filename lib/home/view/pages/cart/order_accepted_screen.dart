import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../homescreen.dart';

class OrderAcceptedScreen extends StatelessWidget {
  const OrderAcceptedScreen({super.key});

  static const primaryColor = Color(0xFF53B175);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Success Illustration
              // Using a placeholder icon since I'm not sure which image is the success one
              // You can replace this with Image.asset('assets/images/your_success_image.png')
              const Icon(
                Icons.check_circle,
                size: 100,
                color: primaryColor,
              ),
              const SizedBox(height: 40),
              const Text(
                'Your Order has been\naccepted',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF181725),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Your items has been placcd and is on\nit’s way to being processed',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF7C7C7C),
                  height: 1.5,
                ),
              ),
              const Spacer(),
              // Track Order Button
              Material(
                color: primaryColor,
                borderRadius: BorderRadius.circular(19),
                child: InkWell(
                  onTap: () {
                    // Track order logic
                  },
                  borderRadius: BorderRadius.circular(19),
                  child: Container(
                    height: 67,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: const Text(
                      'Track Order',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Back to home button
              TextButton(
                onPressed: () {
                  Get.offAll(() => const Homescreen());
                },
                child: const Text(
                  'Back to home',
                  style: TextStyle(
                    color: Color(0xFF181725),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
