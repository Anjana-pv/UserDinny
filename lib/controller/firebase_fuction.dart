import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  final db = FirebaseFirestore.instance;
  RxList<String> favoriteRestaurants = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadLocalFavorites();
    refreshData();
  }

  Future<void> refreshData() async {
    final SharedPreferences getuserId = await SharedPreferences.getInstance();
    final userId = getuserId.getString('getuser_id');
    final snapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection('favorites')
        .doc(userId)
        .get();

    final data = snapshot.data();
    if (data != null && data['favorites'] != null) {
      favoriteRestaurants.value = List<String>.from(data['favorites']);
    }
  }

  Future<bool> isFavorite(String restaurantId, String userId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection('favorites')
        .doc(userId)
        .get();

    final data = snapshot.data();
    if (data != null && data['favorites'] != null) {
      final List<dynamic> restaurants = data['favorites'];
      return restaurants.contains(restaurantId);
    }
    return false;
  }

  Stream<QuerySnapshot> getAccepted() {
    return FirebaseFirestore.instance.collection('approvedOne').snapshots();
  }

  Future<List<String>> fetchProfileImageUrls() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
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

  Stream<QuerySnapshot> getUserDetails() {
    return FirebaseFirestore.instance.collection('users').snapshots();
  }

  var selectedIndex = 0.obs;

  void setIndex(int index) {
    selectedIndex.value = index;
  }

  Future<Map<String, dynamic>> getUserData() async {
    final SharedPreferences getuserId = await SharedPreferences.getInstance();
    final userId = getuserId.getString('getuser_id');

    if (userId != null) {
      final DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userData.exists) {
        final Map<String, dynamic> userDataMap =
            userData.data() as Map<String, dynamic>;
        final String username = userDataMap['userName'] ?? '';
        final String phoneNumber = userDataMap['phoneNumber'] ?? '';

        return {
          'userId': userId,
          'username': username,
          'phoneNumber': phoneNumber
        };
      } else {
        throw Exception('User document does not exist for user ID: $userId');
      }
    }
    return {};
  }

  Future<void> addFavorite(String restaurantId, String userId) async {
    try {
      favoriteRestaurants.add(restaurantId);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('favorites')
          .doc(userId)
          .set({'favorites': favoriteRestaurants.toList()});
    } catch (e) {
      log('Error adding favorite: $e');
    }
  }

  Future<void> _loadLocalFavorites() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final favoriteRestaurantIds =
        sharedPreferences.getStringList('favorite_restaurants') ?? [];
    favoriteRestaurants.assignAll(favoriteRestaurantIds);
  }

  Stream<QuerySnapshot> favratelist() {
    return FirebaseFirestore.instance.collection('approvedOne').snapshots();
  }

  Future<void> toggleFavorite(String restaurantId, String userId) async {
    final isFav = await isFavorite(restaurantId, userId);
    if (isFav) {
      favoriteRestaurants.remove(restaurantId);
    } else {
      favoriteRestaurants.add(restaurantId);
    }

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection("favorites")
        .doc(userId)
        .set({'favorites': favoriteRestaurants.toList()});

    update();
  }
}
