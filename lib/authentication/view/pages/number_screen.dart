import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field_v2/intl_phone_field.dart';
import 'package:pecumat_foods/routes/app_pages.dart';

class NumberScreen extends StatefulWidget {
  const NumberScreen({super.key});

  @override
  State<NumberScreen> createState() => _NumberScreenState();
}

class _NumberScreenState extends State<NumberScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 23.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Enter your mobile number',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 24,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 30),
            IntlPhoneField(
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: UnderlineInputBorder(),
              ),
              initialCountryCode: 'NG',
              onChanged: (phone) {
                debugPrint(phone.completeNumber);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.VERIFICATION),
        backgroundColor: Colors.green, // Changed to Green for brand consistency
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100), // Circular FAB
        ),
        child: const Icon(Icons.arrow_forward_ios_outlined, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
