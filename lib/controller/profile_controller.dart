import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  final Rx<Stream<QuerySnapshot<Object?>>> profileStream =
      Rx<Stream<QuerySnapshot<Object?>>>(const Stream.empty());

  @override
  void onInit() {
    super.onInit();
    log('Controller initialized');
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
    profileStream.value = getResturentDatas(userId);
  }
}