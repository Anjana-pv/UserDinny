import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  @override
  void onInit() {
  
    super.onInit();
   _loadLocalFavorites(); 
  refreshData();
  }

  final db = FirebaseFirestore.instance;
   RxList favoriteRestaurants = [].obs;
  Future<void> refreshData() async {
    SharedPreferences getuserId = await SharedPreferences.getInstance();

    final userId = getuserId.getString('getuser_id');
    final snapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection('favorites')
        .doc(userId)
        .get();
    final data = snapshot.data();
    if (data != null && data['favorites'] != null) { 
      favoriteRestaurants.value = data['favorites'];
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

  Stream<QuerySnapshot> getUserDetails() {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');
    final userStream = users.snapshots();
    return userStream;
  }

  var selectedIndex = 0.obs;

  void setIndex(int index) {
    selectedIndex.value = index;
  }

  Future<Map<String, dynamic>> getUserData() async {
    SharedPreferences getuserId = await SharedPreferences.getInstance();

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

  void addFavorite(String restaurantId, String userId) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('fav_list')
          .doc(restaurantId)
          .set({
        'restaurantId': restaurantId,
      });
    } catch (e) {
      log('Error adding favorite: $e');
    }
  }

  void addToFavoriteList(String userId, String restaurantId) async {
    try {
      await FirebaseFirestore.instance.collection('fav_list').doc(userId).set({
        'restaurants': FieldValue.arrayUnion([restaurantId]),
      }, SetOptions(merge: true));
    } catch (e) {
      log('Error adding to favorite list: $e');
    }
  }

  Future<void> toggleFavorite(String restaurantId, String userId) async {
    final isFav = await isFavorite(restaurantId, userId);
    if (isFav) {
      favoriteRestaurants.remove(restaurantId);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection("favorites")
          .doc(userId)
          .set({'favorites': favoriteRestaurants});
    } else {
      favoriteRestaurants.add(restaurantId);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection("favorites")
          .doc(userId)
          .set({'favorites': favoriteRestaurants});
    }

    update();
  }
  Future<void> _loadLocalFavorites() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  final favoriteRestaurantIds = sharedPreferences.getStringList('favorite_restaurants') ?? [];
  favoriteRestaurants.value = favoriteRestaurantIds;
}

}
