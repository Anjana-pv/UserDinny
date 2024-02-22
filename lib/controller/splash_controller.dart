import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:user_dinny/view/home_screen.dart';
import 'package:user_dinny/view/login.dart';

class SplashController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;

  void checkAuthentication() async {
    User? user = _auth.currentUser;
    if (user != null) {
      Get.offAll(() => HomeScreen());
    } else {
      Get.offAll(() => const Login());
    }
  }
}
