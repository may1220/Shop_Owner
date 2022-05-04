import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shop_owner/helpers/response_ob.dart';
import 'package:shop_owner/helpers/shared_pref.dart';
import 'package:shop_owner/screen/booking_page/booking_creating/booking_creating_screen.dart';
import 'package:shop_owner/screen/common_widget/appbar_screen.dart';
import 'package:shop_owner/screen/booking_page/booking_detail/booking_detail_screen.dart';
import 'package:shop_owner/screen/booking_page/booking_list/booking_list_bloc.dart';
import 'package:shop_owner/screen/booking_page/bookinglist_ob.dart';
import 'package:shop_owner/screen/delete_widget/delete_bloc.dart';
import 'package:shop_owner/screen/drawer_page/drawer.dart';
import 'package:shop_owner/helpers/styleguide.dart';
import 'package:shop_owner/utils/app_constants.dart';

class BookingListScreen extends StatefulWidget {
  @override
  _BookingListScreenState createState() => _BookingListScreenState();
}

class _BookingListScreenState extends State<BookingListScreen> {
  String starttime;
  String endtime;
  TextEditingController dateRange = TextEditingController();
  int index;
  String statusValue;
  List<String> statusList = ["Cofirmed", "Pending", "Canceled"];
  String paymentStatusValue;
  List<String> paymentStatusList = ["Due", "Paid"];
  DateTime selectedDate = DateTime.now();
  var _bloc = BookingListBloc();
  ScrollController _scrollController = ScrollController();
  List<Bookinglistob> bookingList;
  List<Bookinglistob> bookingLists;
  int _pageSize = 20;
  int pageCount = 0;

