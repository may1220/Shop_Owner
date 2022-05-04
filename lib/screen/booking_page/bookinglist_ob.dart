class BookingListResponseOb {
  List<Bookinglistob> bookings;
  int count;

  BookingListResponseOb({this.bookings, this.count});

  BookingListResponseOb.fromJson(Map<String, dynamic> json) {
    if (json['bookings'] != null) {
      bookings = new List<Bookinglistob>();
      json['bookings'].forEach((v) {
        bookings.add(new Bookinglistob.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bookings != null) {
      data['bookings'] = this.bookings.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class Bookinglistob {
  String title;
  int id;
  String bookingUser;
  String status;
  String bookingDate;
  List<dynamic> bookingTime;
  String bookingBill;
  String quantity;
  String paidAmount;
  String paymentStatus;
  String fullName;
  bool ownerService;

  Bookinglistob(
      {this.title,
      this.id,
      this.bookingUser,
      this.status,
      this.bookingDate,
      this.bookingTime,
      this.bookingBill,
      this.quantity,
      this.paidAmount,
      this.paymentStatus,
      this.fullName,
      this.ownerService});

  Bookinglistob.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    id = json['id'];
    bookingUser = json['booking_user'];
    status = json['status'];
    bookingDate = json['booking_date'];
    bookingTime = json['booking_time'];
    bookingBill = json['booking_bill'];
    quantity = json['quantity'];
    paidAmount = json['paid_amount'];
    paymentStatus = json['payment_status'];
    fullName = json['full_name'];
    ownerService = json['owner_service'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['id'] = this.id;
    data['booking_user'] = this.bookingUser;
    data['status'] = this.status;
    data['booking_date'] = this.bookingDate;
    data['booking_time'] = this.bookingTime;
    data['booking_bill'] = this.bookingBill;
    data['quantity'] = this.quantity;
    data['paid_amount'] = this.paidAmount;
    data['payment_status'] = this.paymentStatus;
    data['full_name'] = this.fullName;
    data['owner_service'] = this.ownerService;
    return data;
  }
}
