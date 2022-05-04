import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_owner/model/default_data.dart';
import 'package:shop_owner/screen/common_widget/appbar_screen.dart';
import 'package:shop_owner/screen/drawer_page/drawer.dart';
import 'package:shop_owner/screen/line_titles.dart';

import '../helpers/styleguide.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a)
  ];
  String priceDollor;
  int sortColumnIndex;
  String dropdownValue;
  List<String> monthList = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  bool isSwitched = false;
  var textValue = 'Switch is OFF';

  _toggleSwitch(bool value) {
    if (value == false) {
      setState(() {
        isSwitched = true;
        textValue = 'Switch Button is ON';
      });
    } else {
      setState(() {
        isSwitched = false;
        textValue = 'Switch Button is OFF';
      });
      // return isSwitched;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: BaseAppBar(
          title: 'Report',
          appBar: AppBar(),
        ),
        drawer: DrawerScreen(),
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: _chartWidget(),
            ),
            Expanded(
              flex: 1,
              child: _dataTableDesign(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chartWidget() {
    final List<int> showIndexes = const [1, 2, 3, 5, 6, 7];
    List<String> label = ["Toatl", "Net Amount"];
    final lineBar = List.generate(lineChartBarDataList.length, (index) {
      index = index;
      return LineChartBarData(
        spots: [
          FlSpot(lineChartBarDataList[index]["oneFirstSpot"],
              lineChartBarDataList[index]["oneSecSpot"]),
          FlSpot(lineChartBarDataList[index]["twoFirstSpot"],
              lineChartBarDataList[index]["twoSecSpot"]),
          FlSpot(lineChartBarDataList[index]["threeFirstSpot"],
              lineChartBarDataList[index]["threeSecSpot"]),
          FlSpot(lineChartBarDataList[index]["fourFirstSpot"],
              lineChartBarDataList[index]["fourSecSpot"]),
          FlSpot(lineChartBarDataList[index]["fiveFirstSpot"],
              lineChartBarDataList[index]["fiveSecSpot"]),
          FlSpot(lineChartBarDataList[index]["sixFirstSpot"],
              lineChartBarDataList[index]["sixSecSpot"]),
          FlSpot(lineChartBarDataList[index]["sevFirstSpot"],
              lineChartBarDataList[index]["sevSecSpot"]),
          FlSpot(lineChartBarDataList[index]["eightFirstSpot"],
              lineChartBarDataList[index]["eightSecSpot"]),
          FlSpot(lineChartBarDataList[index]["nineFirstSpot"],
              lineChartBarDataList[index]["nineSecSpot"]),
        ],
        isCurved: true,
        colors: gradientColors,
        barWidth: 0,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(
          show: true,
          colors: lineChartBarDataList[index]["color"],
        ),
      );
    });
    final tooltipsOnBar = lineBar[0];
    return Container(
      padding: EdgeInsets.only(right: 15.0, top: 15.0),
      margin: EdgeInsets.all(10),
      foregroundDecoration: new BoxDecoration(
        color: Colors.white30,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Colors.grey[100]],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[100].withOpacity(0.6),
            spreadRadius: 5,
            blurRadius: 4,
            offset: Offset(0, 0.5), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 10),
              Text('Overall Sales', style: GoogleFonts.openSans()),
              Spacer(),
              Text('Month', style: GoogleFonts.openSans())
            ],
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 30.0, bottom: 10.0, left: 10.0),
              child: LineChart(
                LineChartData(
                    maxX: 15,
                    minX: 0,
                    minY: 0,
                    maxY: 5,
                    showingTooltipIndicators: showIndexes.map((index) {
                      return ShowingTooltipIndicators([
                        LineBarSpot(
                            tooltipsOnBar,
                            lineBar.indexOf(tooltipsOnBar),
                            tooltipsOnBar.spots[index]),
                      ]);
                    }).toList(),
                    lineTouchData: LineTouchData(
                      touchTooltipData: LineTouchTooltipData(
                          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
                          getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
                            // return List.generate(lineChartBarDataList.length,
                            //     (index) {
                            //   return LineTooltipItem(
                            //     "Total \n" + "\$" +
                            //         lineChartBarDataList[index]["price"],
                            //     const GoogleFonts.openSans(
                            //         color: Colors.black,
                            //         fontWeight: FontWeight.bold),
                            //   );
                            // });
                            return lineBarsSpot.map((lineBarSpot) {
                              return LineTooltipItem(
                                lineBarSpot.x.toString(),
                                GoogleFonts.openSans(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              );
                            }).toList();
                          }),
                      touchCallback: (LineTouchResponse touchResponse) {},
                      handleBuiltInTouches: true,
                    ),
                    titlesData: LineTitles.getTitleData(),
                    gridData: FlGridData(
                      show: true,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: const Color(0xff37434d),
                          strokeWidth: 0.1,
                        );
                      },
                      drawVerticalLine: true,
                      getDrawingVerticalLine: (value) {
                        return FlLine(
                          color: const Color(0xff37434d),
                          strokeWidth: 0.1,
                        );
                      },
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(
                          color: const Color(0xff37434d), width: 0.2),
                    ),
                    lineBarsData: lineBar
                    //     List.generate(lineChartBarDataList.length, (index) {
                    //   return LineChartBarData(
                    //     spots: [
                    //       FlSpot(lineChartBarDataList[index]["oneFirstSpot"],
                    //           lineChartBarDataList[index]["oneSecSpot"]),
                    //       FlSpot(lineChartBarDataList[index]["twoFirstSpot"],
                    //           lineChartBarDataList[index]["twoSecSpot"]),
                    //       FlSpot(lineChartBarDataList[index]["threeFirstSpot"],
                    //           lineChartBarDataList[index]["threeSecSpot"]),
                    //       FlSpot(lineChartBarDataList[index]["fourFirstSpot"],
                    //           lineChartBarDataList[index]["fourSecSpot"]),
                    //       FlSpot(lineChartBarDataList[index]["fiveFirstSpot"],
                    //           lineChartBarDataList[index]["fiveSecSpot"]),
                    //       FlSpot(lineChartBarDataList[index]["sixFirstSpot"],
                    //           lineChartBarDataList[index]["sixSecSpot"]),
                    //       FlSpot(lineChartBarDataList[index]["sevFirstSpot"],
                    //           lineChartBarDataList[index]["sevSecSpot"]),
                    //       FlSpot(lineChartBarDataList[index]["eightFirstSpot"],
                    //           lineChartBarDataList[index]["eightSecSpot"]),
                    //       FlSpot(lineChartBarDataList[index]["nineFirstSpot"],
                    //           lineChartBarDataList[index]["nineSecSpot"]),
                    //     ],
                    //     isCurved: true,
                    //     colors: gradientColors,
                    //     barWidth: 0,
                    //     dotData: FlDotData(show: false),
                    //     belowBarData: BarAreaData(
                    //       show: true,
                    //       colors: lineChartBarDataList[index]["color"],
                    //     ),
                    //   );
                    // }),
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color lerpGradient(List<Color> colors, List<double> stops, double t) {
    if (stops.length != colors.length) {
      stops = [];

      /// provided gradientColorStops is invalid and we calculate it here
      colors.asMap().forEach((index, color) {
        final percent = 1.0 / colors.length;
        stops.add(percent * index);
      });
    }

    for (var s = 0; s < stops.length - 1; s++) {
      final leftStop = stops[s], rightStop = stops[s + 1];
      final leftColor = colors[s], rightColor = colors[s + 1];
      if (t <= leftStop) {
        return leftColor;
      } else if (t < rightStop) {
        final sectionT = (t - leftStop) / (rightStop - leftStop);
        return Color.lerp(leftColor, rightColor, sectionT);
      }
    }
    return colors.last;
  }

  Widget _dataTableDesign() {
    return Container(
      padding: EdgeInsets.only(left: 15.0, right: 15.0),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[100].withOpacity(0.6),
            spreadRadius: 5,
            blurRadius: 4,
            offset: Offset(0, 0.5), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Top Seller",
                style: GoogleFonts.openSans(),
              ),
              Spacer(),
              Container(
                child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: new DropdownButton<String>(
                      value: dropdownValue,
                      isExpanded: false,
                      hint: Text(
                        'Month',
                        style: GoogleFonts.openSans(fontSize: 14),
                      ),
                      items: monthList.map((month) {
                        return new DropdownMenuItem<String>(
                          value: month,
                          child: new Text(
                            month,
                            style: GoogleFonts.openSans(
                                color: Colors.black, fontSize: 14),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          dropdownValue = value;
                        });
                      },
                    ),
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
                flex: 2,
                child: Text('Name', style: GoogleFonts.openSans()),
              ),
              Expanded(
                flex: 1,
                child: Text('Review', style: GoogleFonts.openSans()),
              ),
              Expanded(
                flex: 1,
                child:
                    Center(child: Text('Type', style: GoogleFonts.openSans())),
              ),
              Text('Option', style: GoogleFonts.openSans())
            ],
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 10.0),
              // height: 200,
              child: ListView(
                children: List.generate(sellerList.length, (index) {
                  return Column(
                    children: [
                      SizedBox(height: 5),
                      Row(children: [
                        Expanded(
                          flex: 2,
                          child: Row(children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: AssetImage(
                                sellerList[index]["image"],
                              ),
                              minRadius: 10,
                              maxRadius: 18,
                            ),
                            SizedBox(width: 5),
                            Text(sellerList[index]["name"],
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.openSans()),
                          ]),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text("\$" + sellerList[index]["price"],
                              style: GoogleFonts.openSans()),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 26.0,
                              decoration: BoxDecoration(
                                color: sellerList[index]["color"],
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Text(
                                  sellerList[index]["button"],
                                  style: GoogleFonts.openSans(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        Switch(
                          onChanged: (value) {
                            setState(() {
                              if (sellerList[index]["isSwitched"] == false) {
                                sellerList[index]["isSwitched"] = true;
                              } else {
                                sellerList[index]["isSwitched"] = false;
                              }
                            });
                          },
                          value: sellerList[index]["isSwitched"],
                          activeColor: sellerList[index]["color"],
                          activeTrackColor: Colors.grey[300],
                          inactiveThumbColor: Colors.grey[300],
                          inactiveTrackColor: Colors.grey[300],
                        ),
                      ]),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