  bool lastPage = false;
  bool allLoaded = false;
  DeleteBloc _deleteBloc = DeleteBloc();
  bool loading = false;
  TextEditingController searchController = TextEditingController();
  ResponseOb response;
  @override
  void initState() {
    super.initState();
    _onLoadData(false);
    _bloc.bookinglist();
    _deleteListen();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels * 2 >
          _scrollController.position.maxScrollExtent) {
        _pageSize = _pageSize + 20;
      }
    });
  }

  _onLoadData(bool type) async {
    BaseOptions options = BaseOptions();
    options.connectTimeout = 10000;
    options.receiveTimeout = 10000;

    String token = await SharedPref.getData(key: SharedPref.token);
    options.headers = {
      'Authorization': token,
    };

    Dio dio = new Dio(options);
    Response response = await dio.post(BOOKINGLIST_URL);
    int statusCode = response.statusCode;
    print(statusCode);
    ResponseOb respOb = new ResponseOb(); //data,message,err
    if (statusCode == 200) {
      respOb.data = response.data;
      print(respOb.data);
      bookingLists = BookingListResponseOb.fromJson(respOb.data).bookings;
      if (type == true) {
        ResponseOb resp = ResponseOb();
        resp.data = BookingListResponseOb.fromJson(respOb.data).bookings;
        _bloc.bookinglistController.sink.add(resp);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      drawer: DrawerScreen(),
      appBar: BaseAppBar(
        title: 'Booking List',
        appBar: AppBar(),
      ),
      body: ModalProgressHUD(
        child: StreamBuilder<ResponseOb>(
          stream: _bloc.bookinglistStream(),
          initialData: ResponseOb(message: MsgState.loading),
          builder: (context, snapshot) {
            ResponseOb resp = snapshot.data;
            if (resp.message == MsgState.loading) {
              return Center(
                child: CircularProgressIndicator(
                  color: color,
                ),
              );
            } else if (resp.message == MsgState.errors) {
              return Center(
                child: Text("Something Wrong, try again!",
                    style: TextStyle(color: Colors.white)),
              );
            } else {
              bookingList = resp.data;
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // GestureDetector(
                        //   onTap: () {
                        //     _onLoadData(true);
                        //   },
                        //   child: Container(
                        //     height: 40,
                        //     width: 85,
                        //     margin: EdgeInsets.all(10.0),
                        //     decoration: BoxDecoration(
                        //       color: color,
                        //       borderRadius: BorderRadius.circular(20.0),
                        //     ),
                        //     child: Center(
                        //       child: Text(
                        //         'ALL',
                        //         style: GoogleFonts.openSans(
                        //             color: Colors.white,
                        //             fontWeight: FontWeight.bold),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // GestureDetector(
                        //   onTap: () {
                        //     setState(() {
                        //       _addBookingListAlert();
                        //     });
                        //   },
                        //   child: Container(
                        //     height: 40,
                        //     width: 120,
                        //     margin: EdgeInsets.all(10.0),
                        //     decoration: BoxDecoration(
                        //       color: color,
                        //       borderRadius: BorderRadius.circular(20.0),
                        //     ),
                        //     child: Center(
                        //       child: Text(
                        //         'Booking List',
                        //         style: GoogleFonts.openSans(
                        //             color: Colors.white,
                        //             fontWeight: FontWeight.bold),
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    BookingCreatingScreen(
                                        title: "New Booking")));
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
                                'Add Booking',
                                style: GoogleFonts.openSans(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.grey[100],
                      thickness: 1.5,
                    ),
                    Expanded(
                      flex: 1,
                      child: bookingList.length > 0
                          ? ListView.builder(
                              // controller: _scrollController,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Container(
                                      height: 35,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (bookingList[index]
                                                    .ownerService ==
                                                false) {
                                              bookingList[index].ownerService =
                                                  true;
                                            } else {
                                              bookingList[index].ownerService =
                                                  false;
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
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                              ),
                                              child: bookingList[index]
                                                          .ownerService ==
                                                      false
                                                  ? Icon(
                                                      FontAwesomeIcons
                                                          .chevronDown,
                                                      color: Colors.white,
                                                      size: 15,
                                                    )
                                                  : Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 3.0),
                                                      child: Icon(
                                                        FontAwesomeIcons
                                                            .chevronUp,
                                                        color: Colors.white,
                                                        size: 15,
                                                      ),
                                                    ),
                                            ),
                                            SizedBox(width: 15),
                                            Expanded(
                                              flex: 4,
                                              child: Text(
                                                'Service',
                                                style: serviceTitleText,
                                              ),
                                            ),
                                            Expanded(flex: 1, child: Text(':')),
                                            Expanded(
                                              flex: 6,
                                              child: Text(
                                                bookingList[index].title,
                                                style: serviceDataText,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    bookingList[index].ownerService == true
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
                                                        'Status',
                                                        style: serviceTitleText,
                                                      ),
                                                    ),
                                                    Expanded(
                                                        flex: 1,
                                                        child: Text(':')),
                                                    Expanded(
                                                      flex: 6,
                                                      child: Text(
                                                        bookingList[index]
                                                            .status,
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
                                                        'Date',
                                                        style: serviceTitleText,
                                                      ),
                                                    ),
                                                    Expanded(
                                                        flex: 1,
                                                        child: Text(':')),
                                                    Expanded(
                                                      flex: 6,
                                                      child: Text(
                                                        bookingList[index]
                                                            .bookingDate,
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
                                                        'Payment',
                                                        style: serviceTitleText,
                                                      ),
                                                    ),
                                                    Expanded(
                                                        flex: 1,
                                                        child: Text(':')),
                                                    Expanded(
                                                      flex: 6,
                                                      child: Text(
                                                        bookingList[index]
                                                            .paidAmount
                                                            .toString(),
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
                                                        'Bill',
                                                        style: serviceTitleText,
                                                      ),
                                                    ),
                                                    Expanded(
                                                        flex: 1,
                                                        child: Text(':')),
                                                    Expanded(
                                                      flex: 6,
                                                      child: Text(
                                                        bookingList[index]
                                                            .bookingBill,
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
                                                        'Action',
                                                        style: serviceTitleText,
                                                      ),
                                                    ),
                                                    Expanded(
                                                        flex: 1,
                                                        child: Text(':')),
                                                    Expanded(
                                                      flex: 6,
                                                      child: Row(
                                                        children: [
                                                          _deleteContainer(
                                                              bookingList[index]
                                                                  .id),
                                                          _editContainer(
                                                              bookingList[
                                                                  index],
                                                              index),
                                                          _eyeContainer(
                                                              bookingList[
                                                                  index],
                                                              index)
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        : SizedBox(),
                                    Divider(),
                                  ],
                                );
                              },
                              // separatorBuilder: (context, index) {
                              //   return Divider();
                              // },
                              itemCount: bookingList.length,
                              // shrinkWrap: true,
                              // physics: ClampingScrollPhysics(),
                            )
                          : SizedBox(),
                    ),
                  ]);
            }
          },
        ),
        inAsyncCall: loading,
        opacity: 0.5,
        progressIndicator: CircularProgressIndicator(
          color: color,
        ),
      ),
    ));
  }

  _addBookingListAlert() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        contentPadding: EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Container(
          width: MediaQuery.of(context).size.width - 10,
          height: MediaQuery.of(context).size.height / 2.8,
          child: ClipRRect(
            child: Card(
              margin: EdgeInsets.zero,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    Container(
                      height: 42,
                      decoration: boxDecoration,
                      padding: EdgeInsets.only(
                        left: 12.0,
                      ),
                      margin: EdgeInsets.only(
                        top: 13.0,
                      ),
                      child: TextField(
                        // readOnly: true,
                        controller: searchController,
                        style: GoogleFonts.openSans(fontSize: 15),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search',
                          suffixIcon: InkWell(
                            onTap: () {
                              // filter(String searchQuery) {

                              // _selectDate(context, 'startDate');
                            },
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 3.0),
                              child: Icon(
                                FontAwesomeIcons.search,
                                size: 18,
                                color: Colors.black45,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 42,
                      decoration: boxDecoration,
                      padding: EdgeInsets.only(
                        left: 12.0,
                      ),
                      margin: EdgeInsets.only(
                        top: 3.0,
                      ),
                      child: TextField(
                        // readOnly: true,
                        controller: dateRange,
                        style: GoogleFonts.openSans(fontSize: 15),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Date Range',
                          suffixIcon: InkWell(
                            onTap: () {
                              _selectDate(context);
                            },
                            child: Icon(
                              FontAwesomeIcons.calendarAlt,
                              size: 18,
                              color: Colors.black45,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                      return Container(
                        height: 42,
                        margin: EdgeInsets.only(
                          top: 3.0,
                        ),
                        decoration: boxDecoration,
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton<String>(
                              value: statusValue,
                              isExpanded: true,
                              hint:
                                  Text('Status', style: GoogleFonts.openSans()),
                              items: statusList.map((value) {
                                return new DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  statusValue = value;
                                });
                              },
                            ),
                          ),
                        ),
                      );
                    }),
                    SizedBox(height: 10),
                    StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                      return Container(
                        height: 42,
                        margin: EdgeInsets.only(
                          top: 3.0,
                        ),
                        decoration: boxDecoration,
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton<String>(
                              value: paymentStatusValue,
                              isExpanded: true,
                              hint: Text('Payment Status',
                                  style: GoogleFonts.openSans()),
                              items: paymentStatusList.map((value) {
                                return new DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  paymentStatusValue = value;
                                });
                              },
                            ),
                          ),
                        ),
                      );
                    }),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 33.0,
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
                          onTap: _filtering,
                          child: Container(
                            height: 33.0,
                            width: 100,
                            margin: EdgeInsets.only(
                              left: 5.0,
                              bottom: 5.0,
                            ),
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                'Apply',
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
            ),
          ),
        ),
      ),
    );
  }

  _filtering() {
    print(
        "${searchController.text} $statusValue $paymentStatusValue ${dateRange.text}");
    print(bookingLists);

    List<Bookinglistob> _filteredList =
        bookingLists.where((Bookinglistob user) {
      print(user.bookingDate);
      print(dateRange.text);

      return user.title
          .toLowerCase()
          .contains(searchController.text.toLowerCase());
    }).toList();
    response = ResponseOb();
    response.data = _filteredList;
    print(response.data);
    _bloc.bookinglistController.sink.add(response);
    searchController.clear();
    dateRange.clear();
    Navigator.of(context).pop();
  }

  _deleteContainer(bookingId) {
    return GestureDetector(
      onTap: () {
        setState(() {
          loading = true;
        });
        _deleteBloc.deleteObject(BOOKING_DELETE_URL + bookingId.toString());
      },
      child: Container(
        margin: EdgeInsets.only(right: 10.0),
        padding: EdgeInsets.all(5.0),
        height: 30.0,
        width: 30.0,
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
      ),
    );
  }

  _editContainer(data, index) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return new BookingCreatingScreen(
              title: "Edit Booking", bookinglistob: data);
        }));
      },
      child: Container(
          margin: EdgeInsets.only(right: 10.0),
          padding: EdgeInsets.all(5.0),
          height: 30.0,
          width: 30.0,
          decoration: BoxDecoration(
            color: Colors.purple[50],
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white),
            // image: DecorationImage(image: AssetImage("assets/images/pen-color.png",hei))
          ),
          child: Image.asset("assets/images/pen-color.png")),
    );
  }

  _eyeContainer(data, index) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return new BookingDetailScreen(edit: false, bookingOb: data);
        }));
      },
      child: Container(
        margin: EdgeInsets.only(right: 10.0),
        padding: EdgeInsets.all(5.0),
        height: 30.0,
        width: 30.0,
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
        dateRange.text =
            DateFormat("yyyy-MM-dd").format(selectedDate).toString();
      });
  }

  _deleteListen() {
    _deleteBloc.deleteStream().listen((ResponseOb responseOb) {
      if (responseOb.message == MsgState.data) {
        setState(() {
          loading = false;
        });
        return showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Center(child: Text(responseOb.data["message"])),
            actions: [
              Center(
                child: TextButton(
                  child: const Text('OK',
                      style: TextStyle(color: Color(0xFF6600cc), fontSize: 20)),
                  onPressed: () {
                    _bloc.bookinglist();
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _bloc.dispose();
    super.dispose();
  }
}
