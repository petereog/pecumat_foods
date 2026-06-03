import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/images/601 1.png',
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Get your groceries \nwith nectar',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 26,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 30),
                  
                  // Phone input area that navigates to dedicated phone screen
                  InkWell(
                    onTap: () => Get.toNamed(Routes.NUMBERSCREEN),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Color(0xFFE2E2E2)),
                        ),
                      ),
                      child: Row(
                        children: [
                          Image.asset('assets/images/8140 1.png', width: 30, height: 20, fit: BoxFit.cover,), // Placeholder flag
                          const SizedBox(width: 15),
                          const Text(
                            '+234',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Text(
                              'Enter mobile number',
                              style: TextStyle(color: Colors.grey, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  const Center(
                    child: Text(
                      'or connect with social media',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  
                  // Social Login Buttons
                  _buildSocialButton(
                    'Continue with Google',
                    const Color(0xFF5383EC),
                    'assets/images/Group 6795.png',
                    () {},
                  ),
                  const SizedBox(height: 20),
                  _buildSocialButton(
                    'Continue with Facebook',
                    const Color(0xFF4A66AC),
                    'assets/images/Vector.png',
                    () {},
                  ),
                  
                  const SizedBox(height: 30),
                  // Link to Email Login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Want to use email? ',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(Routes.LOGIN),
                        child: const Text(
                          'Log In',
                          style: TextStyle(
                            color: Color(0xFF53B175),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton(String text, Color color, String asset, VoidCallback onTap) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Image.asset(asset, width: 22, height: 22),
              Expanded(
                child: Center(
                  child: Text(
                    text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 22), // Balancing the icon
            ],
          ),
        ),
      ),
    );
  }
}
