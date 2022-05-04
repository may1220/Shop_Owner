import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_owner/screen/common_widget/appbar_screen.dart';
import 'package:shop_owner/screen/drawer_page/drawer.dart';

import '../helpers/styleguide.dart';

class OffDayScreen extends StatefulWidget {
  @override
  _OffDayScreenState createState() => _OffDayScreenState();
}

class _OffDayScreenState extends State<OffDayScreen> {
  // List<String> dayList = [
  //   'Sunday',
  //   'Monday',
  //   'Tuesday',
  //   'Wednesday',
  //   'Thursday',
  //   'Friday',
  //   'Saturday'
  // ];
  Map<String, bool> dayList = {
    'Sunday': false,
    'Monday': false,
    'Tuesday': false,
    'Wednesday': false,
    'Thursday': false,
    'Friday': false,
    'Saturday': false
  };
  // List<MyClass> selecteditems = List();
  List<String> selecteditems = ['Sunday'];

  // selecteditems[selectedIndex] = 'Sunday';
  var checkedValue = false;
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    // final appState = Provider.of<ChangeState>(context);
    // final isSelected = appState.selectedCategoryId == selectedIndex;
    bool _value = false;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BaseAppBar(title: 'Off Day', appBar: AppBar()),
      drawer: DrawerScreen(),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          margin: const EdgeInsets.only(top: 20.0, bottom: 20.0, left: 30.0),
          child: Text(
            'Choose Off Days',
            style: GoogleFonts.openSans(fontSize: 19),
          ),
        ),
        Container(
          height: 300,
          child: ListView(
            children: dayList.keys.map((String key) {
              return Row(children: [
                SizedBox(width: 22),
                InkWell(
                  onTap: () {
                    setState(() {
                      if (dayList[key] == true) {
                        dayList[key] = false;
                      } else {
                        dayList[key] = true;
                      }
                    });
                  },
                  child: dayList[key] == true
                      ? Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 10.0),
                          height: 21,
                          width: 22,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(color: Colors.black38),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.8),
                                spreadRadius: 0.5,
                                blurRadius: 0.5,
                                offset:
                                    Offset(0, 1), // changes position of shadow
                              ),
                            ],
                            image: DecorationImage(
                                image: AssetImage("assets/images/check.png")),
                          ),
                          // child: checkedValue ? Icon(Icons.check) : Text(""),
                        )
                      : Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 10.0),
                          height: 22,
                          width: 22,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(color: Colors.black38),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.8),
                                spreadRadius: 0.5,
                                blurRadius: 0.5,
                                offset:
                                    Offset(0, 1), // changes position of shadow
                              ),
                            ],
                          ),
                        ),
                ),
                Text(
                  key,
                  style: GoogleFonts.openSans(fontSize: 16),
                )
              ]);
            }).toList(),
          ),
        ),
        Container(
          height: 40,
          width: 80,
          margin: EdgeInsets.only(left: 32.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Center(
            child: Text(
              'SAVE',
              style: GoogleFonts.openSans(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        )
      ]),
    );
  }
}
