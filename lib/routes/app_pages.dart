import 'package:get/get.dart';
import '../features/onboarding/view/onboarding_screen.dart';
import '../features/home/view/homescreen.dart';
import '../features/auth/view/signin_screen.dart';
import '../features/auth/view/number_screen.dart';
import '../features/auth/view/verification_screen.dart';
import '../features/auth/view/select_location.dart';

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
    GetPage(
      name: _Paths.NUMBERSCREEN,
      page: () => const NumberScreen(),
    ),
    GetPage(
      name: _Paths.VERIFICATION,
      page: () => const VerificationScreen(),
    ),
    GetPage(
      name: _Paths.SELECTLOCATION,
      page: () => const SelectLocation(),
    ),
  ];
}
