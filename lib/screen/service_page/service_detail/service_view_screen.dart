import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shop_owner/helpers/response_ob.dart';
import 'package:shop_owner/screen/common_widget/appbar_screen.dart';
import 'package:shop_owner/screen/delete_widget/delete_bloc.dart';
import 'package:shop_owner/screen/drawer_page/drawer.dart';
import 'package:shop_owner/screen/service_page/service_list/services_list_screen.dart';
import 'package:shop_owner/screen/service_page/service_update/editservice_screen.dart';
import 'package:shop_owner/screen/service_page/service_list/service_list_ob.dart';
import 'package:shop_owner/helpers/styleguide.dart';
import 'package:shop_owner/utils/app_constants.dart';

class ServiceViewScreen extends StatefulWidget {
  final ServicesOb data;
  ServiceViewScreen({Key key, this.data}) : super(key: key);
  @override
  _ServiceViewScreenState createState() => _ServiceViewScreenState();
}

class _ServiceViewScreenState extends State<ServiceViewScreen> {
  bool loading = false;
  DeleteBloc _deleteBloc = DeleteBloc();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _deleteListener();
  }

  _deleteListener() {
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
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return ServicesScreen();
                    }), (route) => false);
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: BaseAppBar(
          title: widget.data.title.toString(),
          appBar: AppBar(),
        ),
        drawer: DrawerScreen(),
        body: ModalProgressHUD(
          child: SingleChildScrollView(
            child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 200,
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        image: DecorationImage(
                            image: AssetImage('assets/images/5.jpg'),
                            fit: BoxFit.cover)),
                    // child:  Image.asset('assets/images/5.jpg',fit: BoxFit.cover,),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.0, right: 20.0),
                    padding: EdgeInsets.only(
                        top: 20.0, left: 20.0, right: 10.0, bottom: 25.0),
                    decoration: BoxDecoration(
                      color: Color(0xFFEEEEEE),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                flex: 4,
                                child: Text(
                                  'Service Name',
                                  style: serviewviewbold,
                                )),
                            Expanded(
                              flex: 1,
                              child: Text(":"),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(widget.data.title.toString()),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 4,
                                child: Text(
                                  'Price',
                                  style: serviewviewbold,
                                )),
                            Expanded(
                              flex: 1,
                              child: Text(":"),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(widget.data.price.toString()),
                            ),
                          ],
                        ),
                        SizedBox(height: 13),
                        Row(
                          children: [
                            Expanded(
                                flex: 4,
                                child: Text(
                                  'Start & End',
                                  style: serviewviewbold,
                                )),
                            Expanded(
                              flex: 1,
                              child: Text(":"),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(
                                  "${widget.data.serviceStarts} to ${widget.data.serviceEnds}"),
                            ),
                          ],
                        ),
                        SizedBox(height: 13),
                        Row(
                          children: [
                            Expanded(
                                flex: 4,
                                child: Text(
                                  'Duration',
                                  style: serviewviewbold,
                                )),
                            Expanded(
                              flex: 1,
                              child: Text(":"),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(widget.data.serviceDurationType),
                            ),
                          ],
                        ),
                        SizedBox(height: 13),
                        Row(
                          children: [
                            Expanded(
                                flex: 4,
                                child: Text(
                                  'Service Buffering Time',
                                  style: serviewviewbold,
                                )),
                            Expanded(
                              flex: 1,
                              child: Text(":"),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(widget.data.bufferTime.toString()),
                            ),
                          ],
                        ),
                        SizedBox(height: 13),
                        Row(
                          children: [
                            Expanded(
                                flex: 4,
                                child: Text(
                                  'Allow Multiple Bookings',
                                  style: serviewviewbold,
                                )),
                            Expanded(
                              flex: 1,
                              child: Text(":"),
                            ),
                            Expanded(
                              flex: 4,
                              child:
                                  Text(widget.data.multipleBookings.toString()),
                            ),
                          ],
                        ),
                        SizedBox(height: 13),
                        Row(
                          children: [
                            Expanded(
                                flex: 4,
                                child: Text(
                                  'Created Date',
                                  style: serviewviewbold,
                                )),
                            Expanded(
                              flex: 1,
                              child: Text(":"),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(widget.data.createdAt.toString()),
                            ),
                          ],
                        ),
                        SizedBox(height: 7),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //         flex: 4,
                        //         child: Text(
                        //           'Status',
                        //           style: serviewviewbold,
                        //         )),
                        //     Expanded(
                        //       flex: 1,
                        //       child: Text(":"),
                        //     ),
                        //     Expanded(
                        //       flex: 4,
                        //       child: Text(widget.data.sta),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 15.0, bottom: 15.0, left: 20.0),
                          child: Text(
                            'Description',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, left: 20, right: 20),
                          child: Text(
                            widget.data.description.toString(),
                            textAlign: TextAlign.left,
                            // overflow: TextOverflow.ellipsis,
                            maxLines: null,
                          ),
                        ),
                        SizedBox(height: 10),
                      ]),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 5.0),
                          child: Text(
                            'Return Service',
                            style: GoogleFonts.openSans(
                                color: color, fontSize: 17),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            loading = true;
                          });
                          _deleteBloc.deleteObject(
                              SERVICE_DELETE_URL + widget.data.id.toString());
                        },
                        child: Container(
                          height: 36.0,
                          width: 80,
                          margin: EdgeInsets.only(
                            left: 5.0,
                            bottom: 5.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red[400],
                            borderRadius: BorderRadius.circular(35),
                          ),
                          child: Center(
                            child: Text(
                              'Delete',
                              style: GoogleFonts.openSans(
                                  color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => EditServiceScreen(
                                data: widget.data,
                                title: "Edit Service",
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 36.0,
                          width: 70,
                          margin: EdgeInsets.only(
                              left: 5.0, bottom: 5.0, right: 5.0),
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(35),
                          ),
                          child: Center(
                            child: Text(
                              'Edit',
                              style: GoogleFonts.openSans(
                                  color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
          ),
          inAsyncCall: loading,
          opacity: 0.5,
          progressIndicator: CircularProgressIndicator(
            color: color,
          ),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
