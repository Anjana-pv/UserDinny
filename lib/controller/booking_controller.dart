import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:user_dinny/model/booking.dart';

class NewBookingController extends GetxController {
  TextEditingController guestcounController = TextEditingController();
  Stream<QuerySnapshot<Object?>> bookingStream = const Stream.empty();
  Stream<QuerySnapshot<Object?>> bookdata = const Stream.empty();
  final RxBool isSelected = false.obs;
  final RxString selectedValue = ''.obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  Rx<TimeOfDay?> selectedTime = Rx<TimeOfDay?>(null);
  RxInt selectedTableType = 2.obs;
  final RxString selectedTimeSlot = ''.obs;
  var seachList = List.empty(growable: true).obs;

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
// ------------------------------------------------------------------------

  Future<bool> addbookToFirestore(
    String restaurantId,
    String tableType,
  ) async {
    try {
      await FirebaseFirestore.instance.collection('books').add({
        'restaurantId': restaurantId,
        'date': DateTime.now().toLocal(),
        'time': DateTime.now().toLocal(),
        'tableType': tableType,
        'guestCount': int.parse(guestcounController.text),
      });
      log('book details added to Firestore');
      return true;
    } catch (e) {
      log('Error adding book details: $e');
      return false;
    }
  }

// -----------------------------------------------------------------------
  Future<bool> newbooking(BookingModel book,String resId) async {
    Map<String, dynamic> bookinfo = {
      'date': book.date,
      'time': book.time,
      'table_type': book.tableType,
      'guest_count': book.guestCount,
      'user_id': book.userId,
      'user_name': book.userName,
      'phone_number': book.phoneNumber,
      'profile_image': book.profileImage,
      'resturent_name': book.nameofresto,
      'resturent_id': book.resturentId,
      'menu_cards': book.manucard,
      'startedtime': book.startingTime,
      'endingtime': book.endingTime,
      'location': book.location,
      'city': book.city,
      'timestamp': DateTime.now()
    };
    try {
      final data = await FirebaseFirestore.instance
          .collection('users')
          .doc(book.userId)
          .collection('user_bookings')
          .add(bookinfo);
    
      final userBookingId = data.id;
     Map<String, dynamic> bookinfoUser = {
      'date': book.date,
      'time': book.time,
      'table_type': book.tableType,
      'guest_count': book.guestCount,
      'user_id': book.userId,
      'user_name': book.userName,
      'phone_number': book.phoneNumber,
      'profile_image': book.profileImage,
      'resturent_name': book.nameofresto,
      'resturent_id': book.resturentId,
      'menu_cards': book.manucard,
      'startedtime': book.startingTime,
      'endingtime': book.endingTime,
      'location': book.location,
      'city': book.city,
    
      'booking_id':userBookingId
    };
      
      await FirebaseFirestore.instance
          .collection('approvedOne')
          .doc(resId)
          .collection('bookings')
          .add(bookinfoUser);
      return true;
    } catch (e) {
      return false;
    }
  }

// ---------------------------------------------------------------------------
  Stream<QuerySnapshot<Object?>> getResturentDatas(userId) {
    final CollectionReference resturentCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('user_booking');
    final resturentStream = resturentCollection.snapshots();
    return resturentStream;
  }

  Stream<QuerySnapshot> fetchBookingData(userId) {
    try {
      bookingStream = getResturentDatas(userId);
      return bookingStream;
    } catch (e) {
      return const Stream.empty();
    }
  }

// --------------------------------------------------------------------------
  Future<bool> userBooking(BookingModel book) async {
    Map<String, dynamic> bookinfo = {
      ' date': book.date,
      ' time': book.time,
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

// ---------------------------------------------------------------------------------------
  Future<void> fetchBookingHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('getuser_id');
    bookdata = fetchBookingData(userId);
    log('$bookdata');
  }

  Stream<QuerySnapshot<Object?>> getoffers(resturentId) {
    final CollectionReference resturentCollection = FirebaseFirestore.instance
        .collection('approvedOne')
        .doc(resturentId)
        .collection('offerdimg');
    final resturentStream = resturentCollection.snapshots();
    return resturentStream;
  }

// -----------------------------------------------------------------------------------------------
  Stream<QuerySnapshot<Object?>> getoffering() {
    final CollectionReference accepted =
        FirebaseFirestore.instance.collection('offers');
    final acceptStream = accepted.snapshots();
    return acceptStream;
  }
}
