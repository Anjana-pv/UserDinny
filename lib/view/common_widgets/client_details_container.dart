
import 'package:flutter/material.dart';

class Detailcontainer extends StatelessWidget {
  const Detailcontainer({
    super.key,
    required this.data,
  });

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
                color: const Color.fromARGB(255, 70, 128, 102), 
                width: 3.0,      
              ),               
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20, top: 10),
            child: Text(
              ' Restaurant Information',
              style: TextStyle(
                color: Color.fromARGB(255, 13, 13, 13),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                const Icon(
                  Icons.restaurant,
                  color: Color.fromARGB(255, 4, 4, 4),
                  size: 16,
                ),
                const SizedBox(width: 10),
                Text(
                  ' ${data['restaurantName']}',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                const Icon(
                  Icons.access_time,
                  color: Color.fromARGB(255, 0, 0, 0),
                  size: 16,
                ),
                const SizedBox(width: 10),
                Text(
                  ' ${data['city']}',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: Color.fromARGB(255, 0, 0, 0),
                  size: 16,
                ),
                const SizedBox(width: 10),
                Text(
                  ' ${data['address']}',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 8, 8, 8),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.location_city,
                  color: Color.fromARGB(255, 0, 0, 0),
                  size: 16,
                ),
                const SizedBox(width: 10),
                Text(
                  ' ${data['workingHours']} hr',
    
                  style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}