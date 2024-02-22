import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:user_dinny/controller/booking.dart';

final NewBookingController timeSlotController = Get.put(NewBookingController());
List<Widget> buildTimeSlots(
    String startTime, String endTime, String? prassedtime) {
  List<Widget> timeSlotWidgets = [];

  try {
    DateFormat dateFormat = DateFormat("h:mm a");
    DateTime start = dateFormat.parse(startTime);
    DateTime end = dateFormat.parse(endTime);

    int index = 0;

    while (start.isBefore(end)) {
      String formattedStartTime = dateFormat.format(start);
      start = start.add(const Duration(hours: 1));
      String formattedEndTime = dateFormat.format(start);

      timeSlotWidgets.add(
        InkWell(
          onTap: () {
            // final newTimeSlot = '$formattedStartTime - $formattedEndTime';
            timeSlotController.isSelected.value = 
                true ; // Set isSelected to true 
            log('Selected time slot index: $index'); 
          },
          child: CustomElevatedButton(
            selectedTime: '$formattedStartTime - $formattedEndTime',
            isSelected: false.obs, 
            prassedtime: prassedtime,
          ),
        ),
      );

      timeSlotWidgets.add(const SizedBox(width: 8));
      start = start.add(const Duration(hours: 1));
      index++;
    }
  } catch (e) {
    print("Error parsing time: $e");
  }

  return timeSlotWidgets;
}

// ignore: must_be_immutable
class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton({
    Key? key,
    required this.selectedTime,
    required this.isSelected,
    this.prassedtime,
  }) : super(key: key);
 
  final String selectedTime;
  RxBool isSelected;
  final String? prassedtime;
  @override
  Widget build(BuildContext context) {
     if (prassedtime != null && selectedTime == prassedtime) {
        isSelected.value = true;
      }  
    return Obx(() {
     
      return ElevatedButton(
        onPressed: () {
          timeSlotController.selectedTimeSlot.value = selectedTime;
          isSelected.value = !isSelected.value;
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith(
            (Set<MaterialState> states) => isSelected.value
                ? const Color.fromARGB(
                    255, 47, 100, 42) 
                : const Color.fromARGB(255, 236, 239, 242), 
          ),
        ),
        child: Text(selectedTime,style: TextStyle(
          color: isSelected.value?Colors.white:const Color.fromARGB(255, 19, 85, 21)
        ),),
      );
    });
  }
}