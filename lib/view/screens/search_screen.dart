import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_dinny/controller/firebase_fuction.dart';
import 'package:user_dinny/view/screens/booking_scree.dart';

Rx<String> searchvalue = ''.obs;
final usercontroller = Get.put(UserController());
final searchController = TextEditingController().obs;

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search',
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
          } else if (snapshot.hasData) {
            List<DocumentSnapshot> restaurants = snapshot.data!.docs;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: searchController.value,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        hintText: 'Search your favorite restaurant',
                        filled: true,
                        fillColor: const Color.fromARGB(255, 231, 231, 231),
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                            onPressed: () {
                              searchvalue.value = '';
                              searchController.value.text = '';
                            },
                            icon: const Icon(Icons.close))),
                    onChanged: (value) {
                      searchvalue.value = value;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Obx(() {
                    RxList<DocumentSnapshot<Object?>> filteredRestaurants =
                        restaurants
                            .where((resto) {
                              Rx<String> name =
                                  "${resto['restaurantName']}".obs;
                              return name.toLowerCase().startsWith(
                                    searchvalue.value.toLowerCase(),
                                  );
                            })
                            .toList()
                            .obs;
                    return ListView.builder(
                      itemCount: filteredRestaurants.length,
                      itemBuilder: (context, index) {
                        var restaurant = filteredRestaurants[index];

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
                              trailing: Obx(() => IconButton(
                                icon: const Icon(Icons.favorite),
                                color:
                                    usercontroller.favoriteRestaurants.isEmpty
                                        ? Colors.grey
                                        : usercontroller.favoriteRestaurants
                                                .contains(restaurant.id)
                                            ? Colors.red
                                            : Colors.grey,
                                onPressed: () async {
                                  SharedPreferences getuserId =
                                      await SharedPreferences.getInstance();

                                  final userId =
                                      getuserId.getString('getuser_id');
                                  //     usercontroller.addFavorite(restaurant.id, userId!);
                                  await usercontroller.toggleFavorite(
                                      restaurant.id, userId!);
                                },
                              ),)
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
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
