import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:user_dinny/model/usermodel.dart';

class BookingController extends GetxController {
  final bookingService = BookingService();
  final bookings = <Booking>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBookings();
  }

  Future<void> fetchBookings() async {
    final newBookings = await bookingService.fetchBookings();
    bookings.assignAll(newBookings);
  }
}
class BookingService {
  Future<List<Booking>> fetchBookings() async {
    await Future.delayed(Duration(seconds: 2));
    return [
      //  Booking(
      // //   id: '1',
      //    restaurantName: 'Sample Restaurant 1',
      //    date: '2024-02-01',
      //    time: '18:30',
      //    guestCount: 2,
      //     restaurantId: '',
      //  ),
    ];
  }
}