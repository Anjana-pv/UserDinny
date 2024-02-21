import 'package:get/get_connect/http/src/request/request.dart';

class BookingModel {
  final String date;
  final String time;
  final String tableType;
  final String guestCount;
  final String userId;
  final String userName;
  final String phoneNumber;
  final String resturentId;
  final String profileImage;
  final String nameofresto;
  final List manucard;
  final String startingTime;
  final String endingTime;
  final String location;
  final String city;

  BookingModel({
    required this.resturentId,
    required this.date,
    required this.time,
    required this.tableType,
    required this.guestCount,
    required this.userId,
    required this.userName,
    required this.phoneNumber,
    required this.profileImage,
    required this.nameofresto,
    required this.manucard,
    required this.startingTime,
    required this.endingTime,
    required this.location,
    required this.city,
  });
}
