import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_dinny/view/screens/booking_scree.dart';
import 'package:user_dinny/view/screens/search_screen.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorite Restaurants',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: usercontroller.getAccepted(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<DocumentSnapshot> restaurants = snapshot.data!.docs;
            List<DocumentSnapshot> favoriteRestaurants =
                restaurants.where((resto) {
              return usercontroller.favoriteRestaurants.contains(resto.id);
            }).toList();
           
            log('Favorite Restaurants: ${favoriteRestaurants.length}');
            return ListView.builder(
              itemCount: favoriteRestaurants.length,
              itemBuilder: (context, index) {
                var restaurant = favoriteRestaurants[index];

                return GestureDetector(
                  onTap: () {
                    Get.to(BookingScreen(
                      resId: restaurant.id,
                      isModify: false,
                      id: restaurant.id,
                      data: restaurant.data()! as Map<String, dynamic>,
                      bookingId: '',
                    ));
                  },
                  child: Card(
                    child: ListTile(
                        leading: Image.network(
                          restaurant['profileImage'],
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          "${restaurant['restaurantName']}",
                        ),
                        subtitle: Text(
                          "${restaurant['city']}",
                        ),
                        trailing: Obx(
                          () => IconButton(
                            icon: const Icon(Icons.favorite),
                            color: Colors.red,
                            onPressed: () async {
                              SharedPreferences getuserId =
                                  await SharedPreferences.getInstance();
                              final userId = getuserId.getString('getuser_id');
                              await usercontroller.toggleFavorite(
                                  restaurant.id, userId!);
                            },
                          ),
                        )),
                  ),
                );
              },
            );
          } else {
            return const SizedBox(
              child: Center(
                child: Text('Please check the internet'),
              ),
            );
          }
        },
      ),
    );
  }
}
