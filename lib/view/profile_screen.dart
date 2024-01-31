import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
      double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
     body: Column(
      children: [
        Container(
         height: screenHeight * 0.3, // Adjust the height based on screen height
            width: screenWidth * 0.9, 
          decoration:BoxDecoration(
            image: DecorationImage(
              image: AssetImage(''),
              fit: BoxFit.cover),
          ) ,

        ),
        Row(
          children: [
            Icon(Icons.dinner_dining),
            Text('Bookings'),
            
          ],
        
        
        ),
        SizedBox(height: 20,),
           Row(
          children: [
            Icon(Icons.free_cancellation_sharp),
            Text('Cancelation'),
            
          ],
           ),
              Row(
          children: [
            Icon(Icons.privacy_tip),
            Text('privacy and polices'),
            
          ],
        
        
        ),
          Row(
          children: [
            Icon(Icons.logout),
            Text('Log Out'),
            
          ],
        
        
        
        ),
      ]
      ),
    );
  }
}