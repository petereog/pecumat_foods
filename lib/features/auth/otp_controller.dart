import 'package:get/get.dart';
import '../../core/network/otp_service.dart';
import '../../core/network/auth_service.dart';
import '../../routes/app_pages.dart';

class OtpController extends GetxController {
  final isLoading = false.obs;
  final isSending = false.obs;
  final errorMessage = ''.obs;
  final email = ''.obs;
  final username = ''.obs;

  Future<void> sendOtp(String emailAddress) async {
    try {
      isSending.value = true;
      errorMessage.value = '';

      if (emailAddress.isEmpty) {
        errorMessage.value = 'Please enter your email';
        return;
      }

      final result = await OtpService.sendOtp(emailAddress);

      if (result['success'] == true) {
        email.value = emailAddress;
        Get.toNamed(Routes.VERIFICATION);
        Get.snackbar(
          'OTP Sent',
          'Check your email for the verification code',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        errorMessage.value = result['message'] ?? 'Failed to send OTP';
      }
    } catch (e) {
      errorMessage.value = 'Network error. Please try again.';
    } finally {
      isSending.value = false;
    }
  }

  Future<void> verifyOtp(String otp) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      if (otp.length < 4) {
        errorMessage.value = 'Please enter the 4-digit code';
        return;
      }

      final result = await OtpService.verifyOtp(
        email.value,
        otp,
        username: username.value.isNotEmpty ? username.value : null,
      );

      if (result['success'] == true) {
        await AuthService.saveToken(
          result['accessToken'],
          result['refreshToken'],
        );
        await AuthService.saveUser(result['user']);
        Get.offAllNamed(Routes.SELECTLOCATION);
      } else {
        errorMessage.value = result['message'] ?? 'Invalid OTP';
      }
    } catch (e) {
      errorMessage.value = 'Network error. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resendOtp() async {
    if (email.value.isEmpty) return;
    await sendOtp(email.value);
  }
}