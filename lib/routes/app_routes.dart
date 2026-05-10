part of 'app_pages.dart';

abstract class Routes {
  static const ONBOARDING = _Paths.ONBOARDING;
  static const HOME = _Paths.HOME;
  static const SIGN = _Paths.SIGN;
  static const NUMBERSCREEN = _Paths.NUMBERSCREEN;
  static const VERIFICATION = _Paths.VERIFICATION;
  static const LOCATION = _Paths.LOCATION;
}

abstract class _Paths {
  static const ONBOARDING = '/onboarding';
  static const HOME = '/home';
  static const SIGN = '/sign';
  static const NUMBERSCREEN = '/numberscreen';
  static const VERIFICATION = '/verification';
  static const LOCATION = '/location';
}
