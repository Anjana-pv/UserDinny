import 'package:firebase_auth/firebase_auth.dart';
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
    TextEditingController phonenberController=TextEditingController();
    TextEditingController userNameController=TextEditingController();
  
  
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
              'Enter Uer Name',
               Icons.verified_user, 
               false, userNameController),
               const SizedBox(height: 30,),
               reusableTextFeild(
                "Enter Email id",
                 Icons.mail,
                 false,
                   passwordcontroller),
                const SizedBox(
                  height: 20,
                ),
                reusableTextFeild(
                "Enter Phone Number",
                 Icons.phone,
                 false,
                   emailcontrooller),
                    const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                reusableTextFeild(
                "Enter Password",
                 Icons.lock,
                 true,
                   phonenberController),
                    const SizedBox(
                  height: 20,
                ),
                SignInSignButton(context,false,(){
                  FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email:emailcontrooller.text ,
                     password: passwordcontroller.text)
                    .then((value){
                      print('created new account');
                     Get.to(HomeScreen());
                  }).onError((error, stackTrace) {
                    print("Error occured ${error.toString()}");
                  });
                 
                } ),
                
            ],
            
          ),
        ),
        ),

      ),
      
      );
    
  }
}