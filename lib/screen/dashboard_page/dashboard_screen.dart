import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_owner/helpers/response_ob.dart';
import 'package:shop_owner/screen/common_widget/appbar_screen.dart';
import 'package:shop_owner/screen/dashboard_page/dashboard_bloc.dart';
import 'package:shop_owner/screen/dashboard_page/dashboardob.dart';
import 'package:shop_owner/screen/drawer_page/drawer.dart';
import 'package:shop_owner/screen/profile_page/profile_bloc.dart';
import 'package:shop_owner/helpers/styleguide.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var searchController = "Dashboard";
  var _bloc = DashboardBloc();
  final _profileBloc = ProfileBloc();
  List<String> category = [
    "Booking Status",
    "Service Status",
    "Customer Status"
  ];
  List<Map<String, dynamic>> dataList = [
    {
      "id": 1,
      "bookingTime": "Today",
      "status": "Confirmed",
      "statusno": "43",
      "total": "Total",
      "netTotal": "1204",
      "color": Colors.blue,
      "point": "0.0,2.0"
    },
    {
      "id": 2,
      "bookingTime": "This Month",
      "status": "Confirmed",
      "statusno": "43",
      "total": "Total",
      "netTotal": "1204",
      "color": color,
      "point": "0.0,2.0"
    },
    {
      "id": 3,
      "bookingTime": "Last Month",
      "status": "Confirmed",
      "statusno": "43",
      "total": "Total",
      "netTotal": "1204",
      "color": Colors.green,
      "point": "0.0,2.0"
    },
    {
      "id": 4,
      "bookingTime": "Till Now",
      "status": "Confirmed",
      "statusno": "43",
      "total": "Total",
      "netTotal": "1204",
      "color": Colors.red,
      "point": "0.0,2.0"
    },
    {
      "id": 5,
      "bookingTime": "Today",
      "status": "Confirmed",
      "statusno": "43",
      "total": "Total",
      "netTotal": "1204",
      "color": Colors.blue,
      "point": "0.0,2.0"
    }
  ];
  @override
  void initState() {
    super.initState();
    _bloc.dashboard();
    _profileBloc.getProfile();
    _setText();
  }

  void _setText() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString('appbartext', 'Dashboards');
    });
  }

  List<Color> gradientColors = [
    Colors.white10,
    Colors.white10,
  ];

  Future<bool> showExitPopup() async {
    return await showDialog(
          //show confirm dialogue
          //the return value will be from "Yes" or "No" options
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Exit App'),
            content: Text('Do you want to exit from App?'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                //return false when click on "NO"
                child: Text('No'),
                style: ElevatedButton.styleFrom(primary: color),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                //return true when click on "Yes"
                child: Text('Yes'),
                style: ElevatedButton.styleFrom(primary: color),
              ),
            ],
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
  }

  int selectedIndex = 0;
  var data = [0.0, 0.1, 0.1, 0.2, 0.1, 0.3, 0.1, -0.1];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: showExitPopup,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: BaseAppBar(title: 'Dashboards', appBar: AppBar()),
          drawer: DrawerScreen(),
          body: StreamBuilder<ResponseOb>(
            builder: (context, snapshot) {
              ResponseOb resp = snapshot.data;
              if (resp.message == MsgState.loading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: color,
                  ),
                );
              } else if (resp.message == MsgState.errors) {
                return Center(
                  child: Text("Something Wrong, try again!",
                      style: TextStyle(color: Colors.white)),
                );
              } else {
                DashboardOb dashboardOb = resp.data;
                return ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.8),
                            spreadRadius: 4,
                            blurRadius: 3,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 2.0),
                            child: Text(
                              "SHOP STATISTICS",
                              style: dashboardTitleText,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 90,
                                  margin:
                                      EdgeInsets.only(top: 5.0, right: 10.0),
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  foregroundDecoration: new BoxDecoration(
                                    color: Colors.white30,
                                  ),
                                  child: Stack(
                                    children: [
                                      Container(
                                        child: LineChart(
                                          LineChartData(
                                              maxX: 11,
                                              minX: 0,
                                              minY: 0,
                                              maxY: 8,
                                              titlesData: FlTitlesData(
                                                show: false,
                                              ),
                                              lineTouchData: LineTouchData(
                                                enabled: false,
                                              ),
                                              gridData: FlGridData(
                                                show: false,
                                                getDrawingHorizontalLine:
                                                    (value) {
                                                  return FlLine(
                                                    color: Colors.transparent,
                                                    strokeWidth: 1,
                                                  );
                                                },
                                                drawVerticalLine: false,
                                                getDrawingVerticalLine:
                                                    (value) {
                                                  return FlLine(
                                                    color: Colors.transparent,
                                                    strokeWidth: 1,
                                                  );
                                                },
                                              ),
                                              borderData: FlBorderData(
                                                show: false,
                                                border: Border.all(
                                                    color: Colors.transparent,
                                                    width: 1),
                                              ),
                                              lineBarsData: [
                                                LineChartBarData(
                                                  spots: [
                                                    FlSpot(0, 2),
                                                    FlSpot(2.0, 3.3),
                                                    FlSpot(3.5, 3.3),
                                                    FlSpot(5.0, 4.2),
                                                    FlSpot(6.4, 3.5),
                                                    FlSpot(8.0, 6.9),
                                                    FlSpot(10.4, 3.7),
                                                    FlSpot(11, 2.5),
                                                  ],
                                                  // isCurved: true,
                                                  colors: gradientColors,
                                                  barWidth: 0,
                                                  dotData:
                                                      FlDotData(show: false),
                                                  belowBarData: BarAreaData(
                                                    show: true,
                                                    colors: gradientColors
                                                        .map((color) => color
                                                            .withOpacity(0.3))
                                                        .toList(),
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              dashboardOb.totalShop.toString(),
                                              style: dashboardTextStyle,
                                            ),
                                            Text(
                                              'Total Shops',
                                              style: dashboardTextStyle,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 90,
                                  margin: EdgeInsets.only(
                                    top: 5.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: color,
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  foregroundDecoration: new BoxDecoration(
                                    color: Colors.white30,
                                  ),
                                  child: Stack(
                                    children: [
                                      Container(
                                        child: LineChart(
                                          LineChartData(
                                              maxX: 11,
                                              minX: 0,
                                              minY: 0,
                                              maxY: 8,
                                              titlesData: FlTitlesData(
                                                show: false,
                                              ),
                                              lineTouchData: LineTouchData(
                                                enabled: false,
                                              ),
                                              gridData: FlGridData(
                                                // show: true,
                                                getDrawingHorizontalLine:
                                                    (value) {
                                                  return FlLine(
                                                    color: Colors.transparent,
                                                    strokeWidth: 1,
                                                  );
                                                },
                                                // drawVerticalLine: true,
                                                getDrawingVerticalLine:
                                                    (value) {
                                                  return FlLine(
                                                    color: Colors.transparent,
                                                    strokeWidth: 1,
                                                  );
                                                },
                                              ),
                                              borderData: FlBorderData(
                                                show: true,
                                                border: Border.all(
                                                    color: Colors.transparent,
                                                    width: 1),
                                              ),
                                              lineBarsData: [
                                                LineChartBarData(
                                                  spots: [
                                                    FlSpot(0, 2),
                                                    FlSpot(2.0, 3.3),
                                                    FlSpot(3.5, 3.3),
                                                    FlSpot(5.0, 4.2),
                                                    FlSpot(6.4, 3.5),
                                                    FlSpot(8.0, 6.9),
                                                    FlSpot(10.4, 3.7),
                                                    FlSpot(11, 2.5),
                                                  ],
                                                  // isCurved: true,
                                                  colors: gradientColors,
                                                  barWidth: 0,
                                                  dotData:
                                                      FlDotData(show: false),
                                                  belowBarData: BarAreaData(
                                                    show: true,
                                                    colors: gradientColors
                                                        .map((color) => color
                                                            .withOpacity(0.3))
                                                        .toList(),
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              dashboardOb.pendingShop
                                                  .toString(),
                                              style: dashboardTextStyle,
                                            ),
                                            Text(
                                              'Shop Pending',
                                              style: dashboardTextStyle,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 90,
                                  margin:
                                      EdgeInsets.only(top: 5.0, right: 10.0),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  foregroundDecoration: new BoxDecoration(
                                    color: Colors.white30,
                                  ),
                                  child: Stack(
                                    children: [
                                      Container(
                                        child: LineChart(
                                          LineChartData(
                                              maxX: 11,
                                              minX: 0,
                                              minY: 0,
                                              maxY: 8,
                                              titlesData: FlTitlesData(
                                                show: false,
                                              ),
                                              lineTouchData: LineTouchData(
                                                enabled: false,
                                              ),
                                              gridData: FlGridData(
                                                show: false,
                                                getDrawingHorizontalLine:
                                                    (value) {
                                                  return FlLine(
                                                    color: Colors.transparent,
                                                    strokeWidth: 1,
                                                  );
                                                },
                                                drawVerticalLine: false,
                                                getDrawingVerticalLine:
                                                    (value) {
                                                  return FlLine(
                                                    color: Colors.transparent,
                                                    strokeWidth: 1,
                                                  );
                                                },
                                              ),
                                              borderData: FlBorderData(
                                                show: false,
                                                border: Border.all(
                                                    color: Colors.transparent,
                                                    width: 1),
                                              ),
                                              lineBarsData: [
                                                LineChartBarData(
                                                  spots: [
                                                    FlSpot(0, 2),
                                                    FlSpot(2.0, 3.3),
                                                    FlSpot(3.5, 3.3),
                                                    FlSpot(5.0, 4.2),
                                                    FlSpot(6.4, 3.5),
                                                    FlSpot(8.0, 6.9),
                                                    FlSpot(10.4, 3.7),
                                                    FlSpot(11, 2.5),
                                                  ],
                                                  // isCurved: true,
                                                  colors: gradientColors,
                                                  barWidth: 0,
                                                  dotData:
                                                      FlDotData(show: false),
                                                  belowBarData: BarAreaData(
                                                    show: true,
                                                    colors: gradientColors
                                                        .map((color) => color
                                                            .withOpacity(0.3))
                                                        .toList(),
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              dashboardOb.activeShop.toString(),
                                              style: dashboardTextStyle,
                                            ),
                                            Text(
                                              'Shop Active',
                                              style: dashboardTextStyle,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 90,
                                  margin: EdgeInsets.only(
                                    top: 5.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.pink,
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  foregroundDecoration: new BoxDecoration(
                                    color: Colors.white30,
                                  ),
                                  child: Stack(
                                    children: [
                                      Container(
                                        child: LineChart(
                                          LineChartData(
                                              maxX: 11,
                                              minX: 0,
                                              minY: 0,
                                              maxY: 8,
                                              titlesData: FlTitlesData(
                                                show: false,
                                              ),
                                              lineTouchData: LineTouchData(
                                                enabled: false,
                                              ),
                                              gridData: FlGridData(
                                                // show: true,
                                                getDrawingHorizontalLine:
                                                    (value) {
                                                  return FlLine(
                                                    color: Colors.transparent,
                                                    strokeWidth: 1,
                                                  );
                                                },
                                                // drawVerticalLine: true,
                                                getDrawingVerticalLine:
                                                    (value) {
                                                  return FlLine(
                                                    color: Colors.transparent,
                                                    strokeWidth: 1,
                                                  );
                                                },
                                              ),
                                              borderData: FlBorderData(
                                                show: true,
                                                border: Border.all(
                                                    color: Colors.transparent,
                                                    width: 1),
                                              ),
                                              lineBarsData: [
                                                LineChartBarData(
                                                  spots: [
                                                    FlSpot(0, 2),
                                                    FlSpot(2.0, 3.3),
                                                    FlSpot(3.5, 3.3),
                                                    FlSpot(5.0, 4.2),
                                                    FlSpot(6.4, 3.5),
                                                    FlSpot(8.0, 6.9),
                                                    FlSpot(10.4, 3.7),
                                                    FlSpot(11, 2.5),
                                                  ],
                                                  // isCurved: true,
                                                  colors: gradientColors,
                                                  barWidth: 0,
                                                  dotData:
                                                      FlDotData(show: false),
                                                  belowBarData: BarAreaData(
                                                    show: true,
                                                    colors: gradientColors
                                                        .map((color) => color
                                                            .withOpacity(0.3))
                                                        .toList(),
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              dashboardOb.cancelShop.toString(),
                                              style: dashboardTextStyle,
                                            ),
                                            Text(
                                              'Shop Cancel',
                                              style: dashboardTextStyle,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 5, left: 10.0, bottom: 5.0, right: 10.0),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.8),
                            spreadRadius: 4,
                            blurRadius: 3,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 2.0),
                            child: Text(
                              "SERVICE STATISTICS",
                              style: dashboardTitleText,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 90,
                                  margin:
                                      EdgeInsets.only(top: 5.0, right: 10.0),
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  foregroundDecoration: new BoxDecoration(
                                    color: Colors.white30,
                                  ),
                                  child: Stack(
                                    children: [
                                      Container(
                                        child: LineChart(
                                          LineChartData(
                                              maxX: 11,
                                              minX: 0,
                                              minY: 0,
                                              maxY: 8,
                                              titlesData: FlTitlesData(
                                                show: false,
                                              ),
                                              lineTouchData: LineTouchData(
                                                enabled: false,
                                              ),
                                              gridData: FlGridData(
                                                show: false,
                                                getDrawingHorizontalLine:
                                                    (value) {
                                                  return FlLine(
                                                    color: Colors.transparent,
                                                    strokeWidth: 1,
                                                  );
                                                },
                                                drawVerticalLine: false,
                                                getDrawingVerticalLine:
                                                    (value) {
                                                  return FlLine(
                                                    color: Colors.transparent,
                                                    strokeWidth: 1,
                                                  );
                                                },
                                              ),
                                              borderData: FlBorderData(
                                                show: false,
                                                border: Border.all(
                                                    color: Colors.transparent,
                                                    width: 1),
                                              ),
                                              lineBarsData: [
                                                LineChartBarData(
                                                  spots: [
                                                    FlSpot(0, 2),
                                                    FlSpot(2.0, 3.3),
                                                    FlSpot(3.5, 3.3),
                                                    FlSpot(5.0, 4.2),
                                                    FlSpot(6.4, 3.5),
                                                    FlSpot(8.0, 6.9),
                                                    FlSpot(10.4, 3.7),
                                                    FlSpot(11, 2.5),
                                                  ],
                                                  // isCurved: true,
                                                  colors: gradientColors,
                                                  barWidth: 0,
                                                  dotData:
                                                      FlDotData(show: false),
                                                  belowBarData: BarAreaData(
                                                    show: true,
                                                    colors: gradientColors
                                                        .map((color) => color
                                                            .withOpacity(0.3))
                                                        .toList(),
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Column(children: [
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  dashboardOb.totalService
                                                      .toString(),
                                                  style: dashboardTextStyle,
                                                ),
                                                Text(
                                                  'Total Services',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: dashboardTextStyle,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 90,
                                  margin: EdgeInsets.only(
                                    top: 5.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  foregroundDecoration: new BoxDecoration(
                                    color: Colors.white30,
                                  ),
                                  child: Stack(
                                    children: [
                                      Container(
                                        child: LineChart(
                                          LineChartData(
                                              maxX: 11,
                                              minX: 0,
                                              minY: 0,
                                              maxY: 8,
                                              titlesData: FlTitlesData(
                                                show: false,
                                              ),
                                              lineTouchData: LineTouchData(
                                                enabled: false,
                                              ),
                                              gridData: FlGridData(
                                                // show: true,
                                                getDrawingHorizontalLine:
                                                    (value) {
                                                  return FlLine(
                                                    color: Colors.transparent,
                                                    strokeWidth: 1,
                                                  );
                                                },
                                                // drawVerticalLine: true,
                                                getDrawingVerticalLine:
                                                    (value) {
                                                  return FlLine(
                                                    color: Colors.transparent,
                                                    strokeWidth: 1,
                                                  );
                                                },
                                              ),
                                              borderData: FlBorderData(
                                                show: true,
                                                border: Border.all(
                                                    color: Colors.transparent,
                                                    width: 1),
                                              ),
                                              lineBarsData: [
                                                LineChartBarData(
                                                  spots: [
                                                    FlSpot(0, 2),
                                                    FlSpot(2.0, 3.3),
                                                    FlSpot(3.5, 3.3),
                                                    FlSpot(5.0, 4.2),
                                                    FlSpot(6.4, 3.5),
                                                    FlSpot(8.0, 6.9),
                                                    FlSpot(10.4, 3.7),
                                                    FlSpot(11, 2.5),
                                                  ],
                                                  // isCurved: true,
                                                  colors: gradientColors,
                                                  barWidth: 0,
                                                  dotData:
                                                      FlDotData(show: false),
                                                  belowBarData: BarAreaData(
                                                    show: true,
                                                    colors: gradientColors
                                                        .map((color) => color
                                                            .withOpacity(0.3))
                                                        .toList(),
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              dashboardOb.activeService
                                                  .toString(),
                                              style: dashboardTextStyle,
                                            ),
                                            Text(
                                              'Service Active',
                                              style: dashboardTextStyle,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 90,
                                  margin:
                                      EdgeInsets.only(top: 5.0, right: 10.0),
                                  decoration: BoxDecoration(
                                    color: Colors.pink,
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  foregroundDecoration: new BoxDecoration(
                                    color: Colors.white30,
                                  ),
                                  child: Stack(
                                    children: [
                                      Container(
                                        child: LineChart(
                                          LineChartData(
                                              maxX: 11,
                                              minX: 0,
                                              minY: 0,
                                              maxY: 8,
                                              titlesData: FlTitlesData(
                                                show: false,
                                              ),
                                              lineTouchData: LineTouchData(
                                                enabled: false,
                                              ),
                                              gridData: FlGridData(
                                                show: false,
                                                getDrawingHorizontalLine:
                                                    (value) {
                                                  return FlLine(
                                                    color: Colors.transparent,
                                                    strokeWidth: 1,
                                                  );
                                                },
                                                drawVerticalLine: false,
                                                getDrawingVerticalLine:
                                                    (value) {
                                                  return FlLine(
                                                    color: Colors.transparent,
                                                    strokeWidth: 1,
                                                  );
                                                },
                                              ),
                                              borderData: FlBorderData(
                                                show: false,
                                                border: Border.all(
                                                    color: Colors.transparent,
                                                    width: 1),
                                              ),
                                              lineBarsData: [
                                                LineChartBarData(
                                                  spots: [
                                                    FlSpot(0, 2),
                                                    FlSpot(2.0, 3.3),
                                                    FlSpot(3.5, 3.3),
                                                    FlSpot(5.0, 4.2),
                                                    FlSpot(6.4, 3.5),
                                                    FlSpot(8.0, 6.9),
                                                    FlSpot(10.4, 3.7),
                                                    FlSpot(11, 2.5),
                                                  ],
                                                  // isCurved: true,
                                                  colors: gradientColors,
                                                  barWidth: 0,
                                                  dotData:
                                                      FlDotData(show: false),
                                                  belowBarData: BarAreaData(
                                                    show: true,
                                                    colors: gradientColors
                                                        .map((color) => color
                                                            .withOpacity(0.3))
                                                        .toList(),
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              dashboardOb.deactiveService
                                                  .toString(),
                                              style: dashboardTextStyle,
                                            ),
                                            Text(
                                              'Service Deactive',
                                              style: dashboardTextStyle,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.8),
                            spreadRadius: 4,
                            blurRadius: 3,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 2.0),
                            child: Text(
                              "BOOKING STATISTICS",
                              style: dashboardTitleText,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 90,
                                  margin:
                                      EdgeInsets.only(top: 5.0, right: 10.0),
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  foregroundDecoration: new BoxDecoration(
                                    color: Colors.white30,
                                  ),
                                  child: Stack(
                                    children: [
                                      Container(
                                        child: LineChart(
                                          LineChartData(
                                              maxX: 11,
                                              minX: 0,
                                              minY: 0,
                                              maxY: 8,
                                              titlesData: FlTitlesData(
                                                show: false,
                                              ),
                                              lineTouchData: LineTouchData(
                                                enabled: false,
                                              ),
                                              gridData: FlGridData(
                                                show: false,
                                                getDrawingHorizontalLine:
                                                    (value) {
                                                  return FlLine(
                                                    color: Colors.transparent,
                                                    strokeWidth: 1,
                                                  );
                                                },
                                                drawVerticalLine: false,
                                                getDrawingVerticalLine:
                                                    (value) {
                                                  return FlLine(
                                                    color: Colors.transparent,
                                                    strokeWidth: 1,
                                                  );
                                                },
                                              ),
                                              borderData: FlBorderData(
                                                show: false,
                                                border: Border.all(
                                                    color: Colors.transparent,
                                                    width: 1),
                                              ),
                                              lineBarsData: [
                                                LineChartBarData(
                                                  spots: [
                                                    FlSpot(0, 2),
                                                    FlSpot(2.0, 3.3),
                                                    FlSpot(3.5, 3.3),
                                                    FlSpot(5.0, 4.2),
                                                    FlSpot(6.4, 3.5),
                                                    FlSpot(8.0, 6.9),
                                                    FlSpot(10.4, 3.7),
                                                    FlSpot(11, 2.5),
                                                  ],
                                                  // isCurved: true,
                                                  colors: gradientColors,
                                                  barWidth: 0,
                                                  dotData:
                                                      FlDotData(show: false),
                                                  belowBarData: BarAreaData(
                                                    show: true,
                                                    colors: gradientColors
                                                        .map((color) => color
                                                            .withOpacity(0.3))
                                                        .toList(),
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              dashboardOb.totalBooking
                                                  .toString(),
                                              style: dashboardTextStyle,
                                            ),
                                            Text(
                                              'Total bookings',
                                              style: dashboardTextStyle,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 90,
                                  margin: EdgeInsets.only(
                                    top: 5.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: color,
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  foregroundDecoration: new BoxDecoration(
                                    color: Colors.white30,
                                  ),
                                  child: Stack(
                                    children: [
                                      Container(
                                        child: LineChart(
                                          LineChartData(
                                              maxX: 11,
                                              minX: 0,
                                              minY: 0,
                                              maxY: 8,
                                              titlesData: FlTitlesData(
                                                show: false,
                                              ),
                                              lineTouchData: LineTouchData(
                                                enabled: false,
                                              ),
                                              gridData: FlGridData(
                                                // show: true,
                                                getDrawingHorizontalLine:
                                                    (value) {
                                                  return FlLine(
                                                    color: Colors.transparent,
                                                    strokeWidth: 1,
                                                  );
                                                },
                                                // drawVerticalLine: true,
                                                getDrawingVerticalLine:
                                                    (value) {
                                                  return FlLine(
                                                    color: Colors.transparent,
                                                    strokeWidth: 1,
                                                  );
                                                },
                                              ),
                                              borderData: FlBorderData(
                                                show: true,
                                                border: Border.all(
                                                    color: Colors.transparent,
                                                    width: 1),
                                              ),
                                              lineBarsData: [
                                                LineChartBarData(
                                                  spots: [
                                                    FlSpot(0, 2),
                                                    FlSpot(2.0, 3.3),
                                                    FlSpot(3.5, 3.3),
                                                    FlSpot(5.0, 4.2),
                                                    FlSpot(6.4, 3.5),
                                                    FlSpot(8.0, 6.9),
                                                    FlSpot(10.4, 3.7),
                                                    FlSpot(11, 2.5),
                                                  ],
                                                  // isCurved: true,
                                                  colors: gradientColors,
                                                  barWidth: 0,
                                                  dotData:
                                                      FlDotData(show: false),
                                                  belowBarData: BarAreaData(
                                                    show: true,
                                                    colors: gradientColors
                                                        .map((color) => color
                                                            .withOpacity(0.3))
                                                        .toList(),
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              dashboardOb.pendingBooking
                                                  .toString(),
                                              style: dashboardTextStyle,
                                            ),
                                            Text(
                                              'Booking pending',
                                              style: dashboardTextStyle,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 90,
                                  margin:
                                      EdgeInsets.only(top: 5.0, right: 10.0),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  foregroundDecoration: new BoxDecoration(
                                    color: Colors.white30,
                                  ),
                                  child: Stack(
                                    children: [
                                      Container(
                                        child: LineChart(
                                          LineChartData(
                                              maxX: 11,
                                              minX: 0,
                                              minY: 0,
                                              maxY: 8,
                                              titlesData: FlTitlesData(
                                                show: false,
                                              ),
                                              lineTouchData: LineTouchData(
                                                enabled: false,
                                              ),
                                              gridData: FlGridData(
                                                show: false,
                                                getDrawingHorizontalLine:
                                                    (value) {
                                                  return FlLine(
                                                    color: Colors.transparent,
                                                    strokeWidth: 1,
                                                  );
                                                },
                                                drawVerticalLine: false,
                                                getDrawingVerticalLine:
                                                    (value) {
                                                  return FlLine(
                                                    color: Colors.transparent,
                                                    strokeWidth: 1,
                                                  );
                                                },
                                              ),
                                              borderData: FlBorderData(
                                                show: false,
                                                border: Border.all(
                                                    color: Colors.transparent,
                                                    width: 1),
                                              ),
                                              lineBarsData: [
                                                LineChartBarData(
                                                  spots: [
                                                    FlSpot(0, 2),
                                                    FlSpot(2.0, 3.3),
                                                    FlSpot(3.5, 3.3),
                                                    FlSpot(5.0, 4.2),
                                                    FlSpot(6.4, 3.5),
                                                    FlSpot(8.0, 6.9),
                                                    FlSpot(10.4, 3.7),
                                                    FlSpot(11, 2.5),
                                                  ],
                                                  // isCurved: true,
                                                  colors: gradientColors,
                                                  barWidth: 0,
                                                  dotData:
                                                      FlDotData(show: false),
                                                  belowBarData: BarAreaData(
                                                    show: true,
                                                    colors: gradientColors
                                                        .map((color) => color
                                                            .withOpacity(0.3))
                                                        .toList(),
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              dashboardOb.confirmBooking
                                                  .toString(),
                                              style: dashboardTextStyle,
                                            ),
                                            Text(
                                              'Booking confirm',
                                              style: dashboardTextStyle,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 90,
                                  margin: EdgeInsets.only(
                                    top: 5.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.pink,
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  foregroundDecoration: new BoxDecoration(
                                    color: Colors.white30,
                                  ),
                                  child: Stack(
                                    children: [
                                      Container(
                                        child: LineChart(
                                          LineChartData(
                                              maxX: 11,
                                              minX: 0,
                                              minY: 0,
                                              maxY: 8,
                                              titlesData: FlTitlesData(
                                                show: false,
                                              ),
                                              lineTouchData: LineTouchData(
                                                enabled: false,
                                              ),
                                              gridData: FlGridData(
                                                // show: true,
                                                getDrawingHorizontalLine:
                                                    (value) {
                                                  return FlLine(
                                                    color: Colors.transparent,
                                                    strokeWidth: 1,
                                                  );
                                                },
                                                // drawVerticalLine: true,
                                                getDrawingVerticalLine:
                                                    (value) {
                                                  return FlLine(
                                                    color: Colors.transparent,
                                                    strokeWidth: 1,
                                                  );
                                                },
                                              ),
                                              borderData: FlBorderData(
                                                show: true,
                                                border: Border.all(
                                                    color: Colors.transparent,
                                                    width: 1),
                                              ),
                                              lineBarsData: [
                                                LineChartBarData(
                                                  spots: [
                                                    FlSpot(0, 2),
                                                    FlSpot(2.0, 3.3),
                                                    FlSpot(3.5, 3.3),
                                                    FlSpot(5.0, 4.2),
                                                    FlSpot(6.4, 3.5),
                                                    FlSpot(8.0, 6.9),
                                                    FlSpot(10.4, 3.7),
                                                    FlSpot(11, 2.5),
                                                  ],
                                                  // isCurved: true,
                                                  colors: gradientColors,
                                                  barWidth: 0,
                                                  dotData:
                                                      FlDotData(show: false),
                                                  belowBarData: BarAreaData(
                                                    show: true,
                                                    colors: gradientColors
                                                        .map((color) => color
                                                            .withOpacity(0.3))
                                                        .toList(),
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              dashboardOb.cancelBooking
                                                  .toString(),
                                              style: dashboardTextStyle,
                                            ),
                                            Text(
                                              'Booking Cancel',
                                              style: dashboardTextStyle,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            },
            stream: _bloc.dashboardStream(),
            initialData: ResponseOb(message: MsgState.loading),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _bloc.dispose();
    super.dispose();
  }
}

class CurvedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 15;

    var path = Path();

    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.7,
        size.width * 0.5, size.height * 0.8);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9,
        size.width * 1.0, size.height * 0.8);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
