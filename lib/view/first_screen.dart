import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_dinny/controller/booking.dart';
import 'package:user_dinny/view/common_widgets/custom_widgets.dart';
import 'package:user_dinny/controller/firebase_fuction.dart';
import 'package:user_dinny/styling/textsytling.dart';
import 'package:user_dinny/view/booking_scree.dart';
import 'package:user_dinny/view/common_widgets/offer_widget.dart';
import 'package:user_dinny/view/search_screen.dart';

class ScreenFirst extends StatelessWidget {
  const ScreenFirst({super.key});

  @override
  Widget build(BuildContext context) {
    double paddingMultiplier = MediaQuery.of(context).size.width * 0.05;
    double containerHeightMultiplier = MediaQuery.of(context).size.height * 0.2;
    double textSizeMultiplier = MediaQuery.of(context).size.width * 0.04;

    final usercontroller = Get.put(UserController());
    final offerimage = Get.put(NewBookingController());

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Home',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'FontStyle'),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
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
                          return const SizedBox(
                            child: Text('Loading...'),
                          );
                        }
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.docs.length > 5
                              ? 5
                              : snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot document =
                                snapshot.data!.docs[index];
                            Map<String, dynamic> data =
                                document.data() as Map<String, dynamic>;
                            String id = document.id;
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(BookingScreen(
                                    bookingId: "",
                                    isModify: false,
                                    data: data,
                                    id: id,
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
                        customeText: '  Your Favariote',
                        size: textSizeMultiplier,
                        type: FontWeight.normal),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: containerHeightMultiplier * 0.35,
                child: Wrap(
                  spacing: -0.0,
                  runSpacing: 10.0,
                  children: List.generate(5, (index) {
                    List<String> imageslist = [
                      'assest/images/rice.jpg',
                      'assest/images/fast food.jpg',
                      'assest/images/drinks.jpg',
                      'assest/images/coofie.jpg',
                      'assest/images/chinees.jpg'
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
                padding: const EdgeInsets.only(left: 20, top: 10),
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
                height: 20,
              ),
              OfferWidget(offerimage: offerimage)
              // MyCards(),
            ],
          ),
        ));
  }
}
