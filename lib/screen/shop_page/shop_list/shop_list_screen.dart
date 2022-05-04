import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shop_owner/helpers/response_ob.dart';
import 'package:shop_owner/screen/common_widget/appbar_screen.dart';
import 'package:shop_owner/screen/delete_widget/delete_bloc.dart';
import 'package:shop_owner/screen/drawer_page/drawer.dart';
import 'package:shop_owner/screen/google_map/map_screen.dart';
import 'package:shop_owner/screen/shop_page/shop_detail/shop_detail.dart';
import 'package:shop_owner/screen/shop_page/shop_list/shop_list_bloc.dart';
import 'package:shop_owner/screen/shop_page/shop_list/shop_list_ob.dart';
import 'package:shop_owner/screen/shop_page/shop_update/shop_update_screen.dart';
import 'package:shop_owner/helpers/styleguide.dart';
import 'package:shop_owner/utils/app_constants.dart';

class ShopListScreen extends StatefulWidget {
  @override
  _ShopListScreenState createState() => _ShopListScreenState();
}

class _ShopListScreenState extends State<ShopListScreen> {
  bool downButton = true;
  String starttime;
  String endtime;
  String dateRange;
  String statusValue;
  TextEditingController sname = TextEditingController();
  TextEditingController sphone = TextEditingController();
  TextEditingController semail = TextEditingController();
  TextEditingController saddress = TextEditingController();
  TextEditingController sdescription = TextEditingController();
  int index;
  List<String> statusList = ["Active", "Pending", "Canceled"];
  List<ShopListOb> shopList;
  DateTime selectedDate = DateTime.now();
  var _bloc = ShopListBloc();
  DeleteBloc _deleteBloc = DeleteBloc();
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc.shoplist();
    _deleteListen();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      drawer: DrawerScreen(),
      appBar: BaseAppBar(
        title: 'Shop List',
        appBar: AppBar(),
      ),
      body: ModalProgressHUD(
        child: StreamBuilder<ResponseOb>(
          stream: _bloc.shoplistStream(),
          initialData: ResponseOb(message: MsgState.loading),
          builder: (context, snapshot) {
            ResponseOb resp = snapshot.data;
            if (resp.message == MsgState.loading) {
              return Center(
                child: CircularProgressIndicator(color: color),
              );
            } else if (resp.message == MsgState.errors) {
              return Center(
                child: Text("Something Wrong, try again!",
                    style: TextStyle(color: Colors.white)),
              );
            } else {
              shopList = resp.data;
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return ShopUpdateScreen(
                              data: null, title: "New Shop");
                        })).then((value) => _bloc.shoplist());
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
                            'Add Shop',
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
                      flex: 1,
                      child: shopList.length > 0
                          ? ListView(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              children: List.generate(
                                shopList.length,
                                (index) {
                                  return Column(
                                    children: [
                                      Container(
                                        height: 35,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (shopList[index].ownerShop ==
                                                  false) {
                                                shopList[index].ownerShop =
                                                    true;
                                                downButton = false;
                                              } else {
                                                shopList[index].ownerShop =
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
                                                      BorderRadius.circular(
                                                          50.0),
                                                ),
                                                child: shopList[index]
                                                            .ownerShop ==
                                                        false
                                                    ? Icon(
                                                        FontAwesomeIcons
                                                            .chevronDown,
                                                        color: Colors.white,
                                                        size: 15,
                                                      )
                                                    : Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
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
                                                  'Shop',
                                                  style: serviceTitleText,
                                                ),
                                              ),
                                              Expanded(
                                                  flex: 1, child: Text(':')),
                                              Expanded(
                                                flex: 6,
                                                child: Text(
                                                  shopList[index]
                                                      .sname
                                                      .toString(),
                                                  style: serviceDataText,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      shopList[index].ownerShop == true
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
                                                          style:
                                                              serviceTitleText,
                                                        ),
                                                      ),
                                                      Expanded(
                                                          flex: 1,
                                                          child: Text(':')),
                                                      Expanded(
                                                        flex: 6,
                                                        child: Text(
                                                          shopList[index]
                                                              .status
                                                              .toString(),
                                                          style:
                                                              serviceDataText,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // Container(
                                                //   height: 40,
                                                //   child: Row(
                                                //     children: [
                                                //       // SizedBox(width: 20),
                                                //       SizedBox(width: 61),
                                                //       Expanded(
                                                //         flex: 4,
                                                //         child: Text(
                                                //           'Date',
                                                //           style: serviceTitleText,
                                                //         ),
                                                //       ),
                                                //       Expanded(
                                                //           flex: 1,
                                                //           child: Text(':')),
                                                //       Expanded(
                                                //         flex: 6,
                                                //         child: Text(
                                                //           shopList[index]
                                                //               .screatedAt,
                                                //           style: serviceDataText,
                                                //         ),
                                                //       ),
                                                //     ],
                                                //   ),
                                                // ),

                                                Container(
                                                  height: 40,
                                                  child: Row(
                                                    children: [
                                                      SizedBox(width: 61),
                                                      Expanded(
                                                        flex: 4,
                                                        child: Text(
                                                          'Email',
                                                          style:
                                                              serviceTitleText,
                                                        ),
                                                      ),
                                                      Expanded(
                                                          flex: 1,
                                                          child: Text(':')),
                                                      Expanded(
                                                        flex: 6,
                                                        child: Text(
                                                          shopList[index]
                                                              .semail
                                                              .toString(),
                                                          style:
                                                              serviceDataText,
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
                                                          'Phone',
                                                          style:
                                                              serviceTitleText,
                                                        ),
                                                      ),
                                                      Expanded(
                                                          flex: 1,
                                                          child: Text(':')),
                                                      Expanded(
                                                        flex: 6,
                                                        child: Text(
                                                          shopList[index]
                                                              .sphone
                                                              .toString(),
                                                          style:
                                                              serviceDataText,
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
                                                          style:
                                                              serviceTitleText,
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
                                                                shopList[index]
                                                                    .id),
                                                            _editContainer(
                                                                shopList[index],
                                                                index),
                                                            _eyeContainer(
                                                                shopList[
                                                                    index]),
                                                            shopList[index]
                                                                        .latitude ==
                                                                    null
                                                                ? SizedBox()
                                                                : _map(shopList[
                                                                    index])
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
                              ),
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

  _addShopAlert() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        contentPadding: EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Container(
          width: MediaQuery.of(context).size.width - 10,
          // height: MediaQuery.of(context).size.height / 2.8,
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
                        controller: sname,
                        style: GoogleFonts.openSans(fontSize: 15),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Name',
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
                        controller: sphone,
                        keyboardType: TextInputType.number,
                        style: GoogleFonts.openSans(fontSize: 15),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Phone',
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
                        controller: semail,
                        style: GoogleFonts.openSans(fontSize: 15),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
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
                    Container(
                      height: 62,
                      decoration: boxDecoration,
                      padding: EdgeInsets.only(
                        left: 12.0,
                      ),
                      margin: EdgeInsets.only(
                        top: 3.0,
                      ),
                      child: TextField(
                        maxLines: null,
                        controller: saddress,
                        style: GoogleFonts.openSans(fontSize: 15),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Address',
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 84,
                      decoration: boxDecoration,
                      padding: EdgeInsets.only(
                        left: 12.0,
                      ),
                      margin: EdgeInsets.only(
                        top: 3.0,
                      ),
                      child: TextField(
                        // readOnly: true,
                        expands: true,
                        maxLines: null,
                        minLines: null,
                        controller: sdescription,
                        style: GoogleFonts.openSans(fontSize: 15),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Description',
                        ),
                      ),
                    ),
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
                          onTap: () {
                            setState(() {
                              // Map<String, dynamic> shopListOb = {
                              //   "sname": sname.text,
                              //   "sphone": sphone.text,
                              //   "semail": semail.text,
                              //   "status": statusValue,
                              //   "saddress": saddress.text,
                              //   "sdescription": sdescription.text,
                              //   "owner_shop": false
                              // };
                              shopList.add(ShopListOb(
                                  sname: sname.text == null ? "" : sname.text,
                                  sphone:
                                      sphone.text == null ? "" : sphone.text,
                                  semail:
                                      semail.text == null ? "" : semail.text,
                                  status:
                                      statusValue == null ? "" : statusValue,
                                  saddress: saddress.text == null
                                      ? ""
                                      : saddress.text,
                                  sdescription: sdescription.text == null
                                      ? ""
                                      : sdescription.text,
                                  ownerShop: false));
                            });
                            sname.clear();
                            sphone.clear();
                            semail.clear();
                            statusValue = "";
                            saddress.clear();
                            sdescription.clear();
                            Navigator.pop(context);
                          },
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
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _deleteContainer(shopId) {
    return Container(
      margin: EdgeInsets.only(right: 10.0),
      padding: EdgeInsets.all(5.0),
      height: 30.0,
      width: 30.0,
      decoration: BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white),
      ),
      child: GestureDetector(
        onTap: () {
          setState(() {
            loading = true;
          });
          _deleteBloc.deleteObject(SHOP_DELETE_URL + shopId.toString());
        },
        child: Center(
          child: Icon(
            Icons.delete,
            color: Colors.white,
            size: 17,
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
          return ShopUpdateScreen(data: data, title: "Edit Shop");
        })).then((value) {
          _bloc.shoplist();
        });
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
          child: Image.asset("assets/images/pen-color.png")),
    );
  }

  _eyeContainer(shop) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ShopDetail(shop),
          ),
        );
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

  _map(ShopListOb shopListOb) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MapScreen(
                lat: double.parse(shopListOb.latitude),
                long: double.parse(shopListOb.longitude))));
      },
      child: Container(
        margin: EdgeInsets.only(right: 10.0),
        // padding: EdgeInsets.all(5.0),
        height: 30.0,
        width: 30.0,
        decoration: BoxDecoration(
          color: Colors.purple[50],
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white),
        ),
        child: Center(
          child: Icon(
            Icons.location_pin,
            color: Colors.green,
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
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dateRange = DateFormat("dd-MM-yyyy").format(selectedDate);
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
                    _bloc.shoplist();
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
