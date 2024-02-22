import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_dinny/controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  final SplashController _controller = Get.put(SplashController());

   SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _controller.checkAuthentication();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assest/images/logo-img.png',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              value: 2.5,
            ),
          ],
        ),
      ),
    );
  }
}