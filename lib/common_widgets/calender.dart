import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_dinny/controller/booking.dart';
import 'package:user_dinny/controller/calender.dart';


class BookingDialog extends StatelessWidget {
  
   BookingDialog({super.key});
  final BookingController controller = Get.put(BookingController());

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 400,
        child: Column(
          children: [         
            ElevatedButton(
              onPressed: () {
                
                Get.back();
              },
              child: const Text('Book Date'),
            ),
          ],
        ),
      ),
    );
  }
}
