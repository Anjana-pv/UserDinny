 import 'package:get/get.dart';
import 'package:user_dinny/view/home_screen.dart';
import 'package:user_dinny/view/profile_screen.dart';
import 'package:user_dinny/view/search_screen.dart';

void onTabTapped(int index) {
  switch (index) {
    case 0:
          HomeScreen();

      break;
    case 1:
     // BookingScreen(id: id, data: data); 
      
      break;
    case 2:Get.to(const SearchScreen());
      break;
    case 3:
   
      Get.to(const ProfileScreen());
      break;
   
  }
}
