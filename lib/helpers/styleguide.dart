import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

String appbartext;
void _index() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  appbartext = preferences.getString('appbartext');
}

final TextStyle mapTextStyle = TextStyle(height: 1.5, fontSize: 13);

final Container profileContainer = Container(
  height: 30.0,
  width: 30.0,
  padding: EdgeInsets.zero,
  margin: EdgeInsets.only(right: 10.0),
  decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: Colors.black),
      image: DecorationImage(image: AssetImage('assets/images/user.png'))),
);

final AppBar appBar = AppBar(
  backgroundColor: Colors.white,
  elevation: 0,
  automaticallyImplyLeading: false,
  leading: Builder(
    builder: (context) => IconButton(
      icon: Image.asset(
        "assets/images/menu.png",
        height: 22,
        width: 34,
      ),
      onPressed: () => Scaffold.of(context).openDrawer(),
    ),
  ),
  title: TextField(
    controller: TextEditingController(text: appbartext),
    keyboardType: TextInputType.text,
    cursorColor: Colors.black,
    style: GoogleFonts.openSans(fontSize: 18),
    textAlign: TextAlign.center,
    enabled: false,
    decoration: InputDecoration(
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      border: InputBorder.none,
      suffix: Container(
        height: 30.0,
        width: 30.0,
        margin: EdgeInsets.only(top: 2.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black),
        ),
        child: Icon(
          Icons.search,
          color: Colors.black,
        ),
      ),
    ),
  ),
  actions: [
    GestureDetector(
      onTap: () {
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => Profile(),
        //   ),
        // );
      },
      child: profileContainer,
    ),
  ],
);

final Color color = Color(0xFF6600cc);

final TextStyle textStyle =
    GoogleFonts.openSans(color: Colors.white, fontWeight: FontWeight.bold);

final TextStyle numberStyle = GoogleFonts.openSans(
    color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17);

final TextStyle dashboardTextStyle = GoogleFonts.openSans(
    color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17);

final TextStyle serviceTitleText = GoogleFonts.openSans(
    color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15);

final TextStyle dashboardTitleText = GoogleFonts.openSans(
    color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16);

final TextStyle serviceDataText =
    GoogleFonts.openSans(color: Colors.black87, fontSize: 14);

final TextStyle dotStyle = GoogleFonts.openSans(color: Colors.black54);

final BoxDecoration cardShawdowDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(20.0),
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withOpacity(0.8),
      spreadRadius: 5,
      blurRadius: 7,
      offset: Offset(0, 5), // changes position of shadow
    ),
  ],
);

final EdgeInsets cardPadding =
    EdgeInsets.only(top: 8.0, bottom: 8.0, right: 10.0, left: 10.0);

final BoxDecoration boxDecoration = BoxDecoration(
  color: Colors.grey[200],
  borderRadius: BorderRadius.circular(10),
);

final Color fillColor = Colors.grey[200];

final EdgeInsets edgeInsets =
    EdgeInsets.only(top: 8.0, bottom: 8.0, right: 20.0, left: 20.0);

final InputDecoration firstnameInputDecoration = InputDecoration(
  hintStyle: GoogleFonts.openSans(fontSize: 14),
  hintText: 'First Name',
  border: InputBorder.none,
  contentPadding: EdgeInsets.only(
    left: 14,
  ),
);

final InputDecoration lastnameInputDecoration = InputDecoration(
  hintStyle: GoogleFonts.openSans(fontSize: 14),
  hintText: 'Last Name',
  border: InputBorder.none,
  contentPadding: EdgeInsets.only(
    left: 14,
  ),
);

final InputDecoration nameInputDecoration = InputDecoration(
  hintStyle: GoogleFonts.openSans(fontSize: 14),
  hintText: 'Name',
  border: InputBorder.none,
  contentPadding: EdgeInsets.only(
    left: 14,
  ),
);

final InputDecoration fullNameInputDecoration = InputDecoration(
  hintStyle: GoogleFonts.openSans(fontSize: 14),
  hintText: 'Full Name',
  border: InputBorder.none,
  contentPadding: EdgeInsets.only(
    left: 14,
  ),
);

final InputDecoration phoneInputDecoration = InputDecoration(
  hintStyle: GoogleFonts.openSans(fontSize: 14),
  hintText: 'Phone',
  border: InputBorder.none,
  contentPadding: EdgeInsets.only(
    left: 14,
  ),
);

final InputDecoration emailInputDecoration = InputDecoration(
  hintStyle: GoogleFonts.openSans(fontSize: 14),
  hintText: 'Email',
  border: InputBorder.none,
  contentPadding: EdgeInsets.only(
    left: 14,
  ),
);

final InputDecoration addressInputDecoration = InputDecoration(
  hintStyle: GoogleFonts.openSans(fontSize: 14),
  hintText: 'Address',
  border: InputBorder.none,
  contentPadding: EdgeInsets.only(
    left: 14,
  ),
);

final loginTitleStyle = TextStyle(
    fontWeight: FontWeight.bold, color: Color(0xFF68489B), fontSize: 45);

final loginTextStyle =
    TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16.0);

final EdgeInsets buttonPadding =
    EdgeInsets.only(top: 15.0, bottom: 8.0, right: 20.0, left: 20.0);

final EdgeInsets leftPadding = EdgeInsets.only(left: 8.0, top: 1.0);

final EdgeInsets iconPadding = EdgeInsets.only(bottom: 6.0);

final EdgeInsets datePadding = EdgeInsets.only(left: 6.0, right: 6.0, top: 6.0);

final TextStyle editTextStyle = GoogleFonts.openSans(fontSize: 14);

final TextStyle serviewviewbold =
    GoogleFonts.openSans(fontWeight: FontWeight.bold);

inputDecoration(text) {
  return InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        width: 0,
        style: BorderStyle.none,
      ),
    ),
    hintText: text.toString(),
    contentPadding: EdgeInsets.only(
      left: 14,
    ),
    filled: true,
    fillColor: Colors.grey[200],
  );
}

final validationTextStyle = TextStyle(
  color: Color(0xFFC0392B),
  fontSize: 12.5,
);

registerInputDecoration(registerHintText) {
  return InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide: BorderSide(
        width: 0,
        style: BorderStyle.none,
      ),
    ),
    hintText: registerHintText.toString(),
    hintStyle: GoogleFonts.openSans(color: color, fontWeight: FontWeight.bold),
    contentPadding: EdgeInsets.only(left: 12, bottom: 0),
    filled: true,
    fillColor: Colors.white,
  );
}
