import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shop_owner/helpers/response_ob.dart';
import 'package:shop_owner/screen/common_widget/appbar_screen.dart';
import 'package:shop_owner/screen/delete_widget/delete_bloc.dart';
import 'package:shop_owner/screen/drawer_page/drawer.dart';
import 'package:shop_owner/screen/shop_page/shop_list/shop_list_bloc.dart';
import 'package:shop_owner/screen/shop_page/shop_list/shop_list_ob.dart';
import 'package:shop_owner/screen/shop_page/shop_list/shop_list_screen.dart';
import 'package:shop_owner/screen/shop_page/shop_update/shop_update_screen.dart';
import 'package:shop_owner/helpers/styleguide.dart';
import 'package:shop_owner/utils/app_constants.dart';

class ShopDetail extends StatefulWidget {
  ShopListOb shop;
  ShopDetail(this.shop);

  @override
  State<ShopDetail> createState() => _ShopDetailState();
}

class _ShopDetailState extends State<ShopDetail> {
  DeleteBloc _deleteBloc = DeleteBloc();
  ShopListBloc _bloc = ShopListBloc();
  bool loading = false;
  @override
  void initState() {
    super.initState();
    _deleteListen();
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
                  child: const Text(
                    'OK',
                    style: TextStyle(color: Color(0xFF6600cc), fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return ShopListScreen();
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
          title: "Shop",
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
                                  'Shop Name',
                                  style: serviewviewbold,
                                )),
                            Expanded(
                              flex: 1,
                              child: Text(":"),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(widget.shop.sname.toString()),
                            )
                          ],
                        ),
                        SizedBox(height: 13),
                        Row(
                          children: [
                            Expanded(
                                flex: 4,
                                child: Text(
                                  'Phone',
                                  style: serviewviewbold,
                                )),
                            Expanded(
                              flex: 1,
                              child: Text(":"),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(widget.shop.sphone.toString()),
                            ),
                          ],
                        ),
                        SizedBox(height: 13),
                        Row(
                          children: [
                            Expanded(
                                flex: 4,
                                child: Text(
                                  'Email',
                                  style: serviewviewbold,
                                )),
                            Expanded(
                              flex: 1,
                              child: Text(":"),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(widget.shop.semail.toString()),
                            ),
                          ],
                        ),
                        SizedBox(height: 13),
                        Row(
                          children: [
                            Expanded(
                                flex: 4,
                                child: Text(
                                  'Address',
                                  style: serviewviewbold,
                                )),
                            Expanded(
                              flex: 1,
                              child: Text(":"),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(widget.shop.saddress.toString()),
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
                              child: Text(widget.shop.screatedAt.toString()),
                            ),
                          ],
                        ),
                        SizedBox(height: 13),
                        Row(
                          children: [
                            Expanded(
                                flex: 4,
                                child: Text(
                                  'Status',
                                  style: serviewviewbold,
                                )),
                            Expanded(
                              flex: 1,
                              child: Text(":"),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(widget.shop.status.toString()),
                            ),
                          ],
                        ),
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
                            widget.shop.sdescription.toString(),
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
                            'Return Shop',
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
                              SHOP_DELETE_URL + widget.shop.id.toString());
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
                              builder: (context) => ShopUpdateScreen(
                                  data: this.widget.shop, title: "Edit Shop"),
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
      ),
    );
  }
}
