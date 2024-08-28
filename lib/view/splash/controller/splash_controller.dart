import 'package:get/get.dart';
import 'package:job_portal/view/home/view/home_view.dart';
import 'package:job_portal/view/login/view/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    Future.delayed(const Duration(seconds: 3), () {
      checkLoginStatus();
    });
    super.onInit();
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');

    if (userId != null) {
      Get.offAll(() => const HomeView());
    } else {
      Get.offAll(() => const LoginView());
    }
  }
}
