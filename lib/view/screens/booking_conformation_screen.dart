
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_dinny/controller/booking_controller.dart';
import 'package:user_dinny/controller/bookinglog_controller.dart';
import 'package:user_dinny/model/booking.dart';
import 'package:user_dinny/view/screens/first_screen.dart';
import 'package:user_dinny/view/screens/home_screen.dart';
import 'package:user_dinny/view/screens/payment.dart';

class BookingConfirmation extends StatelessWidget {
  const BookingConfirmation(
      {Key? key,
      required this.restaurantName,
      required this.location,
      required this.bookingTime,
      required this.bookingDate,
      required this.guestCount,
      required this.restaurantId,
      required this.tableType,
      required this.email,
      required this.userData,
      required this.profileImage,
      required this.endingTime,
      required this.startingTime,
      required this.manucard, 
      required this.city,
      required this.isModify,
      required this.bookingId})
      : super(key: key);

  final String restaurantName;
  final String location;
  final String bookingTime;
  final String bookingDate;
  final String guestCount;
  final String restaurantId;
  final String tableType;
  final String email;
  final String profileImage;
  final List manucard;
  final String startingTime;
  final String endingTime;
  final bool isModify;
  final String bookingId;
  
  final String city;
  final Map<String, dynamic> userData;

  @override
  Widget build(BuildContext context) {
    NewBookingController newbooking = Get.put(NewBookingController());
 BookingHistory updatebooking = Get.put(BookingHistory());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Show Booking Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 208, 206, 206),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restaurantName,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 10, 10, 10),
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        location,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 15.0,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.people,
                                color: Color.fromARGB(255, 178, 18, 18),
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                'Guest count',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Color.fromARGB(255, 8, 8, 8),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.calendar_month,
                                  color: Color.fromARGB(255, 178, 18, 18)),
                              SizedBox(width: 6.0),
                              Text(
                                'Date & Time',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "$guestCount  Guests \n$tableType  Seats",
                            style: const TextStyle(
                              fontSize: 15.0,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          const SizedBox(
                            width: 100,
                          ),
                          Text(
                            '$bookingDate\n$bookingTime',
                            style: const TextStyle(
                              fontSize: 15.0,
                              color: Color.fromARGB(255, 1, 1, 1),
                            ),
                          ),
                        ],
                      ),
                    ]),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              child: Padding(
                padding: const EdgeInsets.all(11.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'User Detail',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        const Text("Name"),
                        Text("    : ${userData['username'] ?? ''}"),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Contact"),
                        Text(" : ${userData['phoneNumber'] ?? ''}"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            isModify?Row(): 
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const Text(
                      '* To secure your booking, there is a booking fee of Rs 200. This fee will be deducted from your final bill payment.',
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Get.to(const RazorpayScreeen());
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            return const Color.fromARGB(123, 20, 77, 14);
                          },
                        ),
                        minimumSize:
                            MaterialStateProperty.all(const Size(300, 40)),
                      
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Advance Payment',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () async {
                final bookingData = BookingModel(
                  date: bookingDate,
                  time: bookingTime,
                  tableType: tableType,
                  guestCount: guestCount,
                  userId: userData['userId'],
                  userName: userData['username'],
                  phoneNumber: userData['phoneNumber'],
                  resturentId: restaurantId,
                  profileImage: profileImage,
                  nameofresto: restaurantName,
                  manucard: manucard,
                   startingTime:startingTime, 
                   endingTime: endingTime,
                    location: location,
                     city: city, 
                );

                final responce =  isModify? await updatebooking.updatebooking(bookingData, bookingId) : await newbooking.newbooking(bookingData);
                if (responce) {
                  Get.snackbar('success', 'Your table is reserved',
                      backgroundColor: Colors.green);
                    
                     
                } else {
                  Get.snackbar('failed', 'Check your internet connection',
                      backgroundColor: Colors.red);
                }

                
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    return const Color.fromARGB(123, 20, 77, 14);
                  },
                ),
                minimumSize: MaterialStateProperty.all(const Size(200, 40)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
              ),
              child:   Text(isModify?'Confirm':
                'Submit',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
