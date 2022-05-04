import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_owner/model/default_data.dart';
import 'package:shop_owner/screen/common_widget/appbar_screen.dart';
import 'package:shop_owner/screen/drawer_page/drawer.dart';

import '../helpers/styleguide.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool downButton = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BaseAppBar(
        title: 'Payments',
        appBar: AppBar(),
      ),
      drawer: DrawerScreen(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _addPaymentAlert();
              });
            },
            child: Container(
              height: 40,
              width: 120,
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Center(
                child: Text(
                  'Add Payment',
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
              children: List.generate(
                paymentList.length,
                (index) {
                  return Column(children: [
                    // Divider(
                    //   color: Colors.grey[100],
                    //   thickness: 1.5,
                    // ),
                    Container(
                      height: 35,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (paymentList[index]['checkvalue'] == false) {
                              paymentList[index]['checkvalue'] = true;
                              downButton = false;
                            } else {
                              paymentList[index]['checkvalue'] = false;
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
                              // padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              child: Icon(
                                paymentList[index]['checkvalue'] == false
                                    ? FontAwesomeIcons.chevronDown
                                    : FontAwesomeIcons.chevronUp,
                                size: 15,
                                color: Colors.white,
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
                              flex: 5,
                              child: Text(
                                paymentList[index]['name'],
                                style: serviceDataText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    paymentList[index]['checkvalue'] == true
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
                                        'Availiable to Client',
                                        style: serviceTitleText,
                                      ),
                                    ),
                                    Expanded(flex: 1, child: Text(':')),
                                    Expanded(
                                      flex: 5,
                                      child: Text(
                                        paymentList[index]['availableclient'],
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
                                    // SizedBox(width: 20),
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
                                      flex: 5,
                                      child: Text(
                                        paymentList[index]['enabled'],
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
                                    // SizedBox(width: 20),
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
                                      flex: 5,
                                      child: Row(
                                        children: [
                                          _deleteContainer(),
                                          _editContainer(
                                              paymentList[index], index),
                                          _eyeContainer()
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : SizedBox(),
                    Divider(
                      color: Colors.grey[100],
                      thickness: 1.5,
                    ),
                  ]);
                },
              ),
            ),
          ),
          // Divider(
          //   color: Colors.grey[100],
          //   thickness: 1.5,
          // ),
        ],
      ),
    );
  }

  _addPaymentAlert() {
    var _statusValue = 0;
    var _clientValue = 0;
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        contentPadding: EdgeInsets.only(top: 25.0, left: 20.0, right: 10.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Container(
            width: MediaQuery.of(context).size.width - 10,
            height: MediaQuery.of(context).size.height / 2.5,
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
                      // controller: _titleController,
                      textInputAction: TextInputAction.go,
                      decoration: InputDecoration(
                        hintText: "Payment Name",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.only(left: 14.0),
                    child: Text(
                      "Status",
                      style: GoogleFonts.openSans(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Row(
                    children: [
                      Radio<int>(
                        value: 0,
                        groupValue: _statusValue,
                        onChanged: (int value) {
                          // setState(() => _statusValue = value);
                          setState(() {
                            _statusValue = value;
                          });
                        },
                        activeColor: color,
                      ),
                      new Text(
                        'Enable',
                        style: GoogleFonts.openSans(fontSize: 16.0),
                      ),
                      Radio<int>(
                        value: 1,
                        groupValue: _statusValue,
                        onChanged: (int value) {
                          // setState(() => _statusValue = value);
                          setState(() {
                            _statusValue = value;
                          });
                        },
                        activeColor: color,
                      ),
                      new Text(
                        'Disable',
                        style: GoogleFonts.openSans(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.only(left: 14.0),
                    child: Text(
                      "Availiable to Client",
                      style: GoogleFonts.openSans(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Row(
                    children: [
                      new Radio(
                        value: 0,
                        groupValue: _clientValue,
                        onChanged: (int value) {
                          setState(() => _clientValue = value);
                        },
                        activeColor: color,
                      ),
                      new Text(
                        'Yes',
                        style: GoogleFonts.openSans(fontSize: 16.0),
                      ),
                      SizedBox(width: 25),
                      new Radio(
                        value: 1,
                        groupValue: _clientValue,
                        onChanged: (int value) {
                          setState(() => _clientValue = value);
                        },
                        activeColor: color,
                      ),
                      new Text(
                        'No',
                        style: GoogleFonts.openSans(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // _titleController.clear();
                          // _startTimeController.clear();
                          // _endTimeController.clear();
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
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            Navigator.pop(context);
                          });
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
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
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
