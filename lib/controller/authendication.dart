
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_dinny/view/home_screen.dart';


class AuthController extends GetxController {

  TextEditingController passwordcontroller = TextEditingController();
TextEditingController emailcontrooller = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User?> user = Rx<User?>(null);
  @override
  void onInit() {
    user.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  Future<void> signUp({
    required String userName,
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        String userId = userCredential.user!.uid;

        SharedPreferences getuserId = await SharedPreferences.getInstance();
        getuserId.setString('getuser_id', userId);

        await FirebaseFirestore.instance.collection('users').doc(userId).set({
          'userId': userId,
          'userName': userName,
          'email': email,
          'phoneNumber': phoneNumber,
          'password': password,
        });
      }

      user.value = userCredential.user;
    } catch (e) {
  

      throw e;
    }
  }

  
Future<void> login(String email, String password) async {
  
    QuerySnapshot acceptedSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', 
        isEqualTo: emailcontrooller.text)
        .where('password',
       isEqualTo:passwordcontroller.text) 
        .get();

   
    if (acceptedSnapshot.docs.isNotEmpty) {
      final DocumentSnapshot usersDoc = acceptedSnapshot.docs.first;
      final String userId=usersDoc.id;
       SharedPreferences prefsTeacherId =
            await SharedPreferences.getInstance();
        prefsTeacherId.setString('getuser_id',userId);
      Get.off(const HomeScreen());
      emailcontrooller.clear();
      passwordcontroller.clear();
     
      return;
    }
   

     Get.snackbar(
      'Error',
      'Invalid email or password',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );


  Future<void> signOut() async {
    try {
      await _auth.signOut();
      user.value = null;
    } catch (e) {
      print("Error in sign out: $e");

      throw e;
    }
  }
}
}