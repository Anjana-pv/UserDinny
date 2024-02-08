

import 'package:flutter/material.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({super.key, });

  @override
  Widget build(BuildContext context) {
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
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Name'),
                    
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Email ID'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.only(top: 200, left: 17, right: 8),


            child: ElevatedButton(
              onPressed: () {
               
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 3, 81, 12)), // Set the button color
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                minimumSize: MaterialStateProperty.all<Size>(
                    Size(double.infinity, 50)), // Set the width and height
              ),
              child:
                  Text('Save Changes', style: TextStyle(color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }
}
