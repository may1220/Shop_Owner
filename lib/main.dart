import 'package:flutter/material.dart';
// import 'package:shop_owner/screen/booking_detail_screen.dart';
// import 'package:shop_owner/screen/booking_list_screen.dart';
// import 'package:shop_owner/screen/break_time_screen.dart';
// import 'package:shop_owner/screen/dashboard_screen.dart';
// import 'package:shop_owner/screen/edit_profile_screen.dart';
// import 'package:shop_owner/screen/holiday_screen.dart';
// import 'package:shop_owner/screen/editservice_screen.dart';
import 'package:shop_owner/screen/splash_page/splash_page.dart';

import 'screen/booking_page/booking_list/booking_list_screen.dart';
import 'screen/dashboard_page/dashboard_screen.dart';
import 'screen/google_map/google_map_screen.dart';
import 'screen/service_page/service_list/services_list_screen.dart';
import 'screen/shop_page/shop_list/shop_list_screen.dart';
// import 'package:shop_owner/screen/off_day_screen.dart';
// import 'package:shop_owner/screen/payment_screen.dart';
// import 'package:shop_owner/screen/report_screen.dart';
// import 'package:shop_owner/screen/service_view_screen.dart';
// import 'package:shop_owner/screen/services_screen.dart';
// import 'package:shop_owner/screen/stafflist_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => SplashPage(),
        '/dashboard': (context) => DashboardScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/service': (context) => ServicesScreen(),
        '/shop': (context) => ShopListScreen(),
        '/bookinglist': (context) => BookingListScreen(),
        '/googlemap': (context) => GoogleMapScreen(),
      },
      initialRoute: '/',
    );
  }
}
