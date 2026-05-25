import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field_v2/intl_phone_field.dart';
import '../../../routes/app_pages.dart';

class NumberScreen extends StatelessWidget {
  const NumberScreen({super.key});

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
              ),
              initialCountryCode: 'NG',
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () => Get.toNamed(Routes.VERIFICATION),
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
