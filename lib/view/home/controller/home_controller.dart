import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:job_portal/view/home/model/company_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  RxList<Company> companies = <Company>[].obs;
  RxMap<int, bool> appliedJobs = <int, bool>{}.obs;
  TextEditingController searchController = TextEditingController();
  RxBool isSearching = false.obs;
  RxList<Company> filteredCompanies = <Company>[].obs;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void onInit() {
    super.onInit();
    fetchCompanies();
    loadAppliedJobs();
    filteredCompanies.value = companies;
  }

  void onSearchChanged() {
    final query = searchController.text.toLowerCase();
    if (query.isEmpty) {
      filteredCompanies.value = companies;
    } else {
      filteredCompanies.value = companies
          .where((company) => company.title.toLowerCase().contains(query))
          .toList();
    }
    update();
  }

  void fetchCompanies() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1/photos'));
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      companies.value = jsonData.map((item) => Company.fromJson(item)).toList();
      filteredCompanies.value = companies;
      log("Fetched companies: ${companies}");
    }
  }

  Future<void> loadAppliedJobs() async {
    final prefs = await SharedPreferences.getInstance();
    final appliedJobsJson = prefs.getString('appliedJobs') ?? '{}';
    final Map<String, dynamic> appliedJobsMap = json.decode(appliedJobsJson);
    appliedJobs.value =
        appliedJobsMap.map((key, value) => MapEntry(int.parse(key), value));
  }

  Future<void> saveAppliedJobs() async {
    final prefs = await SharedPreferences.getInstance();
    final appliedJobsMap = Map<int, bool>.from(appliedJobs);
    final appliedJobsJson =
        json.encode(appliedJobsMap.map((k, v) => MapEntry(k.toString(), v)));
    await prefs.setString('appliedJobs', appliedJobsJson);
  }

  void applyToJob(int index) async {
    appliedJobs[index] = true;
    update();
    await saveAppliedJobs();
    update();
  }
}
