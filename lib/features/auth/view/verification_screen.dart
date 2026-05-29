import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../../../routes/app_pages.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  String otp = '';

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
            const SizedBox(height: 10),
            const Text(
              'Code',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Pinput(
              length: 4,
              defaultPinTheme: PinTheme(
                width: 60,
                height: 60,
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFE2E2E2)),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              focusedPinTheme: PinTheme(
                width: 60,
                height: 60,
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF53B175)),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) => otp = value,
              onCompleted: (pin) {
                Get.toNamed(Routes.SELECTLOCATION);
              },
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Get.snackbar(
                  'Code Sent',
                  'A new code has been sent',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: const Color(0xFF53B175),
                  colorText: Colors.white,
                );
              },
              child: const Text(
                'Resend Code',
                style: TextStyle(
                  color: Color(0xFF53B175),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () {
                  if (otp.length < 4) {
                    Get.snackbar(
                      'Error',
                      'Please enter the 4-digit code',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                    return;
                  }
                  Get.toNamed(Routes.SELECTLOCATION);
                },
                backgroundColor: const Color(0xFF53B175),
                child: const Icon(Icons.arrow_forward_ios, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}