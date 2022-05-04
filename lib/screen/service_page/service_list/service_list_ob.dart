class ServiceListResponseOb {
  List<ServicesOb> services;
  int count;

  ServiceListResponseOb({this.services, this.count});

  ServiceListResponseOb.fromJson(Map<String, dynamic> json) {
    if (json['services'] != null) {
      services = new List<ServicesOb>();
      json['services'].forEach((v) {
        services.add(new ServicesOb.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.services != null) {
      data['services'] = this.services.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class ServicesOb {
  int id;
  String title;
  String referredServiceId;
  String shopId;
  String businessType;
  String price;
  String allowCancel;
  String autoConfirm;
  String allowBookingMaxDayAgo;
  String serviceDuration;
  String bufferTime;
  String multipleBookings;
  String availableSeat;
  String description;
  String serviceDurationType;
  String serviceStarts;
  String serviceEnds;
  String serviceStartingDate;
  String serviceEndingDate;
  String maxBooking;
  String alias;
  String createdBy;
  String activation;
  String considerChildrenForPrice;
  String ageRange;
  String percentage;
  String breakTime;
  String createdAt;
  String updatedAt;
  int used;
  String image;
  bool ownerShop;
  bool ownerService;

  ServicesOb(
      {this.id,
      this.title,
      this.referredServiceId,
      this.shopId,
      this.businessType,
      this.price,
      this.allowCancel,
      this.autoConfirm,
      this.allowBookingMaxDayAgo,
      this.serviceDuration,
      this.bufferTime,
      this.multipleBookings,
      this.availableSeat,
      this.description,
      this.serviceDurationType,
      this.serviceStarts,
      this.serviceEnds,
      this.serviceStartingDate,
      this.serviceEndingDate,
      this.maxBooking,
      this.alias,
      this.createdBy,
      this.activation,
      this.considerChildrenForPrice,
      this.ageRange,
      this.percentage,
      this.breakTime,
      this.createdAt,
      this.updatedAt,
      this.used,
      this.image,
      this.ownerShop,
      this.ownerService});

  ServicesOb.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    referredServiceId = json['referred_service_id'];
    shopId = json['shop_id'];
    businessType = json['business_type'];
    price = json['price'];
    allowCancel = json['allow_cancel'];
    autoConfirm = json['auto_confirm'];
    allowBookingMaxDayAgo = json['allow_booking_max_day_ago'];
    serviceDuration = json['service_duration'];
    bufferTime = json['buffer_time'];
    multipleBookings = json['multiple_bookings'];
    availableSeat = json['available_seat'];
    description = json['description'];
    serviceDurationType = json['service_duration_type'];
    serviceStarts = json['service_starts'];
    serviceEnds = json['service_ends'];
    serviceStartingDate = json['service_starting_date'];
    serviceEndingDate = json['service_ending_date'];
    maxBooking = json['max_booking'];
    alias = json['alias'];
    createdBy = json['created_by'];
    activation = json['activation'];
    considerChildrenForPrice = json['consider_children_for_price'];
    ageRange = json['age_range'];
    percentage = json['percentage'];
    breakTime = json['break_time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    used = json['used'];
    image = json['image'];
    ownerShop = json['owner_shop'];
    ownerService = json['owner_service'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['referred_service_id'] = this.referredServiceId;
    data['shop_id'] = this.shopId;
    data['business_type'] = this.businessType;
    data['price'] = this.price;
    data['allow_cancel'] = this.allowCancel;
    data['auto_confirm'] = this.autoConfirm;
    data['allow_booking_max_day_ago'] = this.allowBookingMaxDayAgo;
    data['service_duration'] = this.serviceDuration;
    data['buffer_time'] = this.bufferTime;
    data['multiple_bookings'] = this.multipleBookings;
    data['available_seat'] = this.availableSeat;
    data['description'] = this.description;
    data['service_duration_type'] = this.serviceDurationType;
    data['service_starts'] = this.serviceStarts;
    data['service_ends'] = this.serviceEnds;
    data['service_starting_date'] = this.serviceStartingDate;
    data['service_ending_date'] = this.serviceEndingDate;
    data['max_booking'] = this.maxBooking;
    data['alias'] = this.alias;
    data['created_by'] = this.createdBy;
    data['activation'] = this.activation;
    data['consider_children_for_price'] = this.considerChildrenForPrice;
    data['age_range'] = this.ageRange;
    data['percentage'] = this.percentage;
    data['break_time'] = this.breakTime;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['used'] = this.used;
    data['image'] = this.image;
    data['owner_shop'] = this.ownerShop;
    data['owner_service'] = this.ownerService;
    return data;
  }
}
