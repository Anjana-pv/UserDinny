import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_dinny/controller/profile_controller.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({
    super.key,
    required this.username,
    required this.emailid,
    required this.phonenumber,
  });
  final String username;
  final String emailid;
  final String phonenumber;

  @override
  Widget build(BuildContext context) {
    ProfileController getuserdata=Get.put(ProfileController());
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: size.height * 0.30,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assest/images/profile image.png'),
                      fit: BoxFit.cover),
                ),
              ),
              const Positioned(
                top: 100,
                left: 0,
                right: 0,
                child: Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage(
                          'assest/images/blank-profile-picture-973460-1-1-1080x1080.png',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const  EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: TextEditingController(text: username),
                        decoration: const InputDecoration(
                           labelText: 'Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              
            
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: TextEditingController(text: emailid),
                    decoration: const InputDecoration(
                      labelText: 'Email ID',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: TextEditingController(text: phonenumber),
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(),
                      
                    )
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.only(top: 200, left: 17, right: 8),
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 3, 81, 12)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  minimumSize:
                      MaterialStateProperty.all<Size>(const Size(double.infinity, 50)),
                ),
                child:
                    const Text('Save Changes', style: TextStyle(color: Colors.white)),
              ),
            )
                    ],
                  ),
          ),
        ],
      )

    );
  }
}