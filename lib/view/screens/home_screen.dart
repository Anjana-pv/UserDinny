import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_dinny/controller/firebase_fuction.dart';
import 'package:user_dinny/view/screens/booking_history.dart';
import 'package:user_dinny/view/screens/first_screen.dart';
import 'package:user_dinny/view/screens/profile_screen.dart';
import 'package:user_dinny/view/screens/search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usercontroller = Get.put(UserController());
    return Obx(() => Scaffold(
          body: IndexedStack(
            index: usercontroller.selectedIndex.value,
            children:   const <Widget>[
              ScreenFirst(),
              ScreenBookingHistory(),
              SearchScreen(),
              ProfileScreen(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: const Color.fromARGB(255, 11, 78, 13) ,
            selectedIconTheme: const IconThemeData(color: Color.fromARGB(255, 21, 117, 24)),
            unselectedItemColor: const Color.fromARGB(255, 43, 42, 42),
            unselectedLabelStyle: const TextStyle(color: Colors.grey),
            onTap: (int index) {
              usercontroller.setIndex(index);
            },
            showSelectedLabels: true,
            showUnselectedLabels: true,
            currentIndex: usercontroller.selectedIndex.value,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: ' Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.calendar_month_sharp,
                ),
                label: 'Booking',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                ),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: 'Profile',
              ),
            ],
          ),
        ));
  }

  siginout() async {
    await FirebaseAuth.instance.signOut();
    Get.back();
  }
}
