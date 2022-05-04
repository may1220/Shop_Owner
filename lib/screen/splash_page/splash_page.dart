import 'package:shop_owner/helpers/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:shop_owner/screen/dashboard_page/dashboard_screen.dart';
import 'package:shop_owner/screen/login_page/login_screen.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2), () async {
      await SharedPref.getData(key: SharedPref.token).then((token) {
        print("Token key => $token");
        if (token.toString() != "null" && token != null) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) {
            return DashboardScreen();
          }), (route) => false);
        } else {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) {
            return LoginScreen();
          }), (route) => false);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              SizedBox(width: 15),
              Image(
                  image: AssetImage(
                    'assets/images/beaute-logo-only-blue.png',
                  ),
                  height: 120,
                  width: 150),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "BEAUTE",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF68409B),
                        fontSize: 45,
                        letterSpacing: 2),
                  ),
                  Text(
                    "A RIGHT CHOICE FOR YOUR BEAUTY",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
