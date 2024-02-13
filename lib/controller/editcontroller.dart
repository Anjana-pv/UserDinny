import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditController extends GetxController {
  final Rx<Stream<QuerySnapshot<Object?>>> editStream =
      Rx<Stream<QuerySnapshot<Object?>>>(const Stream.empty());

  TextEditingController username = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getuserdata();
  }

  Stream<QuerySnapshot<Object?>> getResturentDatas(userId) {
    final CollectionReference resturentCollection =
        FirebaseFirestore.instance.collection('users');
    final Stream<QuerySnapshot<Object?>> resturentStream =
        resturentCollection.snapshots();

    return resturentStream;
  }

  Future<void> getuserdata() async {
    SharedPreferences getuserId = await SharedPreferences.getInstance();
    final userId = getuserId.getString('getuser_id');
    editStream.value = getResturentDatas(userId);
  }

  Future<void> updateUserDetails(
      String newName, String newEmail, String newPhoneNumber) async {
    try {
      SharedPreferences getuserId = await SharedPreferences.getInstance();
      final userId = getuserId.getString('getuser_id');
      final userRef =
          FirebaseFirestore.instance.collection('users').doc(userId);
      await userRef.update({
        'userName': newName,
        'email': newEmail,
        'phoneNumber': newPhoneNumber,
      });
    } catch (e) {
      print('Error updating user details: $e');
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getData() async {
    SharedPreferences getuserId = await SharedPreferences.getInstance();
    final userId = getuserId.getString('getuser_id');
    DocumentSnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return querySnapshot;
  }
}
