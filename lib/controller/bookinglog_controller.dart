import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_dinny/model/booking.dart';

class BookingHistory extends GetxController {
  final Rx<Stream<QuerySnapshot<Object?>>> bookingStream =
      Rx<Stream<QuerySnapshot<Object?>>>(const Stream.empty());
  final CollectionReference userBookingsCollection =
      FirebaseFirestore.instance.collection('users');
  String? userId;
  @override
  void onInit() {
    super.onInit();
    getuserdata();
  }

  Stream<QuerySnapshot<Object?>> getBooking() {
    if (userId != null) {
      final CollectionReference userBookingsRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('user_bookings');
      final Stream<QuerySnapshot<Object?>> userBookingsStream =
          userBookingsRef.snapshots();

      return userBookingsStream;
    } else {
      return const Stream.empty();
    }
  }
// ===========Get userdata============================================================

  Future<void> getuserdata() async {
    SharedPreferences getuserId = await SharedPreferences.getInstance();
    userId = getuserId.getString('getuser_id');
    bookingStream.value = getBooking();
  }
// ================cancel data===========================================
  Future<void> cancelBooking(
      String bookingId, Map<String, dynamic> bookingData) async {
    try {
      if (userId != null) {
        await userBookingsCollection
            .doc(userId)
            .collection('user_bookings')
            .doc(bookingId)
            .delete();

        await FirebaseFirestore.instance
            .collection('approvedOne')
            .doc(userId)
            .collection('cancel_booking')
            .add(bookingData);

        getuserdata();
      }
    } catch (e) {
      log("Error cancelling booking: $e");
    }
  }
// =====================================update==============================

  Future<bool> updatebooking(
      BookingModel book, String bookingId, String resId) async {
    String? matchingDocId = await getDocumentIdByBookingId(bookingId, resId);

    Map<String, dynamic> resbookinfo = {
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
      'booking_id': bookingId
    };
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
    };
    try {
      await FirebaseFirestore.instance
          .collection('approvedOne')
          .doc(resId)
          .collection('bookings')
          .doc(matchingDocId)
          .update(resbookinfo);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(book.userId)
          .collection('user_bookings')
          .doc(bookingId)
          .update(bookinfo);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String?> getDocumentIdByBookingId(String bookingId, String resturentId) async {
    QuerySnapshot acceptedSnapshot = await FirebaseFirestore.instance
        .collection('approvedOne')
        .doc(resturentId)
        .collection('bookings')
        .where('booking_id', isEqualTo: bookingId)
        .get();

    if (acceptedSnapshot.docs.isNotEmpty) {
      final DocumentSnapshot usersDoc = acceptedSnapshot.docs.first;
      final String userId = usersDoc.id;
      return userId;
    }
  }
}
