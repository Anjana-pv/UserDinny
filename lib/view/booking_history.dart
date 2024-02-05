import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_dinny/controller/booking_history.dart';

class ScreenBookingHistory extends StatelessWidget { 
  const ScreenBookingHistory({super.key});
  
  
  @override
  Widget build(BuildContext context) {
    BookingController fetchBookingData =Get.put (BookingController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('My Bookings'),
      ),
      body:Obx(() =>  StreamBuilder<QuerySnapshot<Object?>>(
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

                var bookingData = bookings[index].data()as Map<String,dynamic>;
               
                String user = bookingData[' user_name']?? ''; 
                  var bookingDate = bookingData[' date']??'';
                  var userInfo = bookingData['phone_number']??'';
                  var guestCount = bookingData['guest_count']??'';
                  var bookingTime = bookingData[' time']??'';
                   var proflie_pic =bookingDate['profile_image']??"";


                 return Container(

                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.15,

                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 246, 246, 246),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              ' Table Bookings',
                              style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold ,
                              ),
                            ),
                            
                            Text(
                              "Username: $user",
                              style: const TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                            Text(
                              'Geust Count:  $guestCount',
                              style: const TextStyle(fontSize: 14.0),
                            ),
                            Text(
                              'User Info:  $userInfo',
                              style: const TextStyle(fontSize: 14.0),
                            ),
                             Text(
                                    'Time: $bookingTime',
                                    style: const TextStyle(fontSize: 14.0),
                                  ),
                          

                          Padding(
                            padding: const EdgeInsets.only(right:40 ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Date: $bookingDate',
                                    style: const TextStyle(fontSize: 14.0),
                                  ),
                                
                                  
                                  
                                ],
                              ),
                          ),
                          ],
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
        }
      )
      )
    );
  }

}