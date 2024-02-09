import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:user_dinny/controller/booking.dart';

PageController pageController = PageController();
bool onLastPage = false;

class OfferWidget extends StatelessWidget {
  const OfferWidget({
    super.key,
    required this.offerimage,
  });

  final NewBookingController offerimage;

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
            List<DocumentSnapshot> document = snapshot.data!.docs;

            return Stack(
              children: [
                PageView(
                  controller: pageController,
                  onPageChanged: (index) {
                    onLastPage = (index == 1);
                  },
                  children: [
                    Image.network(document[0]['imageUrl'] ?? '',
                        height: 200, width: 300, fit: BoxFit.contain),
                    Image.network(document[1]['imageUrl'] ?? '',
                        height: 200, width: 300, fit: BoxFit.contain),
                    Image.network(document[2]['imageUrl'] ?? '',
                        height: 200, width: 300, fit: BoxFit.contain),
                  ],
                ),
                Container(
                    alignment: const Alignment(0, 0.95),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SmoothPageIndicator(
                            controller: pageController, count: 3),
                      ],
                    ))
              ],
            );
          }
        },
      ),
    );
  }
}
// ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: snapshot.data!.docs.length,
//               itemBuilder: (context, index) {
//                 DocumentSnapshot document = snapshot.data!.docs[index];
//                 Map<String, dynamic> offerData =
//                     document.data() as Map<String, dynamic>;
//                 String offerImageUrl = offerData['imageUrl'] ?? '';

//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Image.network(offerImageUrl,
//                       height: 200, width: 300, fit: BoxFit.contain),
//                 );
//               },
//             );