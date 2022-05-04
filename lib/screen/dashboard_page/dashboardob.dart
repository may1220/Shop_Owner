class DashboardResponseOb {
  DashboardOb data;

  DashboardResponseOb({this.data});

  DashboardResponseOb.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new DashboardOb.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class DashboardOb {
  String totalShop;
  String pendingShop;
  String activeShop;
  String cancelShop;
  String totalService;
  String activeService;
  String deactiveService;
  String totalBooking;
  String pendingBooking;
  String confirmBooking;
  String cancelBooking;

  DashboardOb(
      {this.totalShop,
      this.pendingShop,
      this.activeShop,
      this.cancelShop,
      this.totalService,
      this.activeService,
      this.deactiveService,
      this.totalBooking,
      this.pendingBooking,
      this.confirmBooking,
      this.cancelBooking});

  DashboardOb.fromJson(Map<String, dynamic> json) {
    totalShop = json['totalShop'].toString();
    pendingShop = json['pendingShop'].toString();
    activeShop = json['activeShop'].toString();
    cancelShop = json['cancelShop'].toString();
    totalService = json['totalService'].toString();
    activeService = json['activeService'].toString();
    deactiveService = json['deactiveService'].toString();
    totalBooking = json['totalBooking'].toString();
    pendingBooking = json['pendingBooking'].toString();
    confirmBooking = json['confirmBooking'].toString();
    cancelBooking = json['cancelBooking'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalShop'] = this.totalShop;
    data['pendingShop'] = this.pendingShop;
    data['activeShop'] = this.activeShop;
    data['cancelShop'] = this.cancelShop;
    data['totalService'] = this.totalService;
    data['activeService'] = this.activeService;
    data['deactiveService'] = this.deactiveService;
    data['totalBooking'] = this.totalBooking;
    data['pendingBooking'] = this.pendingBooking;
    data['confirmBooking'] = this.confirmBooking;
    data['cancelBooking'] = this.cancelBooking;
    return data;
  }
}
