import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecumat_foods/routes/app_pages.dart';
import 'package:pinput/pinput.dart';


class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final defaultTheme = PinTheme(
    width: 50,
    height: 50,
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Colors.grey, width: 2),
      ),
    ),
  );

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
              'Enter your 4-digit code',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 24,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 40),
            Text('code', style: TextStyle(fontWeight: FontWeight.w200, ),),
            Pinput(
              length: 4,
              defaultPinTheme: defaultTheme,
              focusedPinTheme: defaultTheme.copyWith(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
              ),
              onCompleted: (pin) {
                debugPrint(pin);
              },
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    // TODO: Implement resend code logic
                  },
                  child: const Text(
                    'Resend code',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                FloatingActionButton(
                  onPressed: () => Get.toNamed(Routes.SELECTLOCATION),
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Icon(Icons.arrow_forward_ios_outlined, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}