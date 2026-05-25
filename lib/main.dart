import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecumat_foods/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pecumat Foods',
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
