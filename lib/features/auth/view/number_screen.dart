import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field_v2/intl_phone_field.dart';
import '../otp_controller.dart';

class NumberScreen extends StatefulWidget {
  const NumberScreen({super.key});

  @override
  State<NumberScreen> createState() => _NumberScreenState();
}

class _NumberScreenState extends State<NumberScreen> {
  final TextEditingController _emailController = TextEditingController();
  final OtpController _otpController = Get.put(OtpController());
  String phoneNumber = '';

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
              'Enter your mobile number',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 30),
            IntlPhoneField(
              decoration: const InputDecoration(
                labelText: 'Mobile Number',
                border: UnderlineInputBorder(),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF53B175)),
                ),
              ),
              initialCountryCode: 'NG',
              onChanged: (phone) {
                phoneNumber = phone.completeNumber;
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Or enter your email',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'example@gmail.com',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE2E2E2)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF53B175)),
                ),
              ),
            ),
            Obx(() {
              if (_otpController.errorMessage.value.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    _otpController.errorMessage.value,
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                  ),
                );
              }
              return const SizedBox();
            }),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: Obx(() => FloatingActionButton(
                onPressed: _otpController.isSending.value
                    ? null
                    : () {
                  if (_emailController.text.isNotEmpty) {
                    _otpController.sendOtp(_emailController.text.trim());
                  } else {
                    Get.snackbar(
                      'Error',
                      'Please enter your email to receive OTP',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                },
                backgroundColor: const Color(0xFF53B175),
                child: _otpController.isSending.value
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Icon(Icons.arrow_forward_ios, color: Colors.white),
              )),
            ),
          ],
        ),
      ),
    );
  }
}