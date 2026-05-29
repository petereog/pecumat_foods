part of 'app_pages.dart';

abstract class Routes {
  static const ONBOARDING = _Paths.ONBOARDING;
  static const HOME = _Paths.HOME;
  static const SIGN = _Paths.SIGN;
  static const NUMBERSCREEN = _Paths.NUMBERSCREEN;
  static const VERIFICATION = _Paths.VERIFICATION;
  static const SELECTLOCATION = _Paths.SELECTLOCATION;
  static const LOGIN = _Paths.LOGIN;
  static const SIGNUP = _Paths.SIGNUP;
}

abstract class _Paths {
  static const ONBOARDING = '/onboarding';
  static const HOME = '/home';
  static const SIGN = '/sign';
  static const NUMBERSCREEN = '/numberscreen';
  static const VERIFICATION = '/verification';
  static const SELECTLOCATION = '/selectlocation';
  static const LOGIN = '/login';
  static const SIGNUP = '/signup';
}
