import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
   

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
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
      String userId = userCredential.user!.uid;

      
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'userId': userId,
        'userName': userName,
        'email': email,
        'phoneNumber': phoneNumber,
        'password':password,
      });
      }
     
      user.value = userCredential.user;
    } catch (e) {
      print("Error in sign up: $e");
      
      throw e;
    }
  }
  Future<String?> signIn({
  required String email,
  required String password,
}) async {
  try {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return null; // Sign in successful, return null or a success code
  } catch (e) {
    // print("Error in sign in: $e");
    return "Sign in failed. Please check your credentials."; // Return an error message
  }
}

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

