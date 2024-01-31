import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_dinny/common_widgets/table_dropdown.dart';
import 'package:user_dinny/controller/authendication.dart';
import 'package:user_dinny/styling/colors.dart';
import 'package:user_dinny/view/home_screen.dart';

class SignupScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  SignupScreen({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController passwordcontroller = TextEditingController();
    TextEditingController emailcontrooller = TextEditingController();
    TextEditingController phonenberController = TextEditingController();
    TextEditingController userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
   

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 3, 3, 3),
        elevation: 0,
        title: const Text(
          'Sign Up',
          style: TextStyle(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
        key: formKey,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            hexStringcolor("CB2B93"),
            hexStringcolor("9546C4"),
            hexStringcolor('5E61F4')
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  20, MediaQuery.of(context).size.height * 0.2, 20, 0),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 30,
                  ),
                  reusableTextFeild('Enter User Name', 
                  Icons.verified_user,
                      false, 
               userNameController),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextFeild(
                      "Enter Email id", 
                      Icons.mail, 
                      false,emailcontrooller),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextFeild("Enter Phone Number", Icons.phone, false,
                 phonenberController),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextFeild(
                      "Enter Password",
                       Icons.lock, true, 
               passwordcontroller),
                  const SizedBox(
                    height: 20,
                  ),
                  signInSignButton(context, false, () async {     
                    if (formKey.currentState?.validate() ?? false) {
                      await authController.signUp(
                        userName: userNameController.text,
                        email: emailcontrooller.text,
                        phoneNumber: phonenberController.text,
                        password: passwordcontroller.text,
                      );

                      if (authController.user.value != null) {
                        print('created new account');
                        Get.offAll(HomeScreen());
                      }
                    }
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
