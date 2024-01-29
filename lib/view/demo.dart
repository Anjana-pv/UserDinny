import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key,required this.id,
    required this.data,});
   final String id;
  final Map<String, dynamic> data;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Container(
      decoration:BoxDecoration(
        image: DecorationImage(image:NetworkImage( data['profileImage'] ?? ''))
      )
      ) ,
    );
  
  }
}