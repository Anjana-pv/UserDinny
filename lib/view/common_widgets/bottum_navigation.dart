 import 'package:get/get.dart';
import 'package:user_dinny/view/booking_history.dart';
import 'package:user_dinny/view/home_screen.dart';
import 'package:user_dinny/view/profile_screen.dart';
import 'package:user_dinny/view/search_screen.dart';

void onTabTapped(int index) {
  switch (index) {
    case 0:
          const HomeScreen();

      break;
    case 1:
   
      const ScreenBookingHistory();
      
      break;
    case 2:Get.to( const SearchScreen());
      break;
    case 3:
   
      Get.to(const ProfileScreen());
      break;
   
  }
}
