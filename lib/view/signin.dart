import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_dinny/common_widgets/table_dropdown.dart';
import 'package:user_dinny/styling/colors.dart';
import 'package:user_dinny/view/home_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
     TextEditingController passwordcontroller=TextEditingController();
    TextEditingController emailcontrooller=TextEditingController();
    TextEditingController phonenumberController=TextEditingController();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 3, 3, 3),
        elevation: 0,
        title: const Text('Sign Up',
        style: TextStyle(
          fontSize: 24,
          color: Colors.white,
          fontWeight: FontWeight.bold),),

      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
           hexStringcolor("CB2B93"),
          hexStringcolor("9546C4"),
          hexStringcolor('5E61F4')
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child:SingleChildScrollView(
          child: Padding(padding:EdgeInsets.fromLTRB(20,MediaQuery.of(context).size.height*0.2,20,0),
        child: Column(
            children: <Widget>[
            
            const SizedBox(height: 30,),
            reusableTextFeild(
              'Enter Uername',
               Icons.verified_user, 
               false, emailcontrooller),
               const SizedBox(height: 30,),
               reusableTextFeild(
                "Enter Password",
                 Icons.lock,
                 true,
                   passwordcontroller),
                const SizedBox(
                  height: 20,
                ),
                reusableTextFeild(
                "Enter Phone Number",
                 Icons.lock,
                 true,
                   phonenumberController),
                    const SizedBox(
                  height: 20,
                ),
                SignInSignButton(context,false,(){
                 Get.to(HomeScreen());
                } ),
                
            ],
            
          ),
        ),
        ),

      ),
      
      );
    
  }
}