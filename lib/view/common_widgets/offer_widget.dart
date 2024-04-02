import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:user_dinny/controller/booking_controller.dart';

class OfferWidget extends StatelessWidget {
   OfferWidget({
    Key? key,
    required this.offerimage,
  }) : super(key: key);

  final NewBookingController offerimage;
  final RxInt myCurrentIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: StreamBuilder(
        stream: offerimage.getoffering(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No offers available'));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            RxList<DocumentSnapshot> document = snapshot.data!.docs.obs;

            return Stack(
              children: [
                ListView.builder(itemBuilder: (context, index) {
                  List<dynamic>  imageList=document[index]['imageUrls'] ?? ''; 
                return  CarouselSlider.builder( 
                  itemCount: imageList.length, 
                  itemBuilder: (context, imageIndex, realIndex) {
                    

                    return Image.network(
                      imageList[imageIndex],  
                      height: 100,
                      width: 300, 
                      fit: BoxFit.contain,
                    );
                  },
                  options: CarouselOptions(
                    autoPlay: true,
                    height: 200,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                    autoPlayInterval: const Duration(seconds: 2),
                    enlargeCenterPage: true,
                    aspectRatio: 2.0,
                    onPageChanged: (index, reason) {
                      myCurrentIndex.value = index;
                    },
                  ),
                );
                },itemCount: document.length,),
                Padding(
                  padding: const EdgeInsets.only(top: 210),
                  


                  child: Center(
                    child: Obx(() => AnimatedSmoothIndicator(
                      activeIndex: myCurrentIndex.value,
                      count: document.length,
                      effect: const WormEffect(
                        dotHeight: 8,
                        dotWidth: 8,
                        spacing: 10,
                        dotColor: Colors.grey,
                        activeDotColor: Colors.black,
                        paintStyle: PaintingStyle.fill,
                      ),
                    )),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
