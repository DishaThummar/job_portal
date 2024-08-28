import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../configs/app_colors.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      alignment: Alignment.center,
      height: MediaQuery.sizeOf(context).width / 7,
      width: MediaQuery.sizeOf(context).width / 7,
      child: const CircularProgressIndicator(
        color: AppColors.primaryColor,
        strokeWidth: 2,
      ),
    ));
  }
}

void showLoadingDialog() {
  Future.delayed(
    Duration.zero,
    () {
      Get.dialog(const LoadingView(), barrierDismissible: false);
    },
  );
}

void hideLoadingDialog({
  bool isTrue = false,
}) {
  Get.back(
    closeOverlays: isTrue,
  );
}
