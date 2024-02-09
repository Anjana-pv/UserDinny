import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_dinny/controller/firebase_fuction.dart';
import 'package:user_dinny/controller/search_controller.dart';
import 'package:user_dinny/view/home_screen.dart';

var searchvalue = ''.obs;

SearchGetController searchInstance = Get.put(SearchGetController());
final usercontroller = Get.put(UserController());
final TextEditingController searchController = TextEditingController();

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Search',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Get.to(const HomeScreen());
            },
            icon: const Icon(Icons.arrow_back_ios_rounded),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: usercontroller.getAccepted(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                List<DocumentSnapshot> resturents = snapshot.data!.docs;
                List<DocumentSnapshot> filteredResturents =
                    resturents.where((resto) {
                  final String name = "${resto['restaurantName']}}";

                  return name.toLowerCase().startsWith(
                        searchvalue.value.toLowerCase(),
                      );
                }).toList();
                return Column(
                  children: [
                    TextField(
                      controller:
                          TextEditingController(text: searchvalue.value),
                      decoration: const InputDecoration(
                        hintText: 'Search restaurants, table type',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                      ),
                      onChanged: (value) {
                        searchvalue.value = value;
                        Get.forceAppUpdate();
                      },
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteredResturents.length,
                        itemBuilder: (context, index) {
                          var restaurant = filteredResturents[index];
                          return Text(
                            "${filteredResturents[index]['restaurantName']}",
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return const SizedBox(
                  child: Center(
                    child: Text('please check the internet'),
                  ),
                );
              }
            }));
  }
}
