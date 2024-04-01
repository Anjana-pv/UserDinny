import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_dinny/controller/profile_controller.dart';
import 'package:user_dinny/view/screens/login.dart';


class SettingsScreeen extends StatelessWidget {
  const SettingsScreeen({super.key});

  @override
  Widget build(BuildContext context) {
    UserProfileController userprofile=Get.put(UserProfileController());
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: (){
               userprofile.deleteUser();
               Get.off(const Login());
            },
            child: Column(
              children: [
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
            
                  color:const Color.fromARGB(255, 52, 135, 84),
                
                ),
               child: const Center(
                  child: Text(
                    'Delete your Account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
                
               
              ],
            ),
          ),
        ));
  }

  Future<void>deleteUser(BuildContext context)async{
    showDialog(
      context: context, 
    builder: (BuildContext context){
      return AlertDialog(
        title: const Text('Account Deleted'),
          content: const Text('Your account has been successfully deleted.'),
          actions: [
            TextButton(
              onPressed: () {
              Get.back();
              },
              child: const Text('OK'),
            )
      
          ]);

    
  }
    );
  }
}
