import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:job_portal/configs/app_colors.dart';
import 'package:job_portal/configs/app_text_style.dart';
import 'package:job_portal/view/home/controller/home_controller.dart';
import 'package:job_portal/view/login/view/login_view.dart';
import 'package:job_portal/widgest/bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    Get.find<HomeController>().searchController.addListener(() {
      Get.find<HomeController>().onSearchChanged();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
          key: controller.scaffoldKey,
          drawer: Drawer(
              child: Center(
            child: GestureDetector(
              onTap: () async {
                try {
                  final FirebaseAuth auth = FirebaseAuth.instance;
                  final GoogleSignIn googleSignIn = GoogleSignIn();
                  await auth.signOut();
                  await googleSignIn.signOut();

                  Get.offAll(() => LoginView());
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.clear();
                } catch (e) {
                  log('Error signing out: $e');
                }
              },
              child: Container(
                height: 40,
                margin: EdgeInsets.only(left: 32, right: 32),
                width: Get.width,
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(color: AppColors.purple, blurRadius: 10)
                    ],
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.purple),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.logout,
                        size: 20,
                        color: AppColors.whiteColor,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Logout",
                        style: AppTextStyle.regular600.copyWith(
                            fontSize: 16, color: AppColors.whiteColor),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: () {
                        controller.scaffoldKey.currentState!.openDrawer();
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.search_sharp),
                      onPressed: () {
                        controller.isSearching.value = true;
                        controller.update();
                      },
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text('Find your Dream\nJob today',
                      style: AppTextStyle.regular600.copyWith(fontSize: 28)),
                ),
                controller.isSearching.value == true
                    ? SizedBox(height: 16)
                    : SizedBox(height: 8),
                controller.isSearching.value == true
                    ? TextFormField(
                        controller: controller.searchController,
                        onChanged: (value) => controller.onSearchChanged(),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                          hintText: 'Search...',
                          suffixIcon:
                              controller.searchController.text.isNotEmpty
                                  ? IconButton(
                                      icon: Icon(
                                        Icons.close,
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        controller.searchController.clear();
                                        controller.isSearching.value = false;
                                        controller.onSearchChanged();
                                      },
                                    )
                                  : SizedBox(),
                        ),
                      )
                    : SizedBox(),
                const SizedBox(height: 20),
                Expanded(
                  child: Obx(()=>controller.filteredCompanies.isEmpty
                      ? Center(child: Text('No data found'))
                      : ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: controller.filteredCompanies.length,
                    itemBuilder: (context, index) {
                      var company = controller.filteredCompanies[index];
                      return GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: AppColors.transparentColor,
                            isScrollControlled: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20)),
                            ),
                            builder: (context) => CustomBottomSheet(
                              title: company.title,
                              image: company.thumbnailUrl,
                              controller: controller,
                              index: index,
                              company: company,
                            ),
                          );
                        },
                        child: Card(
                          margin: EdgeInsets.only(bottom: 16),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: ListTile(
                            leading: ClipOval(
                                child: company.thumbnailUrl.isNotEmpty
                                    ? Image.network(
                                  company.thumbnailUrl,
                                  height: 50,
                                )
                                    : CircleAvatar(
                                  radius: 25,
                                )),
                            title: Text(
                              company.title.split(' ').take(2).join(' '),
                              style:
                              TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              company.title,
                              maxLines: 1,
                            ),
                            trailing: CircleAvatar(
                              radius: 15,
                              backgroundColor:
                              controller.appliedJobs[index] ?? false
                                  ? AppColors.greenColor
                                  : AppColors.purple,
                              child: Icon(
                                Icons.lock,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),)
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
