import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:user_dinny/controller/booking_controller.dart';

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
                true; // Set isSelected to true
          },
          child: CustomElevatedButton(
            selectedTime: '$formattedStartTime - $formattedEndTime',
            isSelected: false.obs,
            prassedtime: prassedtime,
            index: index,
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
    required this.index,
  }) : super(key: key);

  final String selectedTime;
  RxBool isSelected;
  final String? prassedtime;
  final int index;
  @override
  Widget build(BuildContext context) {
    if (prassedtime != null && selectedTime == prassedtime) {
      isSelected.value = !isSelected.value;
    }
    return ElevatedButton( 
        onPressed: () {
          timeSlotController.selectedTimeSlot.value = selectedTime;
          isSelected.value = !isSelected.value;   
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith(
            (Set<MaterialState> states) => isSelected.value
                ? const Color.fromARGB(255, 122, 162, 118)
                : const Color.fromARGB(255, 236, 239, 242),
          ),
        ),
        child: Text(
          selectedTime,
          style: TextStyle(
              color: isSelected.value
                  ? Colors.white
                  : const Color.fromARGB(255, 19, 85, 21)),
        ),
      );
  }
}
