import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shop_owner/helpers/response_ob.dart';
import 'package:shop_owner/screen/alert_widget/alert_dialogbox.dart';
import 'package:shop_owner/screen/background_screen.dart';
import 'package:shop_owner/screen/drawer_page/drawer.dart';
import 'package:shop_owner/screen/service_page/service_list/service_list_ob.dart';
import 'package:shop_owner/screen/service_page/service_update/editservice_bloc.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shop_owner/screen/shop_page/shop_list/shop_list_bloc.dart';
import 'package:shop_owner/screen/shop_page/shop_list/shop_list_ob.dart';
import 'package:shop_owner/utils/app_constants.dart';
import 'package:path/path.dart';

import '../../../helpers/styleguide.dart';

// ignore: must_be_immutable
class EditServiceScreen extends StatefulWidget {
  ServicesOb data;
  final String title;
  EditServiceScreen({Key key, this.data, this.title}) : super(key: key);
  @override
  _EditServiceScreenState createState() => _EditServiceScreenState();
}

class _EditServiceScreenState extends State<EditServiceScreen> {
  File _imageFile;
  final ImagePicker _picker = ImagePicker();
  String dropdownValue;
  DateTime selectedDate = DateTime.now();
  String startDate;
  String endDate;
  String startHour;
  String startMinute;
  String startTime;
  String endHour;
  String endMinute;
  String endTime;
  bool isImage = false;
  String imageValidationText;

  static List<String> availabeShareList = [null];

  String time;
  bool disableColor = false;
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _categoryname = new TextEditingController();
  TextEditingController price = new TextEditingController();
  TextEditingController serviceDuration = new TextEditingController();
  TextEditingController serviceBufferingTime = new TextEditingController();
  TextEditingController description = new TextEditingController();
  TextEditingController breakTime = new TextEditingController();
  TextEditingController _shareSpaceController = new TextEditingController();
  EditServiceBloc _bloc = EditServiceBloc();
  ShopListBloc _shopList = ShopListBloc();
  String shopName;
  bool loading = false;
  var _formKey = GlobalKey<FormState>();
  TextEditingController maximumBooking = TextEditingController();
  String image;
  String bufferKey;
  String bufferTime;
  List<ShopListOb> shopList;
  ShopListOb selectedShop;
  String shopId;
  var date = DateFormat('yyyy-MM-dd').format(DateTime.now());
  Map<String, String> serviceBufferingList = {
    '00:05:00': "5 minutes",
    '00:10:00': "10 minutes",
    '00:15:00': "15 minutes",
    '00:20:00': "20 minutes",
    '00:25:00': "25 minutes",
    '00:30:00': "30 minutes",
    '00:35:00': "35 minutes",
    '00:40:00': "40 minutes",
    '00:45:00': "45 minutes",
    '00:50:00': "50 minutes",
    '01:00:00': "1 hour",
    '01:30:00': "1:5 hour",
    '02:00:00': "2 hours",
    '03:00:00': "3 hours",
  };

  @override
  void initState() {
    super.initState();
    getData();
    _editListener();
    _newServiceListener();
    _getShoList();
  }

  getData() {
    if (widget.data != null) {
      _nameController.text = widget.data.title;
      startTime = widget.data.serviceStarts;
      endTime = widget.data.serviceEnds;
      startDate = widget.data.serviceStartingDate.toString();
      endDate = widget.data.serviceEndingDate.toString();
      serviceDuration.text =
          (widget.data.serviceDuration.toString()).substring(0, 5);
      print(serviceDuration.text);
      bufferKey = widget.data.bufferTime.toString();
      price.text = widget.data.price.toString();
      description.text = widget.data.description.toString();
      breakTime.text = widget.data.breakTime.toString();
      dropdownValue = widget.data.multipleBookings.toString();
      _shareSpaceController.text = widget.data.availableSeat.toString();
      maximumBooking.text = widget.data.maxBooking.toString();
      image = widget.data.image.toString();
      shopId = widget.data.shopId.toString();
    } else {
      image = "default.jpg";
    }
  }

