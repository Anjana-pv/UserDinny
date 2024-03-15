import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:user_dinny/controller/firebase_fuction.dart';
import 'package:user_dinny/view/screens/booking_conformation_screen.dart';
import 'package:user_dinny/view/common_widgets/client_details_container.dart';
import 'package:user_dinny/view/common_widgets/custom_widgets.dart';
import 'package:user_dinny/view/common_widgets/menucard_img.dart';
import 'package:user_dinny/view/common_widgets/timeslot_widget.dart';
import 'package:user_dinny/controller/booking_controller.dart';
import 'package:user_dinny/controller/calender_controller.dart';

GlobalKey<FormState> tableformKey = GlobalKey<FormState>();
TimeOfDay? selectedTime;
String? selectedTableType;
final Rx<String> selectedTimeSlot = ''.obs;
Rx<String> timeSlot = ''.obs;

class BookingScreen extends StatefulWidget {
  const BookingScreen({
    Key? key,
    required this.id,
    required this.data,
    required this.isModify,
    required this.bookingId, 
    required this.resId,
  }) : super(key: key);
  final String id;
  final Map<String, dynamic> data;
  final bool isModify;
  final String bookingId;
  final String resId;

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

final NewBookingController timeSlotController = Get.put(NewBookingController());

Rx<DateTime> selectedDate = DateTime.now().obs;
BookingController booking = Get.put(BookingController());
final NewBookingController newbooking = Get.put(NewBookingController());

UserController auth = Get.put(UserController());

class _BookingScreenState extends State<BookingScreen> {
  @override
  void initState() {
    Rx<String> guestcount = ''.obs;
    if (widget.isModify) {
      guestcount.value = widget.data['guest_count'] ?? '0';
      newbooking.guestcounController.text = guestcount.value;
      String dateString = widget.data['date'] ?? '';
      timeSlot.value = widget.data['time'] ?? '';

      DateTime initialDateTime = dateString.isNotEmpty
          ? DateFormat('dd MMM yyyy').parse(dateString)
          : DateTime.now();

      if (dateString.isNotEmpty) {
        selectedDate.value = initialDateTime;
      }
    }

    super.initState();
  }

  @override
  void dispose() {
    newbooking.guestcounController.text = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double paddingMultiplier = MediaQuery.of(context).size.width * 0.05;
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(
            widget.isModify
                ? widget.data['resturent_name'] ?? ''
                : widget.data['restaurantName'] ?? '',
            style: GoogleFonts.lemon(
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          centerTitle: true,
        ),
        body: Form(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(children: [
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
                        imageUrl: widget.isModify
                            ? widget.data['profile_image'] ?? ''
                            : widget.data['profileImage'] ?? '',
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
                        placeholder: (context, url) => const Center(
                          child: SizedBox(
                            width: 20.0,
                            height: 20.0,
                            child: CircularProgressIndicator(
                              color: Color.fromARGB(255, 16, 52, 18),
                              backgroundColor:
                                  Color.fromARGB(255, 252, 251, 250),
                              strokeWidth: 2.0,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      )),
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
                          String dateString = widget.data['date'] ?? '';

                          DateTime initialDateTime = dateString.isNotEmpty
                              ? DateFormat('dd MMM yyyy').parse(dateString)
                              : DateTime.now();
                          final now = DateTime.now();
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: selectedDate.value,
                            firstDate: DateTime(2024),
                            lastDate: DateTime(2025),
                            selectableDayPredicate: (DateTime day) =>
                                !day.isBefore(
                                    now.subtract(const Duration(days: 1))),
                          );

                          if (pickedDate != null &&
                              pickedDate != selectedDate) {
                            selectedDate.value = selectedDate != initialDateTime
                                ? initialDateTime
                                : pickedDate;
                            booking.selectedDate(selectedDate.value);
                          }
                          booking.formattedDate.value =
                              DateFormat('d MMM y').format(selectedDate.value);
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
                        widget.isModify
                            ? widget.data['startedtime'] ?? ''
                            : widget.data['startingtime'] ?? '',
                        widget.isModify
                            ? widget.data['endingtime'] ?? ''
                            : widget.data['endingtime'] ?? '',
                        widget.isModify ? widget.data['time'] ?? '' : null,
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
                MenuImageview(
                    menuCards: widget.isModify
                        ? widget.data['menu_cards'] ?? ''
                        : widget.data['menuCards'] ?? []),
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
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.people),
                            hintText: widget.isModify ? '' : '0',
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 7),
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
                Detailcontainer(
                  data: widget.data,
                  ismodify: widget.isModify,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                     log(widget.id);
                      final Map<String, dynamic> userData =
                          await auth.getuserdata();
                       
                        
                      Get.to(
                        BookingConfirmation(
                              
                            userData: userData,
                            restaurantName: widget.isModify
                                ? widget.data['resturent_name'] ?? ''
                                : widget.data['restaurantName'],
                            location: widget.isModify
                                ? widget.data['location'] ?? ''
                                : widget.data['address'] ?? '',
                            bookingTime: timeSlotController
                                    .selectedTimeSlot.value.isEmpty
                                ? timeSlot.value
                                : timeSlotController.selectedTimeSlot.value
                                    .toString(),
                            bookingDate: booking.formattedDate.value.isEmpty
                                ? DateFormat('d MMM y')
                                    .format(selectedDate.value)
                                  
                                 : booking.formattedDate.value,
                                
                            guestCount: newbooking.guestcounController.text,
                            restaurantId: widget.id,

                            tableType: newbooking.selectedTableType.string,
                            email: widget.isModify
                                ? ''
                                : widget.data['email'] ?? '',
                            profileImage: widget.isModify
                                ? widget.data['profile_image'] ?? ''
                                : widget.data['profileImage'] ?? '',
                            manucard: widget.isModify
                                ? widget.data['menu_cards'] ?? []
                                : widget.data['menuCards'] ?? [],
                            endingTime: widget.data['endingtime'] ?? '',
                            startingTime: widget.data['startingtime'] ?? '',
                            city: widget.data['city'] ?? '',
                            isModify: widget.isModify,
                            bookingId: widget.bookingId,
                             resturendbokingId:widget.isModify
                                ? widget.data['booking_id']:null),
                          
                      );
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 32, 101, 68),
                    )),
                    child: Text(
                      widget.isModify ? "Update Booking" : '   Book Now   ',
                      style: const TextStyle(color: Colors.white),
                    )
                    
                     )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
