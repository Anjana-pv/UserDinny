import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_dinny/controller/firebase_fuction.dart';
import 'package:user_dinny/styling/textsytling.dart';
import 'package:user_dinny/view/booking_scree.dart';
import 'package:user_dinny/common_widgets/custom_widgets.dart';
import 'package:user_dinny/view/search_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final usercontroller = Get.put(UserController());
    double paddingMultiplier = MediaQuery.of(context).size.width * 0.05;
    double containerHeightMultiplier = MediaQuery.of(context).size.height * 0.2;
    double textSizeMultiplier = MediaQuery.of(context).size.width * 0.04;

    return Scaffold(
      appBar: AppBar(

        actions: [
          GestureDetector(
              onTap: () {
                (() => siginout());
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.menu),
              ))
        ],
        title: const Text(
          'Home\nLocation',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'FontStyle'),
        ),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Get.to(const SearchScreen());
            },
            child: Container(
              padding: EdgeInsets.only(
                left: paddingMultiplier,
                right: paddingMultiplier,
                top: paddingMultiplier,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        Get.to(const SearchScreen());
                      },
                      decoration: const InputDecoration(
                        hintText: 'Search...',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.all(paddingMultiplier),
            child: Row(
              children: [
                GoogleFontText(
                    customeText: ' Recommented',
                    size: textSizeMultiplier,
                    type: FontWeight.normal),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
              height: containerHeightMultiplier,
              child: StreamBuilder(
                  stream: usercontroller.getAccepted(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.docs.length > 5
                          ? 5
                          : snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot document = snapshot.data!.docs[index];
                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              Get.to(BookingScreen(
                                data: data,
                                id: document.id,
                              ));
                            },
                            child: buildCard(context, data),
                          ),
                        );
                      },
                    );
                  })),
          Padding(
            padding: EdgeInsets.only(
              left: paddingMultiplier,
            ),
            child: Row(
              children: [
               GoogleFontText(
                    customeText: ' Choose Your Favariote',
                    size: textSizeMultiplier,
                    type: FontWeight.normal),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: containerHeightMultiplier * 0.35,
            child: Wrap(
              spacing: -0.0,
              runSpacing: 10.0,
              children: List.generate(5, (index) {
                List<String> imageslist = [
                  'assest/images/Buffalo Chicken Salad.jpg',
                  'assest/images/meals.jpg',
                  'assest/images/veg.jpg',
                  'assest/images/veg.jpg',
                  'assest/images/veg.jpg',
                ];

                return Padding(
                  padding: EdgeInsets.all(paddingMultiplier * 0.5),
                  child: CircleAvatar(
                    radius: containerHeightMultiplier * 0.175,
                    backgroundColor: Colors.blue,
                    backgroundImage: AssetImage(imageslist[index]),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
           Padding(
            padding: EdgeInsets.only(left: 20,top: 10),

            child: Row(
              children: [
               GoogleFontText(
                    customeText: ' Best Offers',
                    size: textSizeMultiplier,
                    type: FontWeight.normal),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Container(
            height: 200,
            width: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.amber),
          )
        ],
      ),
    );
  }

  siginout() async {
    await FirebaseAuth.instance.signOut();
  }
}
