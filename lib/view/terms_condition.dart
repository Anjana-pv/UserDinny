import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          Text(
            'Terms and Conditions',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),
          Text(
            'By accessing this application, we assume you accept these terms and conditions. Do not continue to use Ourdinny if you do not agree to take all of the terms and conditions stated on this page.',
          ),
          SizedBox(height: 16.0),
          Text(
            'License',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text(
            'Unless otherwise stated, Ourdinny and/or its licensors own the intellectual property rights for all material on Ourdinny. All intellectual property rights are reserved. You may access this from Ourdinny for your own personal use subjected to restrictions set in these terms and conditions.',
          ),
          SizedBox(height: 16.0),
          Text(
            'Restrictions',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text(
            'You are specifically restricted from all of the following:',
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('- Publishing any material from Ourdinny in any other media.'),
                Text('- Selling, sublicensing, and/or otherwise commercializing any material from Ourdinny.'),
                Text('- Using Ourdinny in any way that is or may be damaging to this application.'),
                Text('- Using Ourdinny in any way that impacts user access to this application.'),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            'No warranties',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text(
            'This application is provided "as is," with all faults, and Ourdinny makes no express or implied representations or warranties, of any kind related to this application or the materials contained on this application. Additionally, nothing contained on Ourdinny shall be interpreted as advising you.',
          ),
          SizedBox(height: 16.0),
          Text(
            'Limitation of liability',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text(
            'In no event shall Ourdinny, nor any of its officers, directors, and employees, shall be held liable for anything arising out of or in any way connected with your use of Ourdinny, whether such liability is under contract. Ourdinny, including its officers, directors, and employees, shall not be held liable for any indirect, consequential, or special liability arising out of or in any way related to your use of Ourdinny.',
          ),
          // Add other sections as needed...
        ],
      ),
    );
  }
}