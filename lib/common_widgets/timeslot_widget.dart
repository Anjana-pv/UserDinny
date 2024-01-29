import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

final RxBool isSelected = false.obs;

List<Widget> buildTimeSlots(String startTime, String endTime) {
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
            final newTimeSlot = '$formattedStartTime - $formattedEndTime';
            isSelected.value = true; // Set isSelected to true
            print('Selected time slot index: $index');
          },
          child: CustomElevatedButton(
            selectedTime: '$formattedStartTime - $formattedEndTime',
            isSelected: false.obs,
          ),
        ),
      );

      timeSlotWidgets.add(const SizedBox(width: 8));
      start = start.add(const Duration(hours: 1));
      index++; // Increment the index counter
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
  }) : super(key: key);

  final String selectedTime;
  RxBool isSelected;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ElevatedButton(
        onPressed: () {
          log(selectedTime);
          if (isSelected==false) {
            isSelected = true.obs;
          } else {
            isSelected = false.obs;
          }  
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith(
            (Set<MaterialState> states) => isSelected.value
                ? const Color.fromARGB(255, 255, 60, 0) // Yellow color when selected
                : const Color.fromARGB(255, 236, 239, 242), // Default color
          ),
        ),
        child: Text(selectedTime),
      );
    });
  }
}
