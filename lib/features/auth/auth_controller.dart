import 'package:get/get.dart';
import '../../core/network/auth_service.dart';
import '../../routes/app_pages.dart';

class AuthController extends GetxController {
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      if (email.isEmpty || password.isEmpty) {
        errorMessage.value = 'Please fill in all fields';
        return;
      }

      final result = await AuthService.login(email, password);

      if (result['success'] == true) {
        await AuthService.saveToken(
          result['accessToken'],
          result['refreshToken'],
        );
        await AuthService.saveUser(result['user']);
        Get.offAllNamed(Routes.SELECTLOCATION);
      } else {
        errorMessage.value = result['message'] ?? 'Login failed';
      }
    } catch (e) {
      errorMessage.value = 'Network error. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register(String username, String email, String password) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      if (username.isEmpty || email.isEmpty || password.isEmpty) {
        errorMessage.value = 'Please fill in all fields';
        return;
      }

      final result = await AuthService.register(username, email, password);

      if (result['success'] == true) {
        await AuthService.saveToken(
          result['accessToken'],
          result['refreshToken'],
        );
        await AuthService.saveUser(result['user']);
        Get.offAllNamed(Routes.SELECTLOCATION);
      } else {
        errorMessage.value = result['message'] ?? 'Registration failed';
      }
    } catch (e) {
      errorMessage.value = 'Network error. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await AuthService.logout();
    Get.offAllNamed(Routes.LOGIN);
  }
}