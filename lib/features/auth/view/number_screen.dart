import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field_v2/intl_phone_field.dart';
import '../auth_controller.dart';

class NumberScreen extends StatefulWidget {
  const NumberScreen({super.key});

  @override
  State<NumberScreen> createState() => _NumberScreenState();
}

class _NumberScreenState extends State<NumberScreen> {
  final TextEditingController _emailController = TextEditingController();
  final OtpController _otpController = Get.find<OtpController>();
  String _phoneNumber = '';

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Enter your mobile number',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Mobile Number',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
              IntlPhoneField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF53B175)),
                  ),
                ),
                initialCountryCode: 'NG',
                onChanged: (phone) {
                  _phoneNumber = phone.completeNumber;
                },
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Or use your email',
                  style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Email',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'imshuvo97@gmail.com',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFE2E2E2)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF53B175)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Obx(() => _otpController.errorMessage.value.isNotEmpty
                ? Text(
                    _otpController.errorMessage.value,
                    style: const TextStyle(color: Colors.red),
                  )
                : const SizedBox.shrink()),
            ],
          ),
        ),
      ),
      floatingActionButton: Obx(() => FloatingActionButton(
        onPressed: _otpController.isSending.value
          ? null
          : () {
              if (_emailController.text.isNotEmpty) {
                _otpController.sendOtp(_emailController.text.trim());
              } else if (_phoneNumber.length > 5) {
                // In a real app, you'd trigger phone OTP here.
                // We'll reuse the sendOtp with the phone number for now.
                _otpController.sendOtp(_phoneNumber);
              } else {
                Get.snackbar('Error', 'Please enter your email or phone number');
              }
            },
        backgroundColor: const Color(0xFF53B175),
        child: _otpController.isSending.value
          ? const CircularProgressIndicator(color: Colors.white)
          : const Icon(Icons.arrow_forward_ios, color: Colors.white),
      )),
    );
  }
}
