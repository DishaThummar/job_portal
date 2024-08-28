import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_portal/configs/app_colors.dart';
import 'package:job_portal/configs/app_images.dart';
import 'package:job_portal/configs/app_text_style.dart';
import 'package:job_portal/view/home/controller/home_controller.dart';
import 'package:job_portal/view/home/model/company_model.dart';

class CustomBottomSheet extends StatelessWidget {
  final String title;
  final Company company;
  final String image;
  final HomeController controller;
  final int index;

  const CustomBottomSheet({
    super.key,
    required this.title,
    required this.image,
    required this.company,
    required this.controller,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          bottom: 0,
          child: Column(
            children: [

              Image.asset(
                AppImages.bottom,
                width: Get.width,
                fit: BoxFit.fill,
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 40, right: 40, top: 180, bottom: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                SizedBox(),
                  GestureDetector(
                      onTap: (){
                        Get.back();
                      },
                      child: Icon(Icons.close)),
                ],
              ),
              SizedBox(height: 30),

              Text(
                capitalizeWords(company.title.split(' ').take(2).join(' ')),
                style: AppTextStyle.regular600.copyWith(fontSize: 22),
              ),
              SizedBox(height: 8),
              Text(
                'Silicon Valley, CA',
                style: AppTextStyle.regular500
                    .copyWith(fontSize: 14, color: AppColors.greyColor),
              ),
              SizedBox(height: 8),
              Text(
                title,
                style: AppTextStyle.regular500
                    .copyWith(fontSize: 15, color: AppColors.greyColor),
              ),
              SizedBox(height: 50),
              Text(
                "Position",
                style: AppTextStyle.regular500
                    .copyWith(fontSize: 15, color: AppColors.greyColor),
              ),
              SizedBox(height: 8),
              Text(
                "Senior Ui/Ux Designer",
                style: AppTextStyle.regular600.copyWith(fontSize: 18),
              ),
              SizedBox(height: 32),
              Text(
                "Qualification",
                style: AppTextStyle.regular500
                    .copyWith(fontSize: 15, color: AppColors.greyColor),
              ),
              SizedBox(height: 16),
              Text(
                "Application must have at least up to",
                style: AppTextStyle.regular600.copyWith(fontSize: 17),
              ),
              SizedBox(height: 16),
              Text(
                "10years of design experience and must be",
                style: AppTextStyle.regular600.copyWith(fontSize: 17),
              ),
              SizedBox(height: 16),
              Text(
                "familiar with some design tools such as",
                style: AppTextStyle.regular600.copyWith(fontSize: 17),
              ),
              SizedBox(height: 16),
              Text(
                "adobe, illustator, Adobe XD.",
                style: AppTextStyle.regular600
                    .copyWith(fontSize: 15, color: AppColors.greyColor),
              ),
              // SizedBox(height: 10),
              Spacer(),
              controller.appliedJobs[index] == true
                  ? GestureDetector(
                      onTap: () {
                        Get.snackbar('Success', "Already Applied!",
                            backgroundColor: AppColors.primaryColor,
                            colorText: AppColors.whiteColor);
                        Get.close(1);
                      },
                      child: Container(
                        height: 40,
                        width: Get.width,
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                  color: AppColors.primaryColor, blurRadius: 10)
                            ],
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.primaryColor),
                        child: Center(
                          child: Text(
                            "APPLY NOW",
                            style: AppTextStyle.regular600.copyWith(
                                fontSize: 16, color: AppColors.whiteColor),
                          ),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        Get.snackbar('Success', "Applied Successfully!",
                            backgroundColor: AppColors.primaryColor,
                            colorText: AppColors.whiteColor);
                        controller.applyToJob(index);
                        Get.close(1);
                      },
                      child: Container(
                        height: 40,
                        width: Get.width,
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(color: AppColors.purple, blurRadius: 10)
                            ],
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.purple),
                        child: Center(
                          child: Text(
                            "APPLY NOW",
                            style: AppTextStyle.regular600.copyWith(
                                fontSize: 16, color: AppColors.whiteColor),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
        Positioned(
            top: 150,
            left: 70,
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ClipOval(child: Image.network(image)),
            )),
      ],
    );
  }

  String capitalizeWords(String text) {
    return text
        .split(' ')
        .map((word) => word.isNotEmpty
            ? word[0].toUpperCase() + word.substring(1).toLowerCase()
            : '')
        .join(' ');
  }
}
