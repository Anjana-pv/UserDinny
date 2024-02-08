import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:user_dinny/controller/profile_controller.dart';
import 'package:user_dinny/view/edit%20_screen.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    ProfileController profileInstance = Get.put(ProfileController());
    return Obx(() => StreamBuilder<QuerySnapshot>(
        stream: profileInstance.profileStream.value,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) { 
            final List<DocumentSnapshot> data=snapshot.data!.docs;
             final Map<String, dynamic> userData = data.isNotEmpty ? data.first.data() as Map<String, dynamic> : {};
            return Scaffold(
              body: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: size.height * 0.25,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage('assest/images/profile image.png'),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Positioned(
                        top: 50,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Column(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: ClipOval(
                                  child: Image.asset(
                                    'assest/images/profile_logo-removebg-preview.png',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text( 
                                 userData['userName'] ?? '', 
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              const SizedBox(height: 5),
                               Text( userData['phoneNumber'] ?? '',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: Row(
                        children: [
                          Icon(Icons.restaurant_menu),
                          SizedBox(width: 20),
                          Text(
                            'Bookings',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      )),
                  const SizedBox(
                    height: 25,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: Row(
                      children: [
                        Icon(Icons.list_alt_rounded),
                        SizedBox(width: 20),
                        Text(
                          'Transcations',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  InkWell(
                    onTap: () {
                 Get.to (
                  EditScreen());
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: Row(
                        children: [
                          Icon(Icons.edit),
                          SizedBox(width: 20),
                          Text(
                            'Edit Profile',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  InkWell(
                    onTap: () {
                      Share.share('am happy');
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: Row(
                        children: [
                          Icon(Icons.share),
                          SizedBox(width: 20),
                          Text(
                            'Share ',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: Row(
                      children: [
                        Icon(Icons.settings),
                        SizedBox(width: 20),
                        Text(
                          'Settings ',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: Row(
                      children: [
                        Icon(Icons.logout),
                        SizedBox(width: 25),
                        Text(
                          'Log Out ',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 90,
                  ),
                  const Column(
                    children: [
                      Text(
                        'Polices and privacy ',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.normal),
                      )
                    ],
                  )
                ],
              ),
            );
          } else {
            return const SizedBox(
              child: Center(
                child: Text('Please Check your Internet Connection'),
              ),
            );
          }
        }));
  }
}
