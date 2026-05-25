import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../../../routes/app_pages.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter your 4-digit code',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Code',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Pinput(
              length: 4,
              onCompleted: (pin) => Get.toNamed(Routes.SELECTLOCATION),
            ),
            const Spacer(),
            Row(
              children: [
                const Text(
                  'Resend Code',
                  style: TextStyle(
                    color: Color(0xFF53B175),
                    fontSize: 18,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () => Get.toNamed(Routes.SELECTLOCATION),
                  backgroundColor: const Color(0xFF53B175),
                  child: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
