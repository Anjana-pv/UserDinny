import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';


class UserController extends GetxController{

  final db =FirebaseFirestore.instance;



    Stream<QuerySnapshot> getAccepted()  {
  final CollectionReference accepted =
      FirebaseFirestore.instance.collection('approvedOne');
  final acceptStream = accepted.snapshots();
  return acceptStream;
  }
  
Future<List<String>> fetchProfileImageUrls() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await db.collection('approvedOne').get();

      return snapshot.docs
          .where((document) => document.data().containsKey('profileImage'))
          .map<String>((document) => document['profileImage'] as String)
          .toList();
    } catch (e) {
      log('Error fetching data: $e');
      return [];
    }
  }
 
   Stream<QuerySnapshot> getuserDeatils()  {
  final CollectionReference accepted =
      FirebaseFirestore.instance.collection('users');
  final acceptStream = accepted.snapshots();
  return acceptStream;
  }
var selectedIndex = 0.obs;

  void setIndex(int index) {
    selectedIndex.value = index;
  }
  }














