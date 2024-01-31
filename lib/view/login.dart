import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_dinny/view/common_widgets/table_dropdown.dart';
import 'package:user_dinny/controller/authendication.dart';
import 'package:user_dinny/styling/colors.dart';
import 'package:user_dinny/view/home_screen.dart';
import 'package:user_dinny/view/signin.dart';

final GlobalKey<FormState> validationKey = GlobalKey<FormState>();
TextEditingController passwordcontroller = TextEditingController();
TextEditingController emailcontrooller = TextEditingController();

class Login extends StatelessWidget {
 
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    return Scaffold(
      body: Form(
        key: validationKey,
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            hexStringcolor("CB2B93"),
            hexStringcolor("9546C4"),
            hexStringcolor('5E61F4')
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20.0, 200),
            child: Column(
              children: <Widget>[
                logoWidget("assest/images/logo-img.png"),
                const SizedBox(
                  height: 30,
                ),
                reusableTextFeild('Enter Uername', Icons.verified_user, false,
                    emailcontrooller),
                const SizedBox(
                  height: 20,
                ),
                reusableTextFeild(
                    "Enter Password", Icons.lock, true, passwordcontroller),
                const SizedBox(
                  height: 20,
                ),
                signInSignButton(context, true, () async {
                  if (validationKey.currentState?.validate() ?? false) {
                    await authController.signIn(
                      email: emailcontrooller.text,
                      password: passwordcontroller.text,
                    );
                    if (authController.user.value != null) {
                      print('created new account');
                      Get.to(const HomeScreen());
                    }
                  }
                }),
                signupotion()
              ],
            ),
          )),
        ),
      ),
    );
  }

  Row signupotion() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have account?",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        GestureDetector(
            onTap: () {
              Get.to(SignupScreen());
            },
            child: const Text('Sign Up',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20))),
      ],
    );
  }

  Image logoWidget(String imageName) {
    return Image.asset(
      imageName,
      fit: BoxFit.fitWidth,
      width: 240,
      height: 240,
      color: Colors.white,
    );
  }
}
