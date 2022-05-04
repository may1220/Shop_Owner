import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_owner/model/holiday_model.dart';
import 'package:shop_owner/screen/common_widget/appbar_screen.dart';
import 'package:shop_owner/screen/drawer_page/drawer.dart';
import 'package:table_calendar/table_calendar.dart';

import '../helpers/styleguide.dart';

class HolidayScreen extends StatefulWidget {
  @override
  _HolidayScreenState createState() => _HolidayScreenState();
}

class _HolidayScreenState extends State<HolidayScreen> {
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  StreamController<Holiday> events = StreamController<Holiday>();
  List<Holiday> terminalNodes = [];
  List<Map<String, dynamic>> holidayList = [
    {
      // "id": 0,
      "title": "Sunday",
      "startDate": "29/05/2021",
      "endDate": "31/05/2021"
    },
    {
      // "id": 1,
      "title": "Saturday",
      "startDate": "29/05/2021",
      "endDate": "31/05/2021"
    },
    {
      // "id": 2,
      "title": "Monday",
      "startDate": "29/05/2021",
      "endDate": "31/05/2021"
    },
    {
      // "id": 3,
      "title": "Farmer Day",
      "startDate": "29/05/2021",
      "endDate": "31/05/2021"
    },
  ];
  @override
  initState() {
    events.stream.listen((data) {
      terminalNodes.add(data);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: BaseAppBar(
          title: "Holiday",
          appBar: AppBar(),
        ),
        drawer: DrawerScreen(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: RaisedButton(
                  child: Text(
                    'Add Holiday',
                    style: GoogleFonts.openSans(color: Colors.white),
                  ),
                  onPressed: () {
                    setState(() {
                      // _addHolidayAlert();
                      alert();
                    });
                  },
                  color: color,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(22.0),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20.0),
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 3,
                      spreadRadius: 2,
                      offset: Offset(1, 1))
                ]),
                child: Column(children: [
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      'Holiday',
                      style: GoogleFonts.openSans(
                          color: color,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  _calendarWidget(),
                  SizedBox(
                    height: 15,
                  ),
                  _holidayList(),
                  SizedBox(height: 15),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  alert() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          // (horizontal:10 = left:10, right:10)(vertical:10 = top:10, bottom:10)
          contentPadding: EdgeInsets.only(top: 20.0, left: 20.0, right: 10.0),
          // contentPadding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          content: Container(
            width: MediaQuery.of(context).size.width - 10,
            height: MediaQuery.of(context).size.height / 3,
            child: Column(
              children: [
                Container(
                  decoration: boxDecoration,
                  padding: EdgeInsets.only(left: 8.0),
                  margin: EdgeInsets.only(top: 5.0, right: 12.0, left: 4.0),
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
                  padding: EdgeInsets.only(left: 8.0),
                  margin: EdgeInsets.only(right: 12.0, left: 4.0),
                  child: TextField(
                    controller: _startDateController,
                    textInputAction: TextInputAction.go,
                    decoration: InputDecoration(
                      hintText: "Start Date",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  decoration: boxDecoration,
                  padding: EdgeInsets.only(left: 8.0),
                  margin: EdgeInsets.only(right: 12.0, left: 4.0),
                  child: TextField(
                    controller: _endDateController,
                    textInputAction: TextInputAction.go,
                    decoration: InputDecoration(
                      hintText: "End Date",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _titleController.clear();
                        _startDateController.clear();
                        _endDateController.clear();
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40.0,
                        width: 80,
                        margin: EdgeInsets.only(
                          left: 5.0,
                          bottom: 5.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.purple[50],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            'CANCEL',
                            style: GoogleFonts.openSans(
                                color: color, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          events.add(Holiday(
                              title: _titleController.text,
                              startDate: _startDateController.text,
                              endDate: _endDateController.text));

                          holidayList.add({
                            "title": _titleController.text,
                            "startDate": _startDateController.text,
                            "endDate": _endDateController.text
                          });

                          Navigator.pop(context);
                        });
                        _titleController.clear();
                        _startDateController.clear();
                        _endDateController.clear();
                      },
                      child: Container(
                        height: 40.0,
                        width: 80,
                        margin: EdgeInsets.only(
                            left: 12.0, bottom: 5.0, right: 18.0),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            'SAVE',
                            style: GoogleFonts.openSans(
                                color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  _holidayList() {
    return Wrap(
      children: holidayList.map((holidaylist) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            height: 37.0,
            // width: ,
            margin: EdgeInsets.only(
              left: 4.0,
              bottom: 7.0,
            ),
            padding: datePadding,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.black, width: 1.5)),
            child: Text(
              holidaylist["title"],
              style: GoogleFonts.openSans(color: color, fontSize: 16),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _calendarWidget() {
    return TableCalendar(
      focusedDay: selectedDay,
      firstDay: DateTime(1990),
      lastDay: DateTime(2050),
      calendarFormat: format,
      onFormatChanged: (CalendarFormat _format) {
        setState(() {
          format = _format;
        });
      },
      startingDayOfWeek: StartingDayOfWeek.sunday,
      rowHeight: 40.0,
      onDaySelected: (DateTime selectDay, DateTime focusDay) {
        setState(() {
          selectedDay = selectDay;
          focusedDay = focusDay;
        });
      },
      selectedDayPredicate: (DateTime date) {
        return isSameDay(selectedDay, date);
      },
      daysOfWeekHeight: 30,
      calendarStyle: CalendarStyle(
        isTodayHighlighted: true,
        markerSize: 30.0,
        markersAutoAligned: true,
        todayDecoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
      calendarBuilders: CalendarBuilders(
        selectedBuilder: (context, date, events) => Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
          child: Center(
              child: Text(date.day.toString(),
                  style: GoogleFonts.openSans(color: Colors.white))),
        ),
        todayBuilder: (context, date, events) => Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Center(
              child: Text(
            date.day.toString(),
            style: GoogleFonts.openSans(color: Colors.white),
          )),
        ),
      ),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        formatButtonShowsNext: false,
        // headerMargin: EdgeInsets.only(bottom: 10.0),
        formatButtonDecoration: BoxDecoration(
          color: color,
        ),
        titleTextStyle:
            GoogleFonts.openSans(fontSize: 19.0, fontWeight: FontWeight.bold),
        leftChevronIcon: Icon(
          Icons.chevron_left,
          color: color,
          size: 50.0,
        ),
        rightChevronIcon: Icon(
          Icons.chevron_right,
          color: color,
          size: 50.0,
        ),
        leftChevronPadding: EdgeInsets.zero,
        rightChevronPadding: EdgeInsets.zero,
        formatButtonTextStyle: GoogleFonts.openSans(color: Colors.white),
      ),
    );
  }

  _addHolidayAlert() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // contentPadding: EdgeInsets.zero,
            insetPadding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
            // title: Text('What is your Lucky Number'),
            content: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 4,
                child: Column(
                  children: [
                    Container(
                      decoration: boxDecoration,
                      padding: EdgeInsets.only(left: 8.0),
                      margin: EdgeInsets.only(top: 5.0),
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
                      padding: EdgeInsets.only(left: 8.0),
                      child: TextField(
                        controller: _startDateController,
                        textInputAction: TextInputAction.go,
                        decoration: InputDecoration(
                          hintText: "Start Date",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      decoration: boxDecoration,
                      padding: EdgeInsets.only(left: 8.0),
                      child: TextField(
                        controller: _endDateController,
                        textInputAction: TextInputAction.go,
                        decoration: InputDecoration(
                          hintText: "End Date",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              GestureDetector(
                onTap: () {
                  _titleController.clear();
                  _startDateController.clear();
                  _endDateController.clear();
                  Navigator.pop(context);
                },
                child: Container(
                  height: 40.0,
                  width: 80,
                  margin: EdgeInsets.only(
                    left: 5.0,
                    bottom: 5.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.purple[50],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'CANCEL',
                      style: GoogleFonts.openSans(color: color, fontSize: 16),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    events.add(Holiday(
                        title: _titleController.text,
                        startDate: _startDateController.text,
                        endDate: _endDateController.text));

                    holidayList.add({
                      "title": _titleController.text,
                      "startDate": _startDateController.text,
                      "endDate": _endDateController.text
                    });

                    Navigator.pop(context);
                  });
                  _titleController.clear();
                  _startDateController.clear();
                  _endDateController.clear();
                },
                child: Container(
                  height: 40.0,
                  width: 80,
                  margin: EdgeInsets.only(left: 5.0, bottom: 5.0, right: 18.0),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'SAVE',
                      style: GoogleFonts.openSans(
                          color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
