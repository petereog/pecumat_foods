import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../otp_controller.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OtpController otpController = Get.find<OtpController>();

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
            Obx(() => Text(
              'Code sent to ${otpController.email.value}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            )),
            const SizedBox(height: 30),
            const Text(
              'Code',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 10),
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
              onCompleted: (pin) => otpController.verifyOtp(pin),
            ),
            const SizedBox(height: 20),
            Obx(() {
              if (otpController.errorMessage.value.isNotEmpty) {
                return Text(
                  otpController.errorMessage.value,
                  style: const TextStyle(color: Colors.red, fontSize: 14),
                );
              }
              return const SizedBox();
            }),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => otpController.resendOtp(),
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
            Obx(() => Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: otpController.isLoading.value ? null : null,
                backgroundColor: const Color(0xFF53B175),
                child: otpController.isLoading.value
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Icon(Icons.arrow_forward_ios, color: Colors.white),
              ),
            )),
          ],
        ),
      ),
    );
  }
}