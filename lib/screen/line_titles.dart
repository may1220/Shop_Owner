import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LineTitles {
  static getTitleData() => FlTitlesData(
        show: true,
        // topTitles: SideTitles(
        //   showTitles: true,
        // textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
        // margin: 16,
        // getTitles: (double value) {
        //   switch (value.toInt()) {
        //     case 0:
        //       return 'M';
        //     case 1:
        //       return 'T';
        //     case 2:
        //       return 'W';
        //     case 3:
        //       return 'T';
        //     case 4:
        //       return 'F';
        //     case 5:
        //       return 'S';
        //     case 6:
        //       return 'S';
        //     default:
        //       return '';
        //   }
        // },
        // ),
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          // getTextStyles: (value) => GoogleFonts.openSans(
          //   color: Color(0xff68737d),
          //   fontWeight: FontWeight.bold,
          //   fontSize: 12,
          // ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return "Jan";
              case 3:
                return "Feb";

              case 6:
                return "Mar";

              case 9:
                return "Apr";

              case 12:
                return "May";

              case 15:
                return "Jun";
            }
            return "";
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          // getTextStyles: (value) => GoogleFonts.openSans(
          //   color: Color(0xff68737d),
          //   fontWeight: FontWeight.bold,
          //   fontSize: 12,
          // ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return "0";
              case 2:
                return "1pm";
              case 3:
                return "2pm";
              case 4:
                return "3pm";
              case 5:
                return "4pm";
            }
            return "";
          },
          reservedSize: 28,
          margin: 12,
        ),
      );
}

// case 1:
//   return "Jan";
// case 2:
//   return "Feb";
// case 3:
//   return "Mar";
// case 4:
//   return "Apr";
// case 5:
//   return "May";
// case 6:
//   return "Jun";
// case 7:
//   return "Jul";
// case 8:
//   return "Aug";
// case 9:
//   return "Sept";
// case 10:
//   return "Oct";
// case 11:
//   return "Nov";
// case 12:
//   return "Dec";
