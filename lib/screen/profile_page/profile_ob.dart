class ProfileResponseOb {
  ProfileOb user;

  ProfileResponseOb({this.user});

  ProfileResponseOb.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new ProfileOb.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class ProfileOb {
  int id;
  String firstName;
  String lastName;
  String fullName;
  String email;
  String phone;
  String isShopowner;
  String avatar;
  String dateOfBirth;
  String gender;
  String address;

  ProfileOb(
      {this.id,
      this.firstName,
      this.lastName,
      this.fullName,
      this.email,
      this.phone,
      this.isShopowner,
      this.avatar,
      this.dateOfBirth,
      this.gender,
      this.address
      });

  ProfileOb.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    fullName = json['full_name'];
    email = json['email'];
    phone = json['phone'];
    isShopowner = json['is_shopowner'];
    avatar = json['avatar'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['is_shopowner'] = this.isShopowner;
    data['avatar'] = this.avatar;
    data['date_of_birth'] = this.dateOfBirth ;
    data['gender'] = this.gender;
    data['address'] = this.address;
    return data;
  }
}
