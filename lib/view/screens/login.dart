import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:user_dinny/view/common_widgets/custom_textfeild.dart';
import 'package:user_dinny/controller/auth_controller.dart';
import 'package:user_dinny/styling/colors.dart';
import 'package:user_dinny/view/screens/privacy_policies.dart';
import 'package:user_dinny/view/screens/signin.dart';

final GlobalKey<FormState> validationKey = GlobalKey<FormState>();

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    bool _isChecked = false;
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
                    authController.emailcontrooller),
                const SizedBox(
                  height: 20,
                ),
                reusableTextFeild("Enter Password", Icons.lock, true,
                    authController.passwordcontroller),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                    
                      GestureDetector(
                        onTap: (){
                         Get.to(PrivacyPolicyScreen()) ;    
                        },
                        child: Text(
                          'Check the policy and privacy',
                          style: TextStyle(color:  Color.fromARGB(255, 255, 255, 255),),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                signInSignButton(context, true, () async {
                  if (validationKey.currentState?.validate() ?? false) {
                    authController.login(
                        emailcontrooller.text, passwordcontroller.text);
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
