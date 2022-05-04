import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shop_owner/helpers/response_ob.dart';
import 'package:shop_owner/screen/common_widget/appbar_screen.dart';
import 'package:shop_owner/screen/delete_widget/delete_bloc.dart';
import 'package:shop_owner/screen/drawer_page/drawer.dart';
import 'package:shop_owner/screen/service_page/service_update/editservice_screen.dart';
import 'package:shop_owner/screen/service_page/service_detail/service_view_screen.dart';
import 'package:shop_owner/screen/service_page/service_list/service_bloc.dart';
import 'package:shop_owner/screen/service_page/service_list/service_list_ob.dart';
import 'package:shop_owner/helpers/styleguide.dart';
import 'package:shop_owner/utils/app_constants.dart';

class ServicesScreen extends StatefulWidget {
  @override
  _ServicesScreenState createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  bool upButton = false;
  bool downButton = true;
  bool checkValue = false;
  String starttime;
  String endtime;
  String _currText = '';
  List<ServicesOb> servicelistData;
  int index;
  var _bloc = ServiceListBloc();
  DeleteBloc _deleteBloc = DeleteBloc();
  bool loading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc.servicelist();
    _deleteListen();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: BaseAppBar(
          title: 'Services',
          appBar: AppBar(),
        ),
        drawer: DrawerScreen(),
        body: ModalProgressHUD(
          child: StreamBuilder<ResponseOb>(
              stream: _bloc.servicelistStream(),
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
                  servicelistData = resp.data;

                  return Column(children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (context) => EditServiceScreen(
                                    data: null, title: "New Service")))
                            .then((value) => _bloc.servicelist());
                      },
                      child: Container(
                        height: 40,
                        margin: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Center(
                          child: Text(
                            'CREATE NEW',
                            style: GoogleFonts.openSans(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
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
                        children:
                            List.generate(servicelistData.length, (index) {
                          // starttime = servicelistData[index]["starttime"];
                          // endtime = servicelistData[index]["endtime"];
                          return Column(
                            children: [
                              Container(
                                height: 37,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (servicelistData[index].ownerService ==
                                          false) {
                                        servicelistData[index].ownerService =
                                            true;
                                        downButton = false;
                                      } else {
                                        servicelistData[index].ownerService =
                                            false;
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
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                        ),
                                        child: servicelistData[index]
                                                    .ownerService ==
                                                false
                                            ? Icon(
                                                FontAwesomeIcons.chevronDown,
                                                color: Colors.white,
                                                size: 15,
                                              )
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 3.0),
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
                                          'Service Name',
                                          style: serviceTitleText,
                                        ),
                                      ),
                                      Expanded(flex: 1, child: Text(':')),
                                      Expanded(
                                        flex: 5,
                                        child: Text(
                                          servicelistData[index].title,
                                          style: serviceDataText,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              servicelistData[index].ownerService == true
                                  ? Column(children: [
                                      Container(
                                        height: 40,
                                        child: Row(
                                          children: [
                                            SizedBox(width: 61),
                                            Expanded(
                                              flex: 4,
                                              child: Text(
                                                'Price',
                                                style: serviceTitleText,
                                              ),
                                            ),
                                            Expanded(flex: 1, child: Text(':')),
                                            Expanded(
                                              flex: 5,
                                              child: Text(
                                                servicelistData[index].price,
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
                                                'Start & End',
                                                style: serviceTitleText,
                                              ),
                                            ),
                                            Expanded(flex: 1, child: Text(':')),
                                            Expanded(
                                              flex: 5,
                                              child: Text(
                                                "${servicelistData[index].serviceStarts} to ${servicelistData[index].serviceEnds}",
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
                                                'Created Date',
                                                style: serviceTitleText,
                                              ),
                                            ),
                                            Expanded(flex: 1, child: Text(':')),
                                            Expanded(
                                              flex: 5,
                                              child: Text(
                                                servicelistData[index]
                                                    .createdAt,
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
                                            Expanded(flex: 1, child: Text(':')),
                                            Expanded(
                                              flex: 5,
                                              child: Row(
                                                children: [
                                                  _deleteContainer(
                                                      servicelistData[index]
                                                          .id),
                                                  _editContainer(
                                                      servicelistData[index]),
                                                  _eyeContainer(
                                                      servicelistData[index])
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ])
                                  : SizedBox(),
                              Divider(
                                color: Colors.grey[100],
                                thickness: 1.5,
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                  ]);
                }
              }),
          inAsyncCall: loading,
          opacity: 0.5,
          progressIndicator: CircularProgressIndicator(
            color: color,
          ),
        ),
      ),
    );
  }

  _deleteContainer(serviceId) {
    return GestureDetector(
      onTap: () {
        setState(() {
          loading = true;
        });
        _deleteBloc.deleteObject(SERVICE_DELETE_URL + serviceId.toString());
      },
      child: Container(
        margin: EdgeInsets.only(right: 10.0),
        padding: EdgeInsets.all(5.0),
        height: 28.0,
        width: 28.0,
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

  _editContainer(data) {
    print("Booking Multiple => ${data.multipleBookings}");
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(
              MaterialPageRoute(
                builder: (context) =>
                    EditServiceScreen(data: data, title: "Edit Service"),
              ),
            )
            .then((value) => _bloc.servicelist());
        //   Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => MyForm(),
        //   ),
        // );
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

  _eyeContainer(data) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(
              MaterialPageRoute(
                builder: (context) => ServiceViewScreen(data: data),
              ),
            )
            .then((value) => _bloc.servicelist());
      },
      child: Container(
        margin: EdgeInsets.only(right: 10.0),
        padding: EdgeInsets.all(5.0),
        height: 28.0,
        width: 28.0,
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
                    _bloc.servicelist();
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
}
