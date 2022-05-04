class BookingDetailResponse {
  BookingDetailOb data;

  BookingDetailResponse({this.data});

  BookingDetailResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new BookingDetailOb.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class BookingDetailOb {
  String customerFirstname;
  String customerLastname;
  String customerEmail;
  String customerPhone;
  String shopName;
  String shopAlias;
  String shopPhone;
  String shopEmail;
  String shopDescription;
  String shopContactperson;
  String shopAddress;
  String title;
  int id;
  String status;
  String bookingDate;
  List<String> bookingTime;
  String bookingBill;
  String quantity;
  String paidAmount;
  String paymentStatus;
  String serviceId;
  String comment; //customer's comment

  BookingDetailOb(
      {this.customerFirstname,
      this.customerLastname,
      this.customerEmail,
      this.customerPhone,
      this.shopName,
      this.shopAlias,
      this.shopPhone,
      this.shopEmail,
      this.shopDescription,
      this.shopContactperson,
      this.shopAddress,
      this.title,
      this.id,
      this.status,
      this.bookingDate,
      this.bookingTime,
      this.bookingBill,
      this.quantity,
      this.paidAmount,
      this.paymentStatus,
      this.serviceId,
      this.comment});

  BookingDetailOb.fromJson(Map<String, dynamic> json) {
    customerFirstname = json['customer_firstname'];
    customerLastname = json['customer_lastname'];
    customerEmail = json['customer_email'];
    customerPhone = json['customer_phone'];
    shopName = json['shop_name'];
    shopAlias = json['shop_alias'];
    shopPhone = json['shop_phone'];
    shopEmail = json['shop_email'];
    shopDescription = json['shop_description'];
    shopContactperson = json['shop_contactperson'];
    shopAddress = json['shop_address'];
    title = json['title'];
    id = json['id'];
    status = json['status'];
    bookingDate = json['booking_date'];
    bookingTime = json['booking_time'].cast<String>();
    bookingBill = json['booking_bill'];
    quantity = json['quantity'];
    paidAmount = json['paid_amount'];
    paymentStatus = json['payment_status'];
    serviceId = json['service_id'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_firstname'] = this.customerFirstname;
    data['customer_lastname'] = this.customerLastname;
    data['customer_email'] = this.customerEmail;
    data['customer_phone'] = this.customerPhone;
    data['shop_name'] = this.shopName;
    data['shop_alias'] = this.shopAlias;
    data['shop_phone'] = this.shopPhone;
    data['shop_email'] = this.shopEmail;
    data['shop_description'] = this.shopDescription;
    data['shop_contactperson'] = this.shopContactperson;
    data['shop_address'] = this.shopAddress;
    data['title'] = this.title;
    data['id'] = this.id;
    data['status'] = this.status;
    data['booking_date'] = this.bookingDate;
    data['booking_time'] = this.bookingTime;
    data['booking_bill'] = this.bookingBill;
    data['quantity'] = this.quantity;
    data['paid_amount'] = this.paidAmount;
    data['payment_status'] = this.paymentStatus;
    data['service_id'] = this.serviceId;
    data['comment'] = this.comment;
    return data;
  }
}
