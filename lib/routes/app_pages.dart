import 'package:get/get.dart';
import '../onboarding/view/pages/onboarding_screen.dart';
import '../home/view/pages/homescreen.dart';
import '../authentication/view/pages/signin_screen.dart';
import '../authentication/view/pages/number_screen.dart';


part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.ONBOARDING;

  static final routes = [
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingScreen(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const Homescreen(),
    ),
    GetPage(
      name: _Paths.SIGN,
      page: () => const SigninScreen(),
    ),
    GetPage(name: _Paths.NUMBERSCREEN,
        page: () => const NumberScreen(),
    ),
  ];
}
