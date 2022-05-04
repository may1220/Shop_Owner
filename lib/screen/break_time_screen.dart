import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_owner/model/default_data.dart';
import 'package:shop_owner/screen/common_widget/appbar_screen.dart';
import 'package:shop_owner/screen/drawer_page/drawer.dart';
import 'package:shop_owner/helpers/styleguide.dart';

class BreakTimeScreen extends StatefulWidget {
  @override
  _BreakTimeScreenState createState() => _BreakTimeScreenState();
}

class _BreakTimeScreenState extends State<BreakTimeScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _startTimeController = TextEditingController();
  TextEditingController _endTimeController = TextEditingController();
  bool downButton = true;
  var radioValue = 0;
  // bool radio = "yes";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: BaseAppBar(
          title: 'Break Time',
          appBar: AppBar(),
        ),
        drawer: DrawerScreen(),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          GestureDetector(
            onTap: () {
              // Navigator.of(context).push(
              //     MaterialPageRoute(builder: (context) => EditServiceScreen()));
              _addBreakTimeAlert();
            },
            child: Container(
              height: 40,
              width: 140,
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Center(
                child: Text(
                  'Add Break Time',
                  style: GoogleFonts.openSans(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.grey[100],
            thickness: 1.5,
          ),
          Expanded(
            child: ListView(
                children: List.generate(breakTimeList.length, (index) {
              return Column(
                children: [
                  Container(
                    height: 35,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (breakTimeList[index]['checkvalue'] == false) {
                            breakTimeList[index]['checkvalue'] = true;
                            downButton = false;
                          } else {
                            breakTimeList[index]['checkvalue'] = false;
                            downButton = true;
                          }
                        });
                      },
                      child: Row(
                        children: [
                          SizedBox(width: 20),
                          Container(
                            height: 28,
                            width: 28,
                            margin: EdgeInsets.zero,
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: breakTimeList[index]['checkvalue'] == false
                                ? Icon(
                                    FontAwesomeIcons.chevronDown,
                                    color: Colors.white,
                                    size: 15,
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(bottom: 3.0),
                                    child: Icon(
                                      FontAwesomeIcons.chevronUp,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                  ),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            flex: 4,
                            child: Text(
                              'Name',
                              style: serviceTitleText,
                            ),
                          ),
                          Expanded(flex: 1, child: Text(':')),
                          Expanded(
                            flex: 6,
                            child: Text(
                              staffList[index]['name'],
                              style: serviceDataText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  breakTimeList[index]['checkvalue'] == true
                      ? Column(
                          children: [
                            Container(
                              height: 40,
                              child: Row(
                                children: [
                                  SizedBox(width: 61),
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                      'Start Time',
                                      style: serviceTitleText,
                                    ),
                                  ),
                                  Expanded(flex: 1, child: Text(':')),
                                  Expanded(
                                    flex: 6,
                                    child: Text(
                                      breakTimeList[index]['starttime'],
                                      style: serviceDataText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 40,
                              child: Row(
                                children: [
                                  SizedBox(width: 61),
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                      'End Time',
                                      style: serviceTitleText,
                                    ),
                                  ),
                                  Expanded(flex: 1, child: Text(':')),
                                  Expanded(
                                    flex: 6,
                                    child: Text(
                                      breakTimeList[index]['endtime'],
                                      style: serviceDataText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 40,
                              child: Row(
                                children: [
                                  SizedBox(width: 61),
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                      'Enabled',
                                      style: serviceTitleText,
                                    ),
                                  ),
                                  Expanded(flex: 1, child: Text(':')),
                                  Expanded(
                                    flex: 6,
                                    child: Text(
                                      breakTimeList[index]['enabled'],
                                      style: serviceDataText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 40,
                              child: Row(children: [
                                SizedBox(width: 61),
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    'Action',
                                    style: serviceTitleText,
                                  ),
                                ),
                                Expanded(flex: 1, child: Text(':')),
                                Expanded(
                                  flex: 6,
                                  child: Row(
                                    children: [
                                      _deleteContainer(),
                                      _editContainer(
                                          breakTimeList[index], index),
                                      _eyeContainer()
                                    ],
                                  ),
                                ),
                              ]),
                            ),
                          ],
                        )
                      : SizedBox(),
                  Divider(
                    color: Colors.grey[100],
                    thickness: 1.5,
                  ),
                ],
              );
            })),
          )
        ]),
      ),
    );
  }

  _addBreakTimeAlert() {
    var radioValue = 0;
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        contentPadding: EdgeInsets.only(top: 20.0, left: 20.0, right: 10.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              width: MediaQuery.of(context).size.width - 10,
              height: MediaQuery.of(context).size.height / 2.4,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: boxDecoration,
                      padding: EdgeInsets.only(
                        left: 12.0,
                      ),
                      margin: EdgeInsets.only(top: 5.0, right: 12.0),
                      child: TextField(
                        controller: _titleController,
                        textInputAction: TextInputAction.go,
                        decoration: InputDecoration(
                          hintText: "Title",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      decoration: boxDecoration,
                      padding: EdgeInsets.only(left: 12.0),
                      margin: EdgeInsets.only(right: 12.0),
                      child: TextField(
                        controller: _startTimeController,
                        textInputAction: TextInputAction.go,
                        decoration: InputDecoration(
                          hintText: "Start Time",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      decoration: boxDecoration,
                      padding: EdgeInsets.only(left: 12.0),
                      margin: EdgeInsets.only(right: 12.0),
                      child: TextField(
                        controller: _endTimeController,
                        textInputAction: TextInputAction.go,
                        decoration: InputDecoration(
                          hintText: "End Time",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.0, left: 14.0),
                      child: Text(
                        "Enabled",
                        style:
                            GoogleFonts.openSans(fontWeight: FontWeight.w500),
                      ),
                    ),
                    Row(
                      children: [
                        new Radio<int>(
                          value: 0,
                          groupValue: radioValue,
                          onChanged: (int value) {
                            setState(() {
                              radioValue = value;
                            });
                          },
                          activeColor: color,
                        ),
                        Text(
                          'Yes',
                          style: GoogleFonts.openSans(fontSize: 16.0),
                        ),
                        new Radio<int>(
                          value: 1,
                          groupValue: radioValue,
                          onChanged: (int value) {
                            setState(() {
                              radioValue = value;
                            });
                          },
                          activeColor: color,
                        ),
                        Text(
                          'No',
                          style: GoogleFonts.openSans(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              // events.add(Holiday(
                              //     title: _titleController.text,
                              //     startDate: _startDateController.text,
                              //     endDate: _endDateController.text));
                              if (_titleController.text != "" &&
                                  _startTimeController.text != "" &&
                                  _endTimeController.text != "") {
                                breakTimeList.add({
                                  "title": _titleController.text,
                                  "starttime": _startTimeController.text,
                                  "endtime": _endTimeController.text,
                                  "enabled": "No",
                                  "checkvalue": false
                                });
                              }

                              Navigator.pop(context);
                            });
                            _titleController.clear();
                            _startTimeController.clear();
                            _endTimeController.clear();
                          },
                          child: Container(
                            height: 35.0,
                            width: 100,
                            margin: EdgeInsets.only(
                                left: 5.0, bottom: 5.0, right: 10.0),
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                'ADD',
                                style: GoogleFonts.openSans(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _titleController.clear();
                            _startTimeController.clear();
                            _endTimeController.clear();
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 35.0,
                            width: 100,
                            margin: EdgeInsets.only(
                              // left: 5.0,
                              bottom: 5.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.purple[50],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                'CANCEL',
                                style: GoogleFonts.openSans(
                                    color: color, fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _deleteContainer() {
    return Container(
      margin: EdgeInsets.only(right: 10.0),
      padding: EdgeInsets.all(5.0),
      height: 24.0,
      width: 24.0,
      decoration: BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white),
      ),
      child: Center(
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 13,
        ),
      ),
    );
  }

  _editContainer(data, index) {
    return GestureDetector(
      onTap: () {},
      child: Container(
          margin: EdgeInsets.only(right: 10.0),
          padding: EdgeInsets.all(5.0),
          height: 24.0,
          width: 24.0,
          decoration: BoxDecoration(
            color: Colors.purple[50],
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white),
            // image: DecorationImage(image: AssetImage("assets/images/pen-color.png",hei))
          ),
          child: Image.asset("assets/images/pen-color.png")),
    );
  }

  _eyeContainer() {
    return Container(
      margin: EdgeInsets.only(right: 10.0),
      padding: EdgeInsets.all(5.0),
      height: 24.0,
      width: 24.0,
      decoration: BoxDecoration(
        color: Colors.purple[50],
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white),
      ),
      child: Center(
        child: Icon(
          FontAwesomeIcons.eye,
          color: Colors.red,
          size: 12,
        ),
      ),
    );
  }
}