  _editListener() {
    _bloc.editServiceStream().listen((ResponseOb response) {
      if (response.message == MsgState.data) {
        setState(() {
          loading = false;
        });
        return showDialog(
            context: this.context,
            builder: (BuildContext context) =>
                ShowAlertBOx(title: response.data["message"].toString()));
      } else {
        // setState(() {
        //   loading = false;
        // });
        // print(response.data["message"].toString());
        // if (response.data != null) {
        //   return showDialog(
        //       context: this.context,
        //       builder: (BuildContext context) =>
        //           ShowAlertBOx(title: response.data["message"].toString()));
        // }
      }
    });
  }

  _newServiceListener() {
    _bloc.newServiceStream().listen((ResponseOb response) {
      if (response.message == MsgState.data) {
        setState(() {
          loading = false;
        });
        return showDialog(
            context: this.context,
            builder: (BuildContext context) =>
                ShowAlertBOx(title: response.data["message"].toString()));
      }
    });
  }

  _getShoList() {
    _shopList.shoplist();
    _shopList.shoplistStream().listen((ResponseOb response) {
      if (response.message == MsgState.data) {
        setState(() {
          shopList = response.data;
          shopList.forEach((shopOb) {
            if (shopOb.id.toString() == shopId) {
              selectedShop = shopOb;
              shopName = shopOb.sname;
            }
          });
        });
      }
    });
  }

