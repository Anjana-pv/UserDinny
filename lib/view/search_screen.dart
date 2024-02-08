import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_dinny/controller/search_controller.dart';
import 'package:user_dinny/view/home_screen.dart'; // Import your SearchController

class SearchScreen extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();
final searchInstance=Get.put(SearchGetController()); 
  SearchScreen({Key? key}) : super(key: key);

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
            Get.to( HomeScreen());
          },
          icon: const Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                hintText: 'Search restaurants, table type',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
              ),
              onChanged: (value) {
                log('$value');
                searchInstance.search(value);
              },
            ),
          ),
          Expanded(
            child: Obx(() {
              if (searchInstance.searchResults.isEmpty) {
                return const Center(child: Text('No results found'));
              } else {
                return ListView.builder(
                  itemCount: searchInstance.searchResults.length,
                  itemBuilder: (context, index) {
                    var title = searchInstance.searchResults[index]['Title']; 
                    return Text(title.toString());
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
