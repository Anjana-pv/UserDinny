import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:user_dinny/model/booking_model.dart';
import 'package:user_dinny/model/usermodel.dart';

class NewBookingController extends GetxController {
  TextEditingController guestcounController = TextEditingController();

  Rx<DateTime> selectedDate = DateTime.now().obs;
  Rx<TimeOfDay?> selectedTime = Rx<TimeOfDay?>(null);
  Rx<String?> selectedTimeSlot = Rx<String?>(null);
  RxInt selectedTableType = 2.obs;

  void selectDate(DateTime date) {
    selectedDate.value = date;
  }

  void selectTime(TimeOfDay time) {
    selectedTime.value = time;
  }

  void selectTimeSlot(String timeSlot) {
    selectedTimeSlot.value = timeSlot;
  }

  void selectTableType(int? value) {
    selectedTableType.value = value ?? 2;
  }

  // Future<bool> addbookTo(book book) async {
  //  Map<String,dynamic> bookinfo={
  //       'restaurantId': book.restaurantId,
  //       'date': book.date,
  //       'time': book.time,
  //       'tabletype': book.tabletype,
  //       'guestCount': book.guestCount,
  //       'city': book.city,
  //       'address': book.address,
  //       'profileImage': book.profileImage,
  //       'timeslot': book.email,
  //       'resturenName': book.resturenName,

  //     };
  //     try{
  //       await FirebaseFirestore.
  //       instance.collection('book_info').
  //       doc().
  //       set(bookinfo);
  //       return true;
  //     }

  //    catch (e) {
  //     return false;

  //   }
  // }

  Future<bool> addbookToFirestore(
    String restaurantId,
    String tableType,
  ) async {
    try {
      await FirebaseFirestore.instance.collection('books').add({
        'restaurantId': restaurantId,
        'date': DateTime.now().toLocal(),
        'time': DateTime.now().toLocal(),
        'tableType': tableType, // Update with the actual table type
        'guestCount': int.parse(guestcounController.text),
        // Add more details as needed
      });
      log('book details added to Firestore');
      return true;
    } catch (e) {
      log('Error adding book details: $e');
      return false;
    }
  }

  Future<bool> newbooking(BookingModel book) async {
    Map<String, dynamic> bookinfo = {
      ' date': book.date,
      ' time':book. time,
      'table_type': book.tableType,
      'guest_count': book.guestCount,
      'user_id': book.userId,
      ' user_name': book.userName,
      'phone_number': book.phoneNumber

    };
    try {
      await FirebaseFirestore.instance
          .collection('approvedOne')
          .doc(book.resturentId)
          .collection('bookings')
          .add(bookinfo);
          
      return true;
    } catch (e) {
      return false;
    }
  }
}
