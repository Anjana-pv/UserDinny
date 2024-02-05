import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_dinny/controller/booking_history.dart';
import 'package:user_dinny/view/edit%20_screen.dart';

class ScreenBookingHistory extends StatelessWidget {
  const ScreenBookingHistory({super.key});

  @override
  Widget build(BuildContext context) {
    BookingHistory  fetchBookingData = Get.put(BookingHistory ());
    return Scaffold(
        appBar: AppBar(
          leading:IconButton(onPressed: (){
            Get.back();
          }, icon: Icon(Icons.arrow_back_ios)),
          title: const Text('My Bookings'),
        ),
        backgroundColor: Color.fromARGB(255, 205, 204, 204),
        body: Obx(() => StreamBuilder<QuerySnapshot<Object?>>(
            stream: fetchBookingData.bookingStream.value,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                List<DocumentSnapshot> bookings = snapshot.data!.docs;
                return Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      var bookingData =
                          bookings[index].data() as Map<String, dynamic>;
                      var bookingDate = bookingData[' date'] ?? '';
                      var guestCount = bookingData['guest_count'] ?? '';
                      var bookingTime = bookingData[' time'] ?? '';
                      String profileimage = bookingData['profile_image'] ?? '';

                      return GestureDetector(
                        onTap: () {
                          //  Get.to();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10,left: 3,right: 10)
                          ,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: MediaQuery.of(context).size.height * 0.15,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 246, 246, 246),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height * 0.3,
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                      image: NetworkImage(profileimage),
                                    )),
                                  ),
                                  const SizedBox(width: 10.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          ' Booking Details',
                                          style: TextStyle(
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          ' Guest $guestCount ',
                                          style: const TextStyle(fontSize: 14.0),
                                        ),
                                        Text(
                                          'Time: $bookingTime',
                                          style: const TextStyle(fontSize: 14.0),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 40),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Date: $bookingDate',
                                                style: const TextStyle(
                                                    fontSize: 14.0),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: bookings.length,
                  ),
                );
              } else {
                return const SizedBox(
                  child: Center(child: Text('error')),
                );
              }
            })));
  }
}