  Future<void> _selectDate(BuildContext context, String option) async {
    print(selectedDate);
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(primary: const Color(0xFF6600cc)),
          ),
          child: child,
        );
      },
    );
    if (picked != null)
      setState(() {
        selectedDate = picked;

        if (option == 'startDate') {
          startDate = DateFormat("yyyy-MM-dd").format(selectedDate);
        } else {
          endDate = DateFormat("yyyy-MM-dd").format(selectedDate);
        }
      });
  }

  Future<void> _selectTime(BuildContext context, String option) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null)
      setState(() {
        selectedTime = picked;
        if (option == 'startTime') {
          startHour = picked.toString().substring(10, 12);
          startMinute = picked.toString().substring(13, 15);
          if (selectedTime.hour > 12 && selectedTime.hour < 24) {
            startHour = (selectedTime.hour % 12).toString();
            time = "PM";
          } else if (selectedTime.hour == 12) {
            time = "PM";
          } else {
            if (selectedTime.hour == 00) {
              startHour = "12";
              startMinute = "00";
            }
            time = "AM";
          }
          if (startMinute == "0") {
            startMinute = "00";
          }
          startTime = (startHour + ':' + startMinute + " " + time).toString();
        } else if (option == 'endTime') {
          endHour = picked.toString().substring(10, 12);
          endMinute = picked.toString().substring(13, 15);
          if (selectedTime.hour > 12 && selectedTime.hour < 24) {
            endHour = (selectedTime.hour % 12).toString();
            time = "PM";
          } else if (selectedTime.hour == 12) {
            time = "PM";
          } else {
            if (selectedTime.hour == 00) {
              endHour = "12";
              endMinute = "00";
            }
            time = "AM";
          }
          if (endMinute == "0") {
            endMinute = "00";
          }
          endTime = (endHour + ':' + endMinute + " " + time).toString();
        } else {
          var serviceDurationHour = picked.toString().substring(10, 12);
          var serviceDurationMinute = picked.toString().substring(13, 15);
          if (selectedTime.hour > 12 && selectedTime.hour < 24) {
            serviceDurationHour = (selectedTime.hour % 12).toString();
            time = "PM";
          } else if (selectedTime.hour == 12) {
            time = "PM";
          } else {
            if (selectedTime.hour == 00) {
              serviceDurationHour = "12";
              serviceDurationMinute = "00";
            }
            time = "AM";
          }
          if (serviceDurationMinute == "0") {
            serviceDurationMinute = "00";
          }
          serviceDuration.text =
              (serviceDurationHour + ':' + serviceDurationMinute).toString();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (context) => IconButton(
              icon: Image.asset(
                "assets/images/menu-white.png",
                height: 22,
                width: 34,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Text(
                  widget.title.toString(),
                  textAlign: TextAlign.end,
                  style: GoogleFonts.openSans(
                      fontSize: 20, fontWeight: FontWeight.w300),
                ),
              ),
            ),
          ],
          backgroundColor: color,
          elevation: 0,
        ),
        drawer: DrawerScreen(),
        body: ModalProgressHUD(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                HomeBackgroundPage(
                    screenHeight: MediaQuery.of(context).size.height),
                _editService(),
              ],
            ),
          ),
          inAsyncCall: loading,
          opacity: 0.5,
          progressIndicator: CircularProgressIndicator(
            color: color,
          ),
        ),
      ),
    );
  }

  _editService() {
    return Form(
      key: _formKey,
      child: Container(
          padding: EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
          margin: cardPadding,
          decoration: cardShawdowDecoration,
          width: MediaQuery.of(this.context).size.width,
          // height: MediaQuery.of(context).size.height,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          image: DecorationImage(
                            image: _imageFile == null
                                ? NetworkImage(IMAGE_URL + image.toString())
                                : FileImage(File(_imageFile.path)),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                isDismissible: false,
                                context: this.context,
                                builder: ((builder) => bottomSheet()));
                          },
                          child: CircleAvatar(
                            radius: 17,
                            backgroundColor: Colors.black,
                            child: Image.asset(
                              'assets/images/pen-white.png',
                              width: 19.0,
                              height: 19.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  isImage == true
                      ? Container(
                          margin: EdgeInsets.only(left: 13.0, top: 7.0),
                          child: Text(
                            imageValidationText,
                            style: validationTextStyle,
                          ),
                        )
                      : SizedBox(),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              shopList == null
                  ? SizedBox()
                  : Container(
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          // alignedDropdown: true,
                          child: new DropdownButtonFormField<ShopListOb>(
                            isExpanded: true,
                            value: selectedShop,
                            hint: Text(
                              shopName == null ? 'Choose Shop' : shopName,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.openSans(
                                  fontSize: 15, color: Colors.black),
                            ),
                            decoration: inputDecoration(""),
                            items: shopList.map((ShopListOb shopOb) {
                              return new DropdownMenuItem<ShopListOb>(
                                value: shopOb,
                                child: new Text(
                                  shopOb.sname,
                                  style: editTextStyle,
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                shopId = value.id.toString();
                                print(shopId);
                                shopName = value.sname.toString();
                              });
                            },
                            validator: (value) {
                              if (value == null) {
                                return "Shop must not be null.";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
              SizedBox(
                height: 15,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: TextFormField(
                            controller: _nameController,
                            decoration: inputDecoration("Name"),
                            style: editTextStyle,
                            validator: (value) {
                              if (value == "null" ||
                                  value == null ||
                                  value.isEmpty) {
                                return "Name must not be empty.";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: Container(
                          // height: 42,
                          // decoration: boxDecoration,
                          child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              // alignedDropdown: true,
                              child: new DropdownButtonFormField<String>(
                                  isExpanded: true,
                                  decoration: inputDecoration(""),
                                  value: dropdownValue,
                                  hint: Text(
                                    dropdownValue == null
                                        ? 'Allow Multiple Booking'
                                        : dropdownValue,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.openSans(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                  items:
                                      <String>['Yes', 'No'].map((String value) {
                                    return new DropdownMenuItem<String>(
                                      value: value,
                                      child: new Text(
                                        value,
                                        style: editTextStyle,
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      dropdownValue = value;
                                    });
                                  },
                                  validator: (value) {
                                    if (value == "null" ||
                                        value == null ||
                                        value.isEmpty) {
                                      return "AMB must not be null.";
                                    }
                                    return null;
                                  }),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Theme(
                          data: Theme.of(this.context)
                              .copyWith(primaryColor: (Colors.black45)),
                          child: Container(
                            // height: 42,
                            // decoration: boxDecoration,
                            // padding: leftPadding,
                            child: TextFormField(
                              controller:
                                  TextEditingController(text: startDate),
                              readOnly: true,
                              style: editTextStyle,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.grey[200],
                                hintText: 'Service Start Date',
                                contentPadding: EdgeInsets.only(
                                  left: 14,
                                ),
                                suffixIcon: InkWell(
                                  onTap: () {
                                    _selectDate(this.context, 'startDate');
                                  },
                                  child: Padding(
                                    padding: iconPadding,
                                    child: Icon(
                                      FontAwesomeIcons.calendarAlt,
                                      size: 18,
                                      color: Colors.black45,
                                    ),
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == "null" ||
                                    value == null ||
                                    value.isEmpty) {
                                  return "Date must not be empty.";
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: Theme(
                          data: Theme.of(this.context)
                              .copyWith(primaryColor: (Colors.black45)),
                          child: Container(
                            child: TextFormField(
                              controller: TextEditingController(text: endDate),
                              readOnly: true,
                              style: editTextStyle,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.grey[200],
                                hintText: 'Service End Date',
                                contentPadding: EdgeInsets.only(
                                  left: 14,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    _selectDate(this.context, 'endDate');
                                  },
                                  icon: Padding(
                                    padding: iconPadding,
                                    child: Icon(
                                      FontAwesomeIcons.calendarAlt,
                                      size: 18,
                                      color: Colors.black45,
                                    ),
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == "null" ||
                                    value == null ||
                                    value.isEmpty) {
                                  return "Date must not be empty.";
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          // height: 42,
                          // decoration: boxDecoration,
                          // padding: leftPadding,
                          child: TextFormField(
                            controller: maximumBooking,
                            keyboardType: TextInputType.number,
                            style: editTextStyle,
                            decoration: inputDecoration("Max Booking"),
                            validator: (value) {
                              if (value == "null" ||
                                  value == null ||
                                  value.isEmpty) {
                                return "Max Booking must not be empty.";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: TextFormField(
                            controller: price,
                            keyboardType: TextInputType.number,
                            style: editTextStyle,
                            decoration: inputDecoration("Space Per Price"),
                            validator: (value) {
                              if (value == "null" ||
                                  value == null ||
                                  value.isEmpty) {
                                return "Max Booking must not be empty.";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Theme(
                          data: Theme.of(this.context)
                              .copyWith(primaryColor: (Colors.black45)),
                          child: Container(
                            child: TextFormField(
                              controller:
                                  TextEditingController(text: startTime),
                              readOnly: true,
                              style: editTextStyle,
                              decoration: InputDecoration(
                                hintText: 'Service Start',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                contentPadding: EdgeInsets.only(
                                  left: 14,
                                ),
                                filled: true,
                                fillColor: Colors.grey[200],
                                suffixIcon: InkWell(
                                  onTap: () {
                                    _selectTime(this.context, 'startTime');
                                  },
                                  child: Padding(
                                    padding: iconPadding,
                                    child: Icon(
                                      FontAwesomeIcons.clock,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Start Time must not be empty.";
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: Theme(
                          data: Theme.of(this.context)
                              .copyWith(primaryColor: (Colors.black45)),
                          child: Container(
                            child: TextFormField(
                              controller: TextEditingController(text: endTime),
                              readOnly: true,
                              style: editTextStyle,
                              decoration: InputDecoration(
                                hintText: 'Service End',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                contentPadding: EdgeInsets.only(
                                  left: 14,
                                ),
                                filled: true,
                                fillColor: Colors.grey[200],
                                suffixIcon: InkWell(
                                  onTap: () {
                                    _selectTime(this.context, 'endTime');
                                  },
                                  child: Padding(
                                    padding: iconPadding,
                                    child: Icon(
                                      FontAwesomeIcons.clock,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "End Time must not be empty.";
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: TextFormField(
                            controller: serviceDuration,
                            style: editTextStyle,
                            decoration: InputDecoration(
                              hintText: 'Service Duration',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              contentPadding: EdgeInsets.only(
                                left: 14,
                              ),
                              filled: true,
                              fillColor: Colors.grey[200],
                              suffixIcon: InkWell(
                                onTap: () {
                                  _selectTime(this.context, 'serviceDuration');
                                },
                                child: Padding(
                                  padding: iconPadding,
                                  child: Icon(
                                    FontAwesomeIcons.clock,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == "null" ||
                                  value == null ||
                                  value.isEmpty) {
                                return "Service Duration must not be null.";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              // alignedDropdown: true,
                              child: new DropdownButtonFormField<String>(
                                isExpanded: true,
                                value:
                                    bufferKey == null ? "00:05:00" : bufferKey,
                                hint: Text(
                                  bufferTime == null
                                      ? 'Service Buffering Time'
                                      : bufferTime,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.openSans(fontSize: 15),
                                ),
                                decoration: inputDecoration(""),
                                items: serviceBufferingList.entries
                                    .map<DropdownMenuItem<String>>(
                                        (MapEntry<String, String> e) =>
                                            DropdownMenuItem<String>(
                                              value: e.key,
                                              child: Text(
                                                e.value,
                                                style: editTextStyle,
                                              ),
                                            ))
                                    .toList(),
                                onChanged: (String newKey) {
                                  /* todo handle change */
                                  setState(() {
                                    bufferKey = newKey;
                                    bufferTime = serviceBufferingList[newKey];
                                  });
                                },
                                validator: (value) {
                                  if (value == "null" ||
                                      value == null ||
                                      value.isEmpty) {
                                    return "Buffering must not be null.";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          // height: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: leftPadding,
                          child: TextField(
                            controller: description,
                            maxLines: 6,
                            style: editTextStyle,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                                hintText: 'Description',
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 5.0,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: RaisedButton(
                            onPressed: widget.data == null
                                ? createService
                                : serviceUpdate,
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(40.0),
                            ),
                            child: Text(
                              'Save Change',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            color: color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15)
            ],
          )),
    );
  }

  List<Widget> _getshareAvailable() {
    List<Widget> friendsTextFields = [];
    List<Widget> shareAvailableFields = [];
    for (int i = 0; i < availabeShareList.length; i++) {
      shareAvailableFields.add(Row(
        children: [
          Expanded(child: ShareAvailableFields(i)),
          SizedBox(
            width: 16,
          ),
          // we need add button at last friends row
          _addRemoveButton(i == availabeShareList.length - 1, i),
        ],
      ));
    }
    return shareAvailableFields;
  }

  /// add / remove button
  Widget _addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          // add new text-fields at the top of all friends textfields
          availabeShareList.insert(0, null);
        } else
          availabeShareList.removeAt(index);
        setState(() {});
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        height: 36,
        width: 38,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(color: Colors.black38),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.8),
              spreadRadius: 0.5,
              blurRadius: 0.5,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Icon(
          (add) ? FontAwesomeIcons.plus : Icons.remove,
          color: Colors.white,
          size: 16,
        ),
      ),
    );
  }

  Widget _imageProfile() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 80,
            backgroundImage: _imageFile == null
                ? NetworkImage(IMAGE_URL + widget.data.image)
                : FileImage(File(_imageFile.path)),
          ),
          Positioned(
            bottom: 20.0,
            right: 17.0,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                    isDismissible: false,
                    context: this.context,
                    builder: ((builder) => bottomSheet()));
              },
              child: CircleAvatar(
                radius: 17,
                backgroundColor: Colors.black,
                child: Image.asset(
                  'assets/images/pen-white.png',
                  width: 19.0,
                  height: 19.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 90,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Text(
            'Choose Profile Photo',
            textAlign: TextAlign.left,
            style: GoogleFonts.openSans(
              fontSize: 20.0,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton.icon(
                icon: Icon(Icons.camera),
                onPressed: () {
                  takephoto(ImageSource.camera);
                  Navigator.pop(this.context);
                },
                label: Text('Camera'),
              ),
              FlatButton.icon(
                icon: Icon(Icons.image),
                onPressed: () {
                  takephoto(ImageSource.gallery);
                  Navigator.pop(this.context);
                },
                label: Text('Gallery'),
              ),
            ],
          )
        ],
      ),
    );
  }

  void takephoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = File(pickedFile.path);
    });
  }

  serviceUpdate() async {
    if (_imageFile == null) {
      if (image == null) {
        setState(() {
          isImage = true;
          imageValidationText = "Please Choose Image!";
        });
      } else {
        setState(() {
          isImage = false;
        });
      }
    } else {
      setState(() {
        isImage = false;
      });
    }

    if (_formKey.currentState.validate()) {
      setState(() {
        loading = true;
      });
      Map<String, dynamic> map;
      if (_imageFile == null) {
        map = {
          "id": widget.data.id.toString(),
          "title": _nameController.text,
          "multiple_bookings": dropdownValue,
          "service_starting_date": startDate,
          "service_ending_date": endDate,
          "price": price.text.toString(),
          "service_starts": startTime,
          "service_ends": endTime,
          "service_duration": serviceDuration.text.toString(),
          "buffer_time": bufferKey,
          "description": description.text.toString(),
          "shop_id": shopId,
          "max_booking": maximumBooking.text.toString(),
          "status": "pending"
        };
      } else {
        map = {
          "id": widget.data.id.toString(),
          "title": _nameController.text,
          "multiple_bookings": dropdownValue,
          "service_starting_date": startDate,
          "service_ending_date": endDate,
          "price": price.text.toString(),
          "service_starts": startTime,
          "service_ends": endTime,
          "service_duration": serviceDuration.text.toString(),
          "buffer_time": bufferKey,
          "description": description.text.toString(),
          "shop_id": shopId,
          "max_booking": maximumBooking.text.toString(),
          "uploads": await MultipartFile.fromFile(_imageFile.path,
              filename: basename(_imageFile.path)),
          "status": "pending"
        };
      }

      print(map);

      _bloc.updateService(map);
    }
  }

  createService() async {
    if (_imageFile == null) {
      setState(() {
        isImage = true;
        imageValidationText = "Please Choose Image!";
      });
      return;
    } else {
      setState(() {
        isImage = false;
      });
    }

    if (_formKey.currentState.validate()) {
      setState(() {
        loading = true;
      });

      Map<String, dynamic> map = {
        "title": _nameController.text,
        "multiple_bookings": dropdownValue,
        "service_starting_date": startDate,
        "service_ending_date": endDate,
        "price": price.text,
        "service_starts": startTime,
        "service_ends": endTime,
        "service_duration": serviceDuration.text.toString(),
        "buffer_time": bufferKey,
        "description": description.text.toString(),
        "max_booking": maximumBooking.text.toString(),
        "status": "pending",
        "shop_id": shopId,
        "uploads": await MultipartFile.fromFile(_imageFile.path,
            filename: basename(_imageFile.path))
      };
      print(map);

      _bloc.newService(map);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}

class ShareAvailableFields extends StatefulWidget {
  final int index;
  ShareAvailableFields(this.index);
  @override
  _ShareAvailableFieldsState createState() => _ShareAvailableFieldsState();
}

class _ShareAvailableFieldsState extends State<ShareAvailableFields> {
  TextEditingController _shareSpaceController;

  @override
  void initState() {
    super.initState();
    _shareSpaceController = TextEditingController();
  }

  @override
  void dispose() {
    _shareSpaceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _shareSpaceController.text =
          _EditServiceScreenState.availabeShareList[widget.index] ?? '';
    });

    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: leftPadding,
      child: TextFormField(
        style: editTextStyle,
        controller: _shareSpaceController,
        onChanged: (v) =>
            _EditServiceScreenState.availabeShareList[widget.index] = v,
        decoration: InputDecoration(
          hintText: 'Share available space with',
          border: InputBorder.none,
        ),
        validator: (v) {
          if (v.trim().isEmpty) return 'Please enter something';
          return null;
        },
      ),
    );
  }
}

   // "shop_id": widget.data.shopId,
      // "break_time": breakTime.text,
      // "available_seat": _shareSpaceController.text,
      // "referred_service_id": "",
      // "business_type": "salon",
      // "allow_cancel": "0",
      // "auto_confirm": "0",
      // "allow_booking_max_day_ago": "60",
      // "service_duration_type": "hourly",
         // "alias": "",
      // "created_by": "1",
      // "activation": "1",
      // "consider_children_for_price": "Yes",
      // "created_at": "",
      // "updated_at": "",
      // "percentage": "",
      // "age_range": "",


   // ..._getshareAvailable(),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       flex: 1,
                  //       child: Container(
                  //         height: 42,
                  //         decoration: boxDecoration,
                  //         padding: leftPadding,
                  //         child: TextField(
                  //           controller: breakTime,
                  //           style: editTextStyle,
                  //           decoration: InputDecoration(
                  //             hintText: 'Break Time',
                  //             border: InputBorder.none,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(width: 5),
                  //     GestureDetector(
                  //       onTap: () {},
                  //       child: Container(
                  //         margin:
                  //             EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                  //         height: 36,
                  //         width: 38,
                  //         decoration: BoxDecoration(
                  //           color: color,
                  //           borderRadius: BorderRadius.circular(4.0),
                  //           border: Border.all(color: Colors.black38),
                  //           boxShadow: [
                  //             BoxShadow(
                  //               color: Colors.grey.withOpacity(0.8),
                  //               spreadRadius: 0.5,
                  //               blurRadius: 0.5,
                  //               offset: Offset(0, 1), // changes position of shadow
                  //             ),
                  //           ],
                  //         ),
                  //         child: Center(
                  //           child: Icon(
                  //             FontAwesomeIcons.plus,
                  //             color: Colors.white,
                  //             size: 16,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),

 // ..._getshareAvailable(),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       flex: 1,
                  //       child: Container(
                  //         height: 42,
                  //         decoration: boxDecoration,
                  //         padding: leftPadding,
                  //         child: TextField(
                  //           controller: _shareSpaceController,
                  //           style: editTextStyle,
                  //           decoration: InputDecoration(
                  //             hintText: 'Share Available Space With',
                  //             border: InputBorder.none,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(width: 5),
                  //     GestureDetector(
                  //       onTap: null,
                  //       child: Container(
                  //         margin:
                  //             EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                  //         height: 36,
                  //         width: 38,
                  //         decoration: BoxDecoration(
                  //           color: color,
                  //           borderRadius: BorderRadius.circular(4.0),
                  //           border: Border.all(color: Colors.black38),
                  //           boxShadow: [
                  //             BoxShadow(
                  //               color: Colors.grey.withOpacity(0.8),
                  //               spreadRadius: 0.5,
                  //               blurRadius: 0.5,
                  //               offset: Offset(0, 1), // changes position of shadow
                  //             ),
                  //           ],
                  //         ),
                  //         child: Center(
                  //           child: Icon(
                  //             FontAwesomeIcons.plus,
                  //             color: Colors.white,
                  //             size: 16,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
  // GestureDetector(
                  //   onTap: () {
                  //   },
                  //   child: Container(
                  //     // margin: buttonPadding,
                  //     height: 40.0,
                  //     width: MediaQuery.of(context).size.width,
                  //     decoration: BoxDecoration(
                  //       color: color,
                  //       borderRadius: BorderRadius.circular(35),
                  //     ),
                  //     child: Center(
                  //       child: Text(
                  //         'Save Change',
                  //         style: GoogleFonts.openSans(color: Colors.white),
                  //       ),
                  //     ),
                  //   ),
                  // ),

 // if (_imageFile == null) {
    //   return AppUtils.showSnackBar(
    //       "Please choose the photo!", _scaffoldKey.currentState);
    // }
    // if (_nameController.text == null || _nameController.text == "") {
    //   return AppUtils.showSnackBar(
    //       "Please Fill Service Name!", _scaffoldKey.currentState);
    // }
    // if (dropdownValue == null || dropdownValue == "") {
    //   return AppUtils.showSnackBar(
    //       "Please Allow Multiple Booking!", _scaffoldKey.currentState);
    // }
    // if (price.text == null || price.text == "") {
    //   return AppUtils.showSnackBar(
    //       "Please Fill Price!", _scaffoldKey.currentState);
    // }
    // if (maximumBooking.text == null || maximumBooking.text == "") {
    //   return AppUtils.showSnackBar(
    //       "Please Fill Maximum Booking!", _scaffoldKey.currentState);
    // }

    // if (startTime == null || startTime == "") {
    //   return AppUtils.showSnackBar(
    //       "Please Choose Start Time!", _scaffoldKey.currentState);
    // }

    //  if (endTime == null || startTime == "") {
    //   return AppUtils.showSnackBar(
    //       "Please Choose Start Time!", _scaffoldKey.currentState);
    // }