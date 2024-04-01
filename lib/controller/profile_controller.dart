import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileController extends GetxController {

  final Rx<Stream<DocumentSnapshot<Map<String, dynamic>>>> userProfileStream =
      Rx<Stream<DocumentSnapshot<Map<String, dynamic>>>>(const Stream.empty());

  @override
  void onInit() {
    super.onInit();
    getuserdatas();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getResturentDatas(userId) async {
    final DocumentSnapshot<Map<String, dynamic>> resturentCollection =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return resturentCollection;
  }

  Future<void> getuserdatas() async {
    SharedPreferences getuserId = await SharedPreferences.getInstance();
    final userId = getuserId.getString('getuser_id');

    userProfileStream.value = getResturentDatas(userId).asStream();
  }

  Future<void> deleteUser() async {
    SharedPreferences getuserId = await SharedPreferences.getInstance();
    final userId = getuserId.getString('getuser_id');

    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).delete();
    } catch (error) {
      log('Error deleting user: $error');
    }
  }
  
}
