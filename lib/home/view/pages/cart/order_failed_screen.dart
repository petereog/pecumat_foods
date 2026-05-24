import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../homescreen.dart';

class OrderFailedScreen extends StatelessWidget {
  const OrderFailedScreen({super.key});

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
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.black),
                ),
              ),
              const Spacer(),
              // Error Illustration
              // Using an error icon or Image if available
              const Icon(
                Icons.error_outline,
                size: 100,
                color: Colors.redAccent,
              ),
              const SizedBox(height: 40),
              const Text(
                'Oops! Order Failed',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF181725),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Something went tembly wrong.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF7C7C7C),
                  height: 1.5,
                ),
              ),
              const Spacer(),
              // Please Try Again Button
              Material(
                color: primaryColor,
                borderRadius: BorderRadius.circular(19),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  borderRadius: BorderRadius.circular(19),
                  child: Container(
                    height: 67,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: const Text(
                      'Please Try Again',
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
