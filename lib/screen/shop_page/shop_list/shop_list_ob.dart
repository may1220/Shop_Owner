class ShopListResponseOb {
  List<ShopListOb> shops;
  int count;

  ShopListResponseOb({this.shops, this.count});

  ShopListResponseOb.fromJson(Map<String, dynamic> json) {
    if (json['shops'] != null) {
      shops = new List<ShopListOb>();
      json['shops'].forEach((v) {
        shops.add(new ShopListOb.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shops != null) {
      data['shops'] = this.shops.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class ShopListOb {
  String firstName;
  String lastName;
  String email;
  String phone;
  int id;
  String status;
  String sname;
  String alias;
  String sphone;
  String semail;
  String sdescription;
  String contactPerson;
  String screatedAt;
  String saddress;
  String logo;
  String rname;
  String fullName;
  bool ownerShop;
  String latitude;
  String longitude;

  ShopListOb(
      {this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.id,
      this.status,
      this.sname,
      this.alias,
      this.sphone,
      this.semail,
      this.sdescription,
      this.contactPerson,
      this.screatedAt,
      this.saddress,
      this.logo,
      this.rname,
      this.fullName,
      this.ownerShop,
      this.latitude,
      this.longitude});

  ShopListOb.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    id = json['id'];
    status = json['status'];
    sname = json['sname'];
    alias = json['alias'];
    sphone = json['sphone'];
    semail = json['semail'];
    sdescription = json['sdescription'];
    contactPerson = json['contact_person'];
    screatedAt = json['screated_at'];
    saddress = json['saddress'];
    logo = json['logo'];
    rname = json['rname'];
    fullName = json['full_name'];
    ownerShop = json['owner_shop'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  bool get isEmpty => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['id'] = this.id;
    data['status'] = this.status;
    data['sname'] = this.sname;
    data['alias'] = this.alias;
    data['sphone'] = this.sphone;
    data['semail'] = this.semail;
    data['sdescription'] = this.sdescription;
    data['contact_person'] = this.contactPerson;
    data['screated_at'] = this.screatedAt;
    data['saddress'] = this.saddress;
    data['logo'] = this.logo;
    data['rname'] = this.rname;
    data['full_name'] = this.fullName;
    data['owner_shop'] = this.ownerShop;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
