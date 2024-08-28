import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_portal/configs/app_colors.dart';
import 'package:job_portal/configs/app_images.dart';
import 'package:job_portal/configs/app_text_style.dart';
import 'package:job_portal/view/login/controller/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: LoginController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: AppColors.whiteColor.withOpacity(0.9),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 60,),
                Expanded(
                    child: Image.asset(
                  AppImages.login,
                  fit: BoxFit.fill,
                )),
                const Spacer(),
                GestureDetector(
                  onTap: (){
                    controller.signInWithGoogle();
                  },
                  child: Container(
                    margin: const EdgeInsets.all(30),
                    height: 40,
                    width: Get.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.primaryColor)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AppImages.google,height: 50,),
                        Text(
                          "Continue With Google",
                          style: AppTextStyle.regular600.copyWith(
                              fontSize: 18, color: AppColors.primaryColor),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
