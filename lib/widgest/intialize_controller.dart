import 'package:get/get.dart';
import 'package:job_portal/view/home/controller/home_controller.dart';
import 'package:job_portal/view/login/controller/login_controller.dart';
import 'package:job_portal/view/splash/controller/splash_controller.dart';

initalizeController(){
  Get.put(SplashController());
  Get.put(LoginController());
  Get.put(HomeController());
}