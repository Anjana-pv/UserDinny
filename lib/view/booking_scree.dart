import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_dinny/common_widgets/client_details_container.dart';
import 'package:user_dinny/common_widgets/custom_widgets.dart';
import 'package:user_dinny/common_widgets/menucard_img.dart';
import 'package:user_dinny/common_widgets/timeslot_widget.dart';
import 'package:user_dinny/controller/booking.dart';
import 'package:user_dinny/controller/calender.dart';
import 'package:user_dinny/view/booking_conformation_screen.dart';

// ignore: must_be_immutable
class BookingScreen extends StatelessWidget {

  final String id;
  final Map<String, dynamic> data;
  final Rx<String> selectedTimeSlot = ''.obs;
   GlobalKey<FormState> tableformKey = GlobalKey<FormState>();
   TimeOfDay? selectedTime;
   String? selectedTableType;
  BookingScreen({
    Key? key,
    required this.id,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = DateTime.now();
    final BookingController bookingcontroller = Get.put(BookingController());
    final NewBookingController newbooking =Get.put(NewBookingController());
    double paddingMultiplier = MediaQuery.of(context).size.width * 0.05;

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(
            data['restaurantName'] ?? '',
             style: GoogleFonts.lemon(
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ), 
          centerTitle: true,
        ),
        body: 
        Form(
          child:SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Center(
                  child: Container(
                      height: MediaQuery.of(context).size.height * 0.23,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(15)),
                      child: CachedNetworkImage(
                        imageUrl: data['profileImage'] ?? '',
                        fit: BoxFit.cover,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) =>const Center(
                       child:SizedBox(
                        width: 20.0,
                        height: 20.0,
                           child: CircularProgressIndicator(
                              color: Color.fromARGB(255, 16, 52, 18),
                              backgroundColor: Color.fromARGB(255, 252, 251, 250),
                              strokeWidth: 2.0,
                            ),
                       ),),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      )
                      ),
                ),
                const SizedBox(
                  height: 22,
                ),
                Padding(
                  padding: EdgeInsets.only(left: paddingMultiplier),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Time Slots',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Roboto'),
                                ),
                              InkWell(
                                onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                 context: context,
                                 initialDate: DateTime.now(),
                                firstDate: DateTime(2024),
                               lastDate: DateTime(2025),
                          );
                          if (pickedDate != null &&
                              pickedDate != selectedDate) {
                               selectedDate = pickedDate;
                               bookingcontroller.selectedDate(selectedDate);
                             }
                          log("$selectedDate");
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(right: 30),
                          child: Icon(Icons.calendar_month_rounded),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(left: paddingMultiplier, top: 5),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: buildTimeSlots(
                        data['startingtime'] ?? '',
                        data['endingtime'] ?? '',
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: paddingMultiplier),
                  child: const Row(
                    children: [
                      Text(
                        'Menu',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                MenuImageview(data: data),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                    padding: EdgeInsets.only(left: paddingMultiplier),
                    child: const Row(
                      children: [
                        Text(
                          'Guest count',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 180),
                        Text(
                          'Table Type',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Row(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.04,

                        width: MediaQuery.of(context).size.width * 0.25,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.0),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: newbooking.guestcounController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.people),
                            hintText: '0',
                            contentPadding: EdgeInsets.symmetric(horizontal: 7),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(width: 150),
                      DropdownButton<int>(
                          value: newbooking.selectedTableType.value,
                          items: getDropdownItems(),
                          onChanged: (int? value) {
                            newbooking.selectTableType(value);
                          }),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Detailcontainer(data: data),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                      // int? selectedTableType = bookingcontroller.selectedTableType.value;
                    //      if (selectedTableType != null &&   bookingcontroller.guestcounController.text.isNotEmpty) {
                  Get.to( BookingConfirmation(
                    restaurantName:data['restaurantName'], 
                    location: data['city'], 
                    bookingTime:selectedTime.toString(), 
                   bookingDate:bookingcontroller.selectedDate.string,
                     guestCount: newbooking.guestcounController.text,
                    restaurantId : id,
                     tableType: newbooking.selectedTableType.string,
                      email: data['email'] ?? ''));

                  // print("count$bookingcontroller.guestcounController.text");
                         
                  },
                   style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 32, 101, 68),
                    )
                    ),
                   
                     
                    
                    // int? selectedTableType =
                    //     bookingcontroller.selectedTableType.val
                         
                 
                         
                  
                  
                  
                  child: const Text(
                    '   Book Now   ',
                    style: TextStyle(color: Colors.white),
                  
                  )
                  
                )
              ]
            ),
          ),
        ),
        ),
      ),
    );
  }
}
