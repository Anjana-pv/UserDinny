import 'dart:developer';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingController extends GetxController {
  
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);


Future<void> onDaySelected(DateTime selectedDay) async{
  selectedDate.value = selectedDay;
}

  Future<void> bookSelectedDate() async {
    try {
      DateTime? date = selectedDate.value;
      if (date != null) {
        await FirebaseFirestore.instance.collection('bookings').add({
          'date': date,
          // Add other necessary fields for your booking
        });
        Get.snackbar('Booking Successful', 'Your date is booked.');
      } else {
        Get.snackbar('Error', 'Please select a date.');
      }
    } catch (e) {
      log('Error booking date: $e');
      Get.snackbar('Error', 'An error occurred while booking.');
    }
  }
}
