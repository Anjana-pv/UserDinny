import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: screenHeight * 0.25,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assest/images/profile image.png'),
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
                      const Text(
                        'Anjana Pv',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      const Text('9072069321',
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
            height: 20,
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
            height: 20,
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
            height: 20,
          ),

         const Padding(
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
           const SizedBox(
            height: 20,
          ),
           const Padding(
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
           const SizedBox(
            height: 20,
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
            height: 20,
          ),
           const Padding(
            padding: EdgeInsets.only(left: 25),
            child: Row(
              children: [
                Icon(Icons.logout),
                SizedBox(width: 20),
                Text(
                  'Log Out ',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 90,),


           const Column(
            children: [
              Text('Polices and privacy ',style: TextStyle(fontSize: 17,fontWeight: FontWeight.normal),)
            ],
           )

          // ),
        ],
      ),
    );
  }
}
