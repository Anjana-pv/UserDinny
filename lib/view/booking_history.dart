import 'package:flutter/material.dart';

class ScreenBookingHistory extends StatelessWidget {
  const ScreenBookingHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,

       title: const Text('My Bookings'),
      ),
       body: Column(
        
        children: [
          
          Expanded(
            child: ListView.builder(
              itemCount:5,
              itemBuilder: (BuildContext context, int index) {
                // return buildBookingContainer(bookings[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
   Widget buildBookingContainer(Map<String, dynamic> booking) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            booking['bookingType'],
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          const SizedBox(height: 8.0),
          Image.asset(
            booking['restaurantImage'],
            width: double.infinity,
            height: 150.0,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 8.0),
          Text(
            'Restaurant: ${booking['restaurantName']}',
            style: const TextStyle(fontSize: 16.0),
          ),
          Text(
            'Date: ${booking['date']}',
            style: const TextStyle(fontSize: 16.0),
          ),
          Text(
            'Time: ${booking['time']}',
            style: const TextStyle(fontSize: 16.0),
          ),
          Text(
            'Guest Count: ${booking['guestCount']}',
            style: const TextStyle(fontSize: 16.0),
          ),
         
        ],
      ),
    );
  }
}

