import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_dinny/controller/bookinglog_controller.dart';
import 'package:user_dinny/view/screens/booking_scree.dart';


class ScreenBookingHistory extends StatelessWidget {
  const ScreenBookingHistory({super.key,});

  @override 
  Widget build(BuildContext context) {
    BookingHistory fetchBookingData = Get.put(BookingHistory());
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('My Bookings', style: TextStyle(
            fontSize: 21,

            fontWeight: FontWeight.w400,
          ),
        ),
      ),

      ),
      backgroundColor: const Color.fromARGB(255, 205, 204, 204),
      body: Obx(
        () => StreamBuilder<QuerySnapshot<Object?>>(
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

              return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemBuilder: (context, index) {
                  String bookingId = bookings[index].id;

                  var bookingData =
                      bookings[index].data() as Map<String, dynamic>;
                    var resturentName = bookingData['resturent_name']?? '';
                  var bookingDate = bookingData['date'] ?? '';
                  var guestCount = bookingData['guest_count'] ?? '';
                  // var tabletype=bookingData['table_type']??'';
                  var bookingTime = bookingData['time'] ?? '';
                  String profileimage = bookingData['profile_image'] ?? '';

                  return Card(
                    surfaceTintColor: Colors.white,
                    elevation: 8.2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.17,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            profileimage.isEmpty
                                ? const CircularProgressIndicator()
                                : Row(
                                    children: [
                                      Container(
                                        height: MediaQuery.of(context)
                                                .size
                                                .height *
                                            0.08,
                                        width: MediaQuery.of(context)
                                                .size
                                                .width *
                                            0.3,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(profileimage),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10.0),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                        Text(
                                           resturentName,
                                            style: const TextStyle(
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'Guest $guestCount ',
                                            style: const TextStyle(
                                                fontSize: 14.0),
                                          ),
                                          Text(
                                            'Time: $bookingTime',
                                            style: const TextStyle(
                                                fontSize: 14.0),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                            children: [
                                              Text(
                                                'Date: $bookingDate',
                                                style: const TextStyle(
                                                    fontSize: 14.0),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('Confirmed',
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 15)),
                                      )
                                    ],
                                  ),
                            const Divider(
                              thickness: 2,
                            ),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  onPressed: () { 
                              Get.to(BookingScreen(id: bookingData['resturent_id'] ?? '', data:bookingData, isModify: true, bookingId: bookingId, resId:bookingData['resturent_id'] ?? '' ,));
                                  },
                                  child: const Text('Modify Order'),
                                ),
                                TextButton( 
                                  onPressed: () async {
                                   
                                    bool confirmed = await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Confirm Cancellation'),
                                          content: const Text(
                                              'Are you sure you want to cancel this order?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop(
                                                    false);
                                              },
                                              child: const Text('No'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop(
                                                    true); 
                                              },
                                              child: const Text('Yes'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                    if (confirmed == true) {
                                      BookingHistory fetchBookingData =
                                          Get.find();
                                      await fetchBookingData.cancelBooking(
                                          bookingId, bookingData);
                                    }
                                  },
                                  child: const Text(
                                    'Cancel Order',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: bookings.length,
              );
            } else {
              return const SizedBox(
                child: Center(child: Text('error')),
              );
            }
          },
        ),
      ),
    );
  }
}
