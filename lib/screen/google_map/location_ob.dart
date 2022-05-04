class LocationDataResponse {
  List<LocationOb> data;

  LocationDataResponse({this.data});

  LocationDataResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<LocationOb>();
      json['data'].forEach((v) {
        data.add(new LocationOb.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LocationOb {
  int id;
  String name;
  String latitude;
  String longitude;

  LocationOb({this.id, this.name, this.latitude, this.longitude});

  LocationOb.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
