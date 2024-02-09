// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// class MyCards extends StatelessWidget {
//   MyCards({ Key? key});

//   final myItems = [
//     Image.asset('assest/images/blank-profile-picture-973460-1-1-1080x1080.png'),
//     Image.asset('assest/images/blank-profile-picture-973460-1-1-1080x1080.png'),
//     Image.asset('assest/images/blank-profile-picture-973460-1-1-1080x1080.png'),
//     Image.asset('assest/images/blank-profile-picture-973460-1-1-1080x1080.png'),
//     Image.asset('assest/images/blank-profile-picture-973460-1-1-1080x1080.png'),
//   ];

  

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//  height: 200,
//  width: 200,
//  child: Column(
//           children: [
//             Obx(() => CarouselSlider(
//                   items: myItems,
//                   options: CarouselOptions(
//                     autoPlay: true,
//                     height: 200,
//                     autoPlayCurve: Curves.fastOutSlowIn,
//                     autoPlayAnimationDuration: const Duration(milliseconds: 800),
//                     autoPlayInterval: const Duration(seconds: 2),
//                     enlargeCenterPage: true,
//                     aspectRatio: 2.0,
//                     onPageChanged: (index, reason) {
//                       myCurrentIndex.value = index;
//                     },
//                   ),
//                 )),
//             AnimatedSmoothIndicator(
//               activeIndex: myCurrentIndex.value,
//               count: myItems.length,
//               effect: const WormEffect(
//                 dotHeight: 8,
//                 dotWidth: 8,
//                 spacing: 10,
//                 dotColor: Colors.grey,
//                 activeDotColor: Colors.black,
//                 paintStyle: PaintingStyle.fill,
//               ),
//             ),
//           ],
//         ),
    
//     );
//   }
// }
