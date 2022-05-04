class DrawerResponse {
  List<Drawer> data;
  DrawerResponse({this.data});
  DrawerResponse.fromJson(Map<String, dynamic> json) {
    if (json['bookings'] != null) {
      data = new List<Drawer>();
      json['bookings'].forEach((v) {
        data.add(new Drawer.fromJson(v));
      });
    }
  }
}

class Drawer {
  String page;
  String name;
  Drawer({this.page, this.name});

  Drawer.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    name = json['name'];
  }
}
