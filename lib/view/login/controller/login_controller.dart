import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:job_portal/view/home/view/home_view.dart';
import 'package:job_portal/widgest/loading_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController{
   final FirebaseAuth auth = FirebaseAuth.instance;
   final GoogleSignIn googleSignIn = GoogleSignIn();
   late SharedPreferences prefs;

   @override
   Future<void> onInit() async {
     prefs = await SharedPreferences.getInstance();
     super.onInit();
   }

  Future<void> signInWithGoogle() async {
    showLoadingDialog();

    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await auth.signInWithCredential(credential);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userEmail', userCredential.user?.email ?? '');
      await prefs.setString('userId', userCredential.user?.uid ?? '');

      hideLoadingDialog();
      Get.offAll(()=>HomeView());
    } catch (e) {
      hideLoadingDialog();
      print(e);
    }

  }


}