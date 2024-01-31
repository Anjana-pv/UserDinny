import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_dinny/controller/firebase_fuction.dart';
import 'package:user_dinny/view/booking_history.dart';
import 'package:user_dinny/view/first_screen.dart';
import 'package:user_dinny/view/profile_screen.dart';
import 'package:user_dinny/view/search_screen.dart';

  


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usercontroller = Get.put(UserController());
  
    return Obx(() => 
    Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Home\nLocation',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'FontStyle'),
        ),
        actions: [
          IconButton(
              onPressed: () {
                siginout();
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: IndexedStack(
        index: usercontroller.selectedIndex.value,
        children: const <Widget> [ 
          ScreenFirst(),
         ScreenBookingHistory(),
          SearchScreen(), 
          ProfileScreen(), 
        ],
      ),
      bottomNavigationBar: BottomNavigationBar( 
        onTap: (int index){
         usercontroller.setIndex(index);
        },
        items: const [
          BottomNavigationBarItem(

            icon: Icon(
              Icons.home,
              color: Color.fromARGB(255, 149, 74, 74),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.airplane_ticket,
              color: Colors.black,
            ),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Colors.black,
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
