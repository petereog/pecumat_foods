import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  static const primaryColor = Color(0xFF53B175);
  static const darkColor = Color(0xFF181725);
  static const greyColor = Color(0xFF7C7C7C);
  static const borderColor = Color(0xFFE2E2E2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    Container(
                      width: 65,
                      height: 65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(27),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/illustration.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Afsar Hossen',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: darkColor,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.edit_outlined, color: primaryColor, size: 18),
                            ],
                          ),
                          const Text(
                            'Imshuvo97@gmail.com',
                            style: TextStyle(
                              fontSize: 16,
                              color: greyColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Divider(thickness: 1, color: borderColor),
              
              _buildAccountItem(Icons.shopping_bag_outlined, 'Orders'),
              _buildAccountItem(Icons.badge_outlined, 'My Details'),
              _buildAccountItem(Icons.location_on_outlined, 'Delivery Address'),
              _buildAccountItem(Icons.payment_outlined, 'Payment Methods'),
              _buildAccountItem(Icons.confirmation_number_outlined, 'Promo Cord'),
              _buildAccountItem(Icons.notifications_none_outlined, 'Notifecations'),
              _buildAccountItem(Icons.help_outline, 'Help'),
              _buildAccountItem(Icons.info_outline, 'About'),
              
              const SizedBox(height: 30),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Material(
                  color: const Color(0xFFF2F3F2),
                  borderRadius: BorderRadius.circular(19),
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(19),
                    child: Container(
                      height: 67,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                          const Icon(Icons.logout, color: primaryColor),
                          const Expanded(
                            child: Center(
                              child: Text(
                                'Log Out',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 24),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccountItem(IconData icon, String title) {
    return Column(
      children: [
        ListTile(
          onTap: () {},
          contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          leading: Icon(icon, color: darkColor, size: 24),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: darkColor,
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: darkColor,
          ),
        ),
        const Divider(
          thickness: 1,
          color: borderColor,
          indent: 25,
          endIndent: 25,
        ),
      ],
    );
  }
}
