import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy for Our Dinny'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          Text(
            'At Our Dinny, we prioritize the privacy of our users. This Privacy Policy document contains types of information that is collected and recorded by Our Dinny and how we use it.',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 16.0),
          Text(
            'Collection of Personal Information',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          ListTile(
            title: Text('Username: We collect usernames to uniquely identify users within our system.'),
          ),
          ListTile(
            title: Text('Password: Passwords are collected to secure user accounts and ensure account integrity.'),
          ),
          ListTile(
            title: Text('Email: We collect email ids to ensure the identity of the user within our system.'),
          ),
          ListTile(
            title: Text('Phone Number: We collect phone numbers for communication and account verification purposes.'),
          ),
          ListTile(
            title: Text('Payment Information: We collect payment information to process transactions for table bookings.'),
          ),
          ListTile(
            title: Text('Device Information: We may collect information about the device you use to access Our Dinny, such as IP address and browser type, for analytics and security purposes.'),
          ),
          SizedBox(height: 16.0),
          Text(
            'Use of Personal Information',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          ListTile(
            title: Text('User Authentication: Email ids and passwords are used for authenticating users and securing their accounts.'),
          ),
          ListTile(
            title: Text('Booking: We collect booking information to facilitate table reservations through our app.'),
          ),
          ListTile(
            title: Text('Payment: Payment information is collected to process transactions for table bookings.'),
          ),
          ListTile(
            title: Text('Communication: We may use your contact information to communicate with you regarding your account, bookings, and important updates'),
          ),
          ListTile(
            title: Text('Improvement of Services: We may use the information collected to improve our services and user experience.'),
          ),
          SizedBox(height: 16.0),
          Text(
            'Contact Information',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          ListTile(
            title: Text('If you have any questions about this Privacy Policy, please contact us at ourdinnyofficial@gmail.com.'),
          ),
          SizedBox(height: 16.0),
          Text(
            'By using Our Dinny, you agree to the collection and use of information in accordance with this policy.',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            'https://anjana-pv.github.io/UserDinny/',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PrivacyPolicyScreen(),
  ));
}
