import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../core/network/address_service.dart';

class SelectLocation extends StatefulWidget {
  const SelectLocation({super.key});

  @override
  State<SelectLocation> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  String selectedZone = 'Lagos';
  String selectedArea = 'Ikeja';
  bool isLoading = false;

  final List<String> zones = ['Lagos', 'Abuja', 'Port Harcourt', 'Ibadan', 'Kano'];
  final List<String> areas = ['Ikeja', 'Lekki', 'Victoria Island', 'Surulere', 'Yaba'];

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
            children: [
              Image.asset('assets/images/illustration.png', height: 170),
              const SizedBox(height: 40),
              const Text(
                'Select Your Location',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 15),
              const Text(
                'Switch on your location to stay in tune with\nwhats happening in your area',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 40),
              _buildDropdown('Your Zone', selectedZone, zones, (value) {
                setState(() => selectedZone = value!);
              }),
              const SizedBox(height: 30),
              _buildDropdown('Your Area', selectedArea, areas, (value) {
                setState(() => selectedArea = value!);
              }),
              const SizedBox(height: 40),
              Material(
                color: const Color(0xFF53B175),
                borderRadius: BorderRadius.circular(19),
                child: InkWell(
                  onTap: isLoading ? null : () async {
                    setState(() => isLoading = true);
                    try {
                      await AddressService.addAddress(
                        label: 'Home',
                        street: selectedArea,
                        city: selectedZone,
                        state: selectedZone,
                        zipCode: '100001',
                        country: 'Nigeria',
                        isDefault: true,
                      );
                    } catch (e) {
                      print('Location save error: $e');
                    } finally {
                      setState(() => isLoading = false);
                    }
                    Get.offAllNamed(Routes.HOME);
                  },
                  borderRadius: BorderRadius.circular(19),
                  child: Container(
                    height: 67,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
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

  Widget _buildDropdown(String label, String value, List<String> items, Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        const SizedBox(height: 10),
        DropdownButton<String>(
          value: value,
          isExpanded: true,
          underline: const Divider(thickness: 1),
          items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}