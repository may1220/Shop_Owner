import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shop_owner/helpers/response_ob.dart';
import 'package:shop_owner/screen/background_screen.dart';
import 'package:shop_owner/screen/booking_page/booking_creating/booking_creating_bloc.dart';
import 'package:shop_owner/screen/booking_page/booking_detail/booking_detail_bloc.dart';
import 'package:shop_owner/screen/booking_page/booking_detail/booking_detail_object.dart';
import 'package:shop_owner/screen/booking_page/bookinglist_ob.dart';
import 'package:shop_owner/screen/drawer_page/drawer.dart';
import 'package:shop_owner/screen/service_page/service_list/service_bloc.dart';
import 'package:shop_owner/screen/service_page/service_list/service_list_ob.dart';
import 'package:shop_owner/helpers/styleguide.dart';
import 'package:shop_owner/utils/app_constants.dart';

class BookingCreatingScreen extends StatefulWidget {
  final String title;
  final Bookinglistob bookinglistob;
  const BookingCreatingScreen({Key key, this.title, this.bookinglistob})
      : super(key: key);

  @override
  _BookingCreatingScreenState createState() => _BookingCreatingScreenState();
}

class _BookingCreatingScreenState extends State<BookingCreatingScreen> {
  final _formKey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();
  List<ServicesOb> _serviceList;
  ServicesOb selectedService;
  bool loading = false;
  String serviceName;
  String serviceId;
  String bookingDate;
  var _bloc = BookingDetailBloc();
  ServiceListBloc serviceListBloc = ServiceListBloc();
  BookingCreatinglBloc _bookingCreatingBloc = BookingCreatinglBloc();
  BookingDetailOb bookingDetailOb;
  TextEditingController numberOfAdaultController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
    _getServiceList();
  }

  getData() {
    if (widget.bookinglistob != null) {
      // serviceId = widget.bookinglistob.
      _bloc.bookingDetail(widget.bookinglistob.id);
      _bloc.bookingdetailStream().listen((ResponseOb response) {
        if (response.message == MsgState.data) {
          setState(() {
            bookingDetailOb = response.data;
            numberOfAdaultController.text = bookingDetailOb.quantity;
            bookingDate = bookingDetailOb.bookingDate;
            firstNameController.text = bookingDetailOb.customerFirstname;
            lastNameController.text = bookingDetailOb.customerLastname;
            emailController.text = bookingDetailOb.customerEmail;
            phoneController.text = bookingDetailOb.customerPhone;
            serviceId = bookingDetailOb.serviceId;
            commentController.text = bookingDetailOb.comment;
          });
        }
      });
    }
  }

  _getServiceList() {
    serviceListBloc.servicelist();
    serviceListBloc
      ..servicelistStream().listen((ResponseOb response) {
        if (response.message == MsgState.data) {
          setState(() {
            _serviceList = response.data;
            _serviceList.forEach((serviceOb) {
              if (serviceOb.id.toString() == serviceId) {
                selectedService = serviceOb;
                serviceName = serviceOb.title;
              }
            });
          });
        }
      });
  }

  bookingCreatingListen() {
    _bookingCreatingBloc.bookingCreatingStream().listen((ResponseOb response) {
      if (response.message == MsgState.data) {
        setState(() {
          _serviceList = response.data;
          _serviceList.forEach((serviceOb) {
            if (serviceOb.id.toString() == serviceId) {
              selectedService = serviceOb;
              serviceName = serviceOb.title;
            }
          });
        });
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
                  widget.title,
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
                bookingWidget(),
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

  Widget bookingWidget() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
          margin:
              EdgeInsets.only(top: 20.0, bottom: 8.0, right: 10.0, left: 10.0),
          decoration: cardShawdowDecoration,
          width: MediaQuery.of(this.context).size.width,
          child: Column(
            children: [
              _serviceList == null
                  ? SizedBox()
                  : Container(
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          child: new DropdownButtonFormField<ServicesOb>(
                            isExpanded: true,
                            value: selectedService,
                            hint: Text(
                              serviceName == null
                                  ? 'Choose Service'
                                  : serviceName,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.openSans(
                                  fontSize: 15, color: Colors.black),
                            ),
                            decoration: inputDecoration(""),
                            items: _serviceList.map((ServicesOb servicesOb) {
                              return new DropdownMenuItem<ServicesOb>(
                                value: servicesOb,
                                child: new Text(
                                  servicesOb.title,
                                  style: editTextStyle,
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                serviceId = value.id.toString();
                                serviceName = value.title.toString();
                              });
                            },
                            validator: (value) {
                              if (value == null) {
                                return "Service must not be null.";
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
              Container(
                child: TextFormField(
                  controller: TextEditingController(text: bookingDate),
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
                    hintText: 'Booking Date',
                    contentPadding: EdgeInsets.only(
                      left: 14,
                    ),
                    suffixIcon: InkWell(
                      onTap: () {
                        _selectDate(this.context);
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
                    if (value == "null" || value == null || value.isEmpty) {
                      return "Date must not be empty.";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: TextFormField(
                  controller: numberOfAdaultController,
                  keyboardType: TextInputType.number,
                  decoration: inputDecoration("Number of adults"),
                  style: editTextStyle,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Number of adults must not be empty.";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: TextFormField(
                  controller: firstNameController,
                  decoration: inputDecoration("First Name"),
                  style: editTextStyle,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "First Name must not be empty.";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: TextFormField(
                  controller: lastNameController,
                  decoration: inputDecoration("Last Name"),
                  style: editTextStyle,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Last Name must not be empty.";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: TextFormField(
                  controller: emailController,
                  decoration: inputDecoration("Email"),
                  style: editTextStyle,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email must not be empty";
                    } else {
                      if (!value.endsWith("@gmail.com") &&
                          !value.endsWith("@demo.com")) {
                        return "Invalid email";
                      }
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  decoration: inputDecoration("Phone"),
                  style: editTextStyle,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Phone must not be empty.";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: TextFormField(
                  controller: commentController,
                  maxLines: 6,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    hintText: "Comment",
                    contentPadding: EdgeInsets.only(
                      top: 14,
                      left: 14,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  style: editTextStyle,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 5.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: RaisedButton(
                        onPressed: widget.bookinglistob == null
                            ? createBooking
                            : updateBooking,
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
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1600, 8),
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
        bookingDate = DateFormat("yyyy-MM-dd").format(selectedDate).toString();
      });
  }

  createBooking() {
    if (_formKey.currentState.validate()) {
      setState(() {
        loading = true;
      });
      Map<String, String> map = {
        "id": serviceId,
        "booking_date": bookingDate,
        "first_name": firstNameController.text,
        "last_name": lastNameController.text,
        "email": emailController.text,
        "phone": phoneController.text,
        "comment": commentController.text
      };
      print(map);
      _bookingCreatingBloc.bookingCreating(map, CREATE_BOOKING_URL);
    }
  }

  updateBooking() {
    // BOOKING_UPDATE_URL
    if (_formKey.currentState.validate()) {
      setState(() {
        loading = true;
      });
      Map<String, String> map = {
        "id": serviceId,
        "booking_date": bookingDate,
        "first_name": firstNameController.text,
        "last_name": lastNameController.text,
        "email": emailController.text,
        "phone": phoneController.text,
        "comment": commentController.text,
        "booking_time": "12:00PM"
      };
      print(map);
      _bookingCreatingBloc.bookingCreating(map, BOOKING_UPDATE_URL);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _bloc.dispose();
    serviceListBloc.dispose();
    _bookingCreatingBloc.dispose();
    super.dispose();
  }
}
