import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:user_dinny/controller/profile_controller.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';


class BookingHistory extends GetxController {
  final Rx<Stream<QuerySnapshot<Object?>>> bookingStream =
      Rx<Stream<QuerySnapshot<Object?>>>(const Stream.empty());
  

  @override
  void onInit() {
    super.onInit();
   getuserdata();

  
  }

  Stream<QuerySnapshot<Object?>> getBooking(userId) {
    final CollectionReference resturentCollection =
        FirebaseFirestore.instance.collection('users').doc(userId).collection('user_bookings');
    final Stream<QuerySnapshot<Object?>> resturentStream =
        resturentCollection.snapshots();

    return resturentStream;
  }

   Future<void> getuserdata() async {
    SharedPreferences getuserId = await SharedPreferences.getInstance();

    final userId = getuserId.getString('getuser_id');
    bookingStream.value = getBooking(userId);
  }
  
  
}

