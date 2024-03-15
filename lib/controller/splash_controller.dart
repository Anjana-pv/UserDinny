import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_dinny/view/screens/home_screen.dart';
import 'package:user_dinny/view/screens/login.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(seconds: 4), () {
      checkLoginStatus();
    });
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLogined') ?? false;
    if (isLoggedIn) {
      Get.to(HomeScreen());
    } else {
      Get.to(Login());
    }
  }
}
  

