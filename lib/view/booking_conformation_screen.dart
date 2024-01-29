import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_dinny/controller/booking.dart';
import 'package:user_dinny/controller/calender.dart';
import 'package:user_dinny/model/booking_model.dart';
import 'package:user_dinny/view/payment.dart';

class BookingConfirmation extends StatelessWidget {
  const BookingConfirmation({
    Key? key,
    required this.restaurantName,
    required this.location,
    required this.bookingTime,
    required this.bookingDate,
    required this.guestCount,
    required this.restaurantId,
    required this.tableType,
    required this.email,
  }) : super(key: key);

  final String restaurantName;
  final String location;
  final String bookingTime;
  final String bookingDate;
  final String guestCount;
  final String restaurantId;
  final String tableType;
  final String email;

  @override
  Widget build(BuildContext context) {
    NewBookingController newbooking = Get.put(NewBookingController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Show Booking Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: const [],
      ),
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurantName,
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 10, 10, 10),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      location,
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.person_outline_sharp,
                              color: Color.fromARGB(255, 9, 9, 9),
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
                                color: Color.fromARGB(255, 0, 0, 0)),
                            SizedBox(width: 8.0),
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
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "$guestCount Guests \n $tableType seats",
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        const SizedBox(
                          width: 100,
                        ),
                        Text(
                          '$bookingDate\n$bookingTime',
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Color.fromARGB(255, 1, 1, 1),
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('User Name'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '* To secure your booking, there is a booking fee of Rs 200. This fee will be deducted from your final bill payment.',
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(const RazorpayScreeen());
                    },
                    child: const Text(
                      'Advance Payment',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return Color.fromARGB(123, 20, 77, 14);
                        },
                      ),
                      minimumSize: MaterialStateProperty.all(Size(300, 40)),
                      // Adjust the size as needed
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: ()async {
                final bookingData = BookingModel(
                
                    date: bookingDate,
                    time: bookingTime,
                    tableType: tableType,
                    guestCount: guestCount,
                    userId: '2345678hhb',
                    userName: 'amal',
                    phoneNumber: '1234455', 
                    resturentId: restaurantId);
            final responce=  await  newbooking.newbooking(bookingData);
            log('$responce');
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
              child: const Text(
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
