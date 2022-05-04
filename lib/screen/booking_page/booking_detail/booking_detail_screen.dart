import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_owner/helpers/response_ob.dart';
import 'package:shop_owner/screen/background_screen.dart';
import 'package:shop_owner/screen/booking_page/booking_detail/booking_detail_bloc.dart';
import 'package:shop_owner/screen/booking_page/booking_detail/booking_detail_object.dart';
import 'package:shop_owner/screen/booking_page/bookinglist_ob.dart';
import 'package:shop_owner/helpers/styleguide.dart';

class BookingDetailScreen extends StatefulWidget {
  final bool edit;
  final Bookinglistob bookingOb;
  BookingDetailScreen({this.edit, this.bookingOb});
  @override
  _BookingDetailScreenState createState() => _BookingDetailScreenState();
}

class _BookingDetailScreenState extends State<BookingDetailScreen> {
  var _bloc = BookingDetailBloc();
  String bookingTime;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc.bookingDetail(widget.bookingOb.id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: color,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 13.0, right: 12.0),
              child: Text(
                'Booking Detail',
                textAlign: TextAlign.right,
                style: GoogleFonts.openSans(
                    fontSize: 20.0,
                    letterSpacing: 1.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ],
        ),
        body: StreamBuilder<ResponseOb>(
            stream: _bloc.bookingdetailStream(),
            initialData: ResponseOb(message: MsgState.loading),
            builder: (context, snapshot) {
              ResponseOb resp = snapshot.data;
              if (resp.message == MsgState.loading) {
                return Center(child: CircularProgressIndicator(color: color));
              } else if (resp.message == MsgState.errors) {
                return Center(
                  child: Text("Something Wrong, try again!",
                      style: TextStyle(color: Colors.white)),
                );
              } else {
                // print(widget.edit);
                BookingDetailOb item = resp.data;
                print("Booking Detail Object => $item");
                return Column(
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        HomeBackgroundPage(
                          screenHeight: 600,
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(10.0, 60.0, 10.0, 16.0),
                          width: MediaQuery.of(context).size.width,
                          // height: MediaQuery.of(context).size.height,
                          child:
                              Stack(alignment: Alignment.topCenter, children: [
                            Container(
                              margin: EdgeInsets.only(top: 70.0),
                              padding: EdgeInsets.only(top: 65.0),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.8),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 5), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(children: [
                                SizedBox(height: 33),
                                Text(
                                  item.customerFirstname.toString() +
                                      " " +
                                      item.customerLastname.toString(),
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.openSans(
                                      color: Colors.black,
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  item.customerEmail.toString(),
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.openSans(
                                    color: Colors.black54,
                                  ),
                                ),
                                SizedBox(height: 25),
                                Row(
                                  children: [
                                    SizedBox(width: 20),
                                    Expanded(
                                        flex: 3, child: Text("Service Name")),
                                    Expanded(
                                      flex: 1,
                                      child: Text(":"),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(item.title),
                                    )
                                  ],
                                ),
                                SizedBox(height: 18),
                                Row(
                                  children: [
                                    SizedBox(width: 20),
                                    Expanded(flex: 3, child: Text("Status")),
                                    Expanded(
                                      flex: 1,
                                      child: Text(":"),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(item.status.toString()),
                                    )
                                  ],
                                ),
                                SizedBox(height: 15),
                                Row(
                                  children: [
                                    SizedBox(width: 20),
                                    Expanded(
                                        flex: 3, child: Text("Booking Date")),
                                    Expanded(
                                      flex: 1,
                                      child: Text(":"),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(item.bookingDate.toString()),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 18),
                                Row(
                                  children: [
                                    SizedBox(width: 20),
                                    Expanded(
                                        flex: 3, child: Text("Booking Time")),
                                    Expanded(
                                      flex: 1,
                                      child: Text(":"),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(item.bookingTime.toString()),
                                    )
                                  ],
                                ),
                                SizedBox(height: 18),
                                Row(
                                  children: [
                                    SizedBox(width: 20),
                                    Expanded(flex: 3, child: Text("Quantity")),
                                    Expanded(
                                      flex: 1,
                                      child: Text(":"),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(item.quantity.toString()),
                                    )
                                  ],
                                ),
                                SizedBox(height: 18),
                                Row(
                                  children: [
                                    SizedBox(width: 20),
                                    Expanded(flex: 3, child: Text("Bill")),
                                    Expanded(
                                      flex: 1,
                                      child: Text(":"),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text("12,000 MMK"),
                                    )
                                  ],
                                ),
                                SizedBox(height: 18),
                                Row(
                                  children: [
                                    SizedBox(width: 20),
                                    Expanded(
                                        flex: 3, child: Text("Payment Status")),
                                    Expanded(
                                      flex: 1,
                                      child: Text(":"),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(item.paymentStatus),
                                    )
                                  ],
                                ),
                                SizedBox(height: 18),
                                Row(
                                  children: [
                                    SizedBox(width: 20),
                                    Expanded(
                                        flex: 3, child: Text("Created Date")),
                                    Expanded(
                                      flex: 1,
                                      child: Text(":"),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text("20 Dec 2021"),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20),
                                widget.edit == true
                                    ? GestureDetector(
                                        onTap: null,
                                        child: Container(
                                          height: 37,
                                          margin: EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                            color: Colors.black38,
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Confirm Booking',
                                              style: GoogleFonts.openSans(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      )
                                    : SizedBox(),
                                SizedBox(height: 20),
                              ]),
                            ),
                            Container(
                              // margin: EdgeInsets.only(top: 10.0),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.8),
                                    spreadRadius: 1,
                                    offset: Offset(
                                        0, 0.5), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 80,
                                backgroundColor: Colors.white,
                                backgroundImage:
                                    AssetImage('assets/images/robert.jpg'),
                              ),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ],
                );
              }
            }),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _bloc.dispose();
    super.dispose();
  }
}
