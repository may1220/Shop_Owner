import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_owner/helpers/response_ob.dart';
import 'package:shop_owner/helpers/shared_pref.dart';
import 'package:shop_owner/screen/booking_page/booking_list/booking_list_screen.dart';
import 'package:shop_owner/screen/dashboard_page/dashboard_screen.dart';
import 'package:shop_owner/screen/drawer_page/drawer_bloc.dart';
import 'package:shop_owner/screen/login_page/login_screen.dart';
import 'package:shop_owner/screen/profile_page/profile_ob.dart';
import 'package:shop_owner/screen/service_page/service_list/services_list_screen.dart';
import 'package:shop_owner/screen/shop_page/shop_list/shop_list_screen.dart';
import 'package:shop_owner/helpers/styleguide.dart';
import 'package:shop_owner/utils/app_constants.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  var _bloc = DrawerBloc();
  List<Map<String, String>> drawerList = [
    {"page": "/dashboard", "name": "Dashboard"},
    {"page": "/service", "name": "Services"},
    {"page": "/shop", "name": "Shops"},
    {"page": "/bookinglist", "name": "Bookings"},
    {"page": "/googlemap", "name": "Google Map"},
  ];
  // "Dashboard",
  // "Services",
  // "Shops",
  // "Bookings",
  // "Staff",
  // "Setting",
  // "Report",
  // "Google Map",
  // "Logout"

  ProfileOb profileData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfile();
    _bloc.logoutStream().listen((ResponseOb resp) {
      if (resp.message == MsgState.data) {
        if (resp.data["message"] == "Successfully logged out") {
          SharedPref.clear();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) {
            return LoginScreen();
          }), (route) => false);
        }
        if (resp.message == MsgState.errors) {
          print("Error State");
          SharedPref.clear();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) {
            return LoginScreen();
          }), (route) => false);
        }
      }

      // if (resp.data['message'] == "Successfully logged out") {
      //   Navigator.of(context).pushAndRemoveUntil(
      //       MaterialPageRoute(builder: (BuildContext context) {
      //     return LoginScreen();
      //   }), (route) => false);
      // } else {
      //   Navigator.of(context).pushAndRemoveUntil(
      //       MaterialPageRoute(builder: (BuildContext context) {
      //     return LoginScreen();
      //   }), (route) => false);
      // }
    });
  }

  getProfile() {
    SharedPref.getData(key: SharedPref.profile).then((str) {
      if (str != null && str.toString() != "null") {
        setState(() {
          profileData = ProfileResponseOb.fromJson(json.decode(str)).user;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.8,
      child: Drawer(
        child: Container(
          color: color,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(top: 20.0, left: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            PROFILE_IMAGE_URL + profileData.avatar),
                        minRadius: 10,
                        maxRadius: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 7.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              profileData.fullName.toString(),
                              style: GoogleFonts.openSans(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                            Text(
                              "Shop Owner",
                              style: GoogleFonts.openSans(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w200,
                                  fontSize: 12),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Divider(color: Colors.white),
              SizedBox(height: 10),
              Expanded(
                flex: 7,
                child: ListView.builder(
                    // shrinkWrap: false,
                    // reverse: true,
                    itemCount: drawerList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(
                          drawerList[index]["name"],
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                        onTap: () {
                          // Navigator.pushNamed(
                          //     context, '${drawerList[index]["page"]}');
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '${drawerList[index]["page"]}',
                              (Route<dynamic> route) => false);
                        },
                      );
                    }),
              ),
              ElevatedButton(
                onPressed: () {
                  // SharedPref.clear();
                  _bloc.logout();
                },
                child: Text(
                  "Logout",
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1),
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white)),
              ),
            ],
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
