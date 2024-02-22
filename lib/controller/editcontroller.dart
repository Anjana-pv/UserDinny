
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_dinny/controller/profile_controller.dart';

class EditController extends GetxController {
  final profileInstance=Get.put(UserProfileController());

  Future<void> updateUserDetails(
      {required String newName,
      required String newEmail,
      required String newPhoneNumber}) async {
    try {
      SharedPreferences getuserId = await SharedPreferences.getInstance();
      final userId = getuserId.getString('getuser_id');
      final userRef =
          FirebaseFirestore.instance.collection('users').doc(userId);
      await userRef.update({
        'userName': newName,
        'email': newEmail,
        'phoneNumber': newPhoneNumber,
      }).then((value) => profileInstance.getuserdatas()); 
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
