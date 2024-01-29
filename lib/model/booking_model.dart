class BookingModel {
  final String date;
  final String time;
  final String tableType;
  final String guestCount;
  final String userId;
  final String userName;
  final String phoneNumber;
  final String resturentId;

  BookingModel({
  required this.resturentId, 
      required this.date,
      required this.time,
      required this.tableType,
      required this.guestCount,
      required this.userId,
      required this.userName,
      required this.phoneNumber});
}
