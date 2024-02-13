import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingHistory extends GetxController {
  
  final Rx<Stream<QuerySnapshot<Object?>>> bookingStream =
      Rx<Stream<QuerySnapshot<Object?>>>(const Stream.empty());

  final CollectionReference userBookingsCollection =
       FirebaseFirestore.instance.collection('users');

  String? userId; // Store user ID here

  @override
  void onInit() {
    super.onInit();
    getuserdata();
  }

  Stream<QuerySnapshot<Object?>> getBooking() {
    if (userId != null) {
      final CollectionReference userBookingsRef =
          FirebaseFirestore.instance.collection('users')
          .doc(userId)
          .collection('user_bookings');
      final Stream<QuerySnapshot<Object?>> userBookingsStream =
          userBookingsRef.snapshots();

      return userBookingsStream;
    } else {
      // Return an empty stream if user ID is not available
      return Stream.empty();
    }
  }

  Future<void> getuserdata() async {
    SharedPreferences getuserId = await SharedPreferences.getInstance();
    userId = getuserId.getString('getuser_id');
    bookingStream.value = getBooking();
  }

  Future<void> cancelBooking(String bookingId, Map<String, dynamic> bookingData) async {
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
            .add(bookingData); // Add booking data to cancel_booking collection

        getuserdata();
      }
    } catch (e) {
      print("Error cancelling booking: $e");
    }
  }
}
