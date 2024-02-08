
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:user_dinny/controller/booking_history.dart';
import 'package:user_dinny/controller/firebase_fuction.dart';



class ScreenBookingHistory extends StatelessWidget {
  const ScreenBookingHistory({super.key});

  @override
  Widget build(BuildContext context) {
    BookingHistory fetchBookingData = Get.put(BookingHistory());
    UserController  bookingManaging =Get.put(UserController());

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios)),
          title: const Text('My Bookings'),
        ),
        backgroundColor: const Color.fromARGB(255, 205, 204, 204),
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
               
                return ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemBuilder: (context, index) {
              String bookingId = bookings[index].id;

                    var bookingData =
                        bookings[index].data() as Map<String, dynamic>;
                    var bookingDate = bookingData[' date'] ?? '';
                    var guestCount = bookingData['guest_count'] ?? '';
                    var bookingTime = bookingData[' time'] ?? '';
                    String profileimage = bookingData['profile_image'] ?? '';

                    return Card(
                      
                      surfaceTintColor: Colors.white,
                      elevation: 8.2,
                      
                      child: GestureDetector(
                        onTap: () {
                          
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            
                            height: MediaQuery.of(context).size.height * 0.17,

                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.08,
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                        image: NetworkImage(profileimage),
                                      )),
                                    ),
                                    const SizedBox(width: 10.0),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          ' Booking Details',
                                          style: TextStyle(
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Guest $guestCount ',
                                          style:
                                              const TextStyle(fontSize: 14.0),
                                        ),
                                        Text(
                                          'Time: $bookingTime',
                                          style:
                                              const TextStyle(fontSize: 14.0),
                                        ),
                                        
                                        Row(
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
                                      ],
                                    ),
                                    const Spacer(),
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('Confimed',
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 15,
                                          )),
                                    )
                                  ],
                                ),
                                const Divider(thickness: 2,), 
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                         
                                        },
                                        child: const Text('Modify Order')),
                                        
                                    TextButton(
                                        onPressed: () async {
                                     
                                        },
                                        child: const Text(
                                          'Cencal Order',
                                          style: TextStyle(color: Colors.red),
                                        )),
                                  ],
                                ),
                              ],
                            ),
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
            })));
  }
}
