import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shop_owner/helpers/response_ob.dart';
import 'package:shop_owner/helpers/styleguide.dart';
import 'package:shop_owner/screen/common_widget/appbar_screen.dart';
import 'package:shop_owner/screen/delete_widget/delete_bloc.dart';
import 'package:shop_owner/screen/drawer_page/drawer.dart';
import 'package:shop_owner/screen/google_map/google_mpa_bloc.dart';
import 'package:shop_owner/screen/google_map/location_ob.dart';
import 'package:shop_owner/screen/shop_page/shop_list/shop_list_bloc.dart';
import 'package:shop_owner/screen/shop_page/shop_list/shop_list_ob.dart';
import 'package:shop_owner/utils/app_constants.dart';
import 'package:shop_owner/utils/app_utils.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({Key key}) : super(key: key);

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  TextEditingController latitude = TextEditingController();
  TextEditingController longitude = TextEditingController();
  ShopListBloc _shopList = ShopListBloc();
  GoogleMapBloc _googleMapBloc = GoogleMapBloc();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<ShopListOb> shopList;
  List<LocationOb> allLocationList = [];
  ShopListOb selectedShop;
  String shopId;
  String shopName;
  bool isLoading = false;
  DeleteBloc _deleteBloc = DeleteBloc();
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

  @override
  void initState() {
    super.initState();
    _googleMapBloc.allMapData();
    _getShoList();
    _deleteListen();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        drawer: DrawerScreen(),
        appBar: BaseAppBar(title: 'Google Map', appBar: AppBar()),
        body: ModalProgressHUD(
          child: ListView(
            padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
            children: [
              shopList == null
                  ? SizedBox()
                  : Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
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
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  controller: latitude,
                                  keyboardType: TextInputType.number,
                                  decoration: inputDecoration("Latitude"),
                                  style: editTextStyle,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Latitude must not be empty";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  controller: longitude,
                                  keyboardType: TextInputType.number,
                                  decoration: inputDecoration("Longitude"),
                                  style: editTextStyle,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Longitude must not be empty";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  primary: color),
                              onPressed: _saveMapData,
                              child: Text(
                                "Save",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
              StreamBuilder<ResponseOb>(
                stream: _googleMapBloc.allMapDataStream(),
                // initialData: ResponseOb(message: MsgState.loading),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    ResponseOb responseOb = snapshot.data;
                    print(responseOb);
                    if (responseOb.data == null) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: color,
                        ),
                      );
                    } else {
                      print("object******************************");
                      allLocationList = responseOb.data;

                      return allLocationList.length > 0
                          ? Column(
                              children: List.generate(allLocationList.length,
                                  (index) {
                                return Container(
                                  margin: EdgeInsets.all(5),
                                  padding: EdgeInsets.only(
                                      top: 7, bottom: 7, left: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 3,
                                        offset: Offset(
                                            0, 2), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              allLocationList[index].name,
                                              style: mapTextStyle,
                                            ),
                                            Text(
                                              "Lat: ${allLocationList[index].latitude}",
                                              style: mapTextStyle,
                                            ),
                                            Text(
                                              "Long: ${allLocationList[index].longitude}",
                                              style: mapTextStyle,
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                          onTap: () {
                                            _deleteBloc.deleteObject(
                                                deleteLocation +
                                                    allLocationList[index]
                                                        .id
                                                        .toString());
                                          },
                                          child: Icon(Icons.cancel)),
                                      SizedBox(
                                        width: 10,
                                      )
                                    ],
                                  ),
                                );
                              }),
                            )
                          : SizedBox();
                    }
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ],
          ),
          inAsyncCall: isLoading,
          opacity: 0.5,
          progressIndicator: CircularProgressIndicator(
            color: color,
          ),
        ),
      ),
    );
  }

  _saveMapData() {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      Map<String, String> map = {
        "shop_id": shopId,
        "map_lat": latitude.text,
        "map_long": longitude.text
      };
      print(map);
      _googleMapBloc.saveMapData(map);
    }
  }

  _deleteListen() {
    // if (_formKey.currentState.validate()) {
    _googleMapBloc.googleMapStream().listen((ResponseOb responseOb) {
      print("**************************");
      print(responseOb);
      if (responseOb.message == MsgState.data) {
        setState(() {
          isLoading = false;
        });
        return showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Center(child: Text(responseOb.data)),
            actions: [
              Center(
                child: TextButton(
                  child: const Text('OK',
                      style: TextStyle(color: Color(0xFF6600cc), fontSize: 20)),
                  onPressed: () {
                    _googleMapBloc.allMapData();
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
          ),
        );
      }
    });
    // }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _googleMapBloc.dispose();
    _shopList.dispose();
    super.dispose();
  }
}
