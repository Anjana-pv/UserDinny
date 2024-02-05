import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_dinny/controller/booking.dart';
import 'package:user_dinny/controller/booking_history.dart';
import 'package:user_dinny/view/home_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  NewBookingController book = NewBookingController();
  String _searchQuery = '';

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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search restaurants, table type ',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('approvedOne')
                  .where('itemName',
                      isGreaterThanOrEqualTo: _searchQuery.toLowerCase())
                  .where('itemName',
                      isLessThan: _searchQuery.toLowerCase() + 'z')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                var searchList = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: searchList.length,
                  itemBuilder: (context, index) {
                    var title = searchList[index]['Title'];
                    return Text(title.toString());
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
