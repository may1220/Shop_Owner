import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shop_owner/helpers/response_ob.dart';
import 'package:shop_owner/screen/alert_widget/alert_dialogbox.dart';
import 'package:shop_owner/screen/background_screen.dart';
import 'package:shop_owner/screen/drawer_page/drawer.dart';
import 'package:shop_owner/screen/shop_page/shop_list/shop_list_ob.dart';
import 'package:shop_owner/screen/shop_page/shop_update/shop_update_bloc.dart';
import 'package:shop_owner/helpers/styleguide.dart';
import 'package:path/path.dart';
import 'package:shop_owner/utils/app_constants.dart';

class ShopUpdateScreen extends StatefulWidget {
  final ShopListOb data;
  final String title;
  const ShopUpdateScreen({Key key, this.data, this.title}) : super(key: key);

  @override
  ShopUpdateScreenState createState() => ShopUpdateScreenState();
}

class ShopUpdateScreenState extends State<ShopUpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  File _imageFile;
  final ImagePicker _picker = ImagePicker();
  bool loading = false;
  TextEditingController shopName = TextEditingController();
  TextEditingController shopAddress = TextEditingController();
  TextEditingController shopPhone = TextEditingController();
  TextEditingController shopEmail = TextEditingController();
  TextEditingController shopContactPerson = TextEditingController();
  TextEditingController shopDescription = TextEditingController();

  String status = "active";
  ShopUpdateBloc _bloc = ShopUpdateBloc();
  String image;
  bool isImage = false;
  String imageValidationText;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    _bloc.shopUpdateStream().listen((ResponseOb response) {
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

    _bloc.newShopStream().listen((ResponseOb response) {
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

  getData() {
    if (widget.data != null) {
      setState(() {
        shopName.text = widget.data.sname;
        shopAddress.text = widget.data.saddress;
        shopPhone.text = widget.data.sphone;
        shopEmail.text = widget.data.semail;
        shopContactPerson.text = widget.data.contactPerson;
        shopDescription.text = widget.data.sdescription;
        status = widget.data.status.toString();
        image = widget.data.logo.toString();
      });
    } else {
      image = "default.jpg";
    }
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
                shopedit(),
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

  Widget shopedit() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
        margin: cardPadding,
        decoration: cardShawdowDecoration,
        width: MediaQuery.of(this.context).size.width,
        child: Column(
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
                              ? NetworkImage(SHOP_IMAGE_URL + image)
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: TextFormField(
                    controller: shopName,
                    decoration: inputDecoration("Name"),
                    style: editTextStyle,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Name must not be empty";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: TextFormField(
                    controller: shopPhone,
                    keyboardType: TextInputType.number,
                    decoration: inputDecoration("Phone"),
                    style: editTextStyle,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Phone must not be empty";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: TextFormField(
                    controller: shopEmail,
                    decoration: inputDecoration("Email"),
                    style: editTextStyle,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email must not be empty";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: TextFormField(
                    controller: shopContactPerson,
                    decoration: inputDecoration("Contact Person"),
                    style: editTextStyle,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Contact Person must not be empty";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: TextFormField(
                    controller: shopAddress,
                    decoration: inputDecoration("Address"),
                    style: editTextStyle,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Address must not be empty";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  "Status",
                  style: GoogleFonts.openSans(fontWeight: FontWeight.w500),
                ),
                Row(
                  children: [
                    new Radio<String>(
                      value: "active",
                      groupValue: status,
                      onChanged: (String value) {
                        setState(() {
                          status = value;
                        });
                      },
                      activeColor: color,
                    ),
                    Text(
                      'Active',
                    ),
                    new Radio<String>(
                      value: "pending",
                      groupValue: status,
                      onChanged: (String value) {
                        setState(() {
                          status = value;
                        });
                      },
                      activeColor: color,
                    ),
                    Text(
                      'Pending',
                    ),
                    new Radio<String>(
                      value: "cencel",
                      groupValue: status,
                      onChanged: (String value) {
                        setState(() {
                          status = value;
                        });
                      },
                      activeColor: color,
                    ),
                    Text(
                      'Cancel',
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 80,
                  decoration: boxDecoration,
                  padding: leftPadding,
                  child: TextField(
                    controller: shopDescription,
                    decoration: InputDecoration(
                      hintText: 'Description',
                      border: InputBorder.none,
                    ),
                    style: editTextStyle,
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 5.0,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: RaisedButton(
                          onPressed:
                              widget.data == null ? createShop : shopUpdate,
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
        ),
      ),
    );
  }

  shopUpdate() async {
    if (_imageFile == null) {
      if (image == null) {
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
          "name": shopName.text,
          "phone": shopPhone.text,
          "email": shopEmail.text,
          "description": shopDescription.text,
          "contact_person": shopContactPerson.text,
          "address": shopAddress.text,
          "status": status
        };
      } else {
        map = {
          "id": widget.data.id.toString(),
          "name": shopName.text,
          "phone": shopPhone.text,
          "email": shopEmail.text,
          "description": shopDescription.text,
          "contact_person": shopContactPerson.text,
          "address": shopAddress.text,
          "status": status,
          "uploads": await MultipartFile.fromFile(_imageFile.path,
              filename: basename(_imageFile.path))
        };
      }

      print(map);
      _bloc.shopUpdate(map);
    }
  }

  createShop() async {
    print(_imageFile);
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
        "name": shopName.text.toString(),
        "phone": shopPhone.text,
        "email": shopEmail.text,
        "description": shopDescription.text,
        "contact_person": shopContactPerson.text,
        "address": shopAddress.text,
        "status": status.toString(),
        "uploads": await MultipartFile.fromFile(_imageFile.path,
            filename: basename(_imageFile.path))
      };
      print(map);
      _bloc.newShop(map);
    }
  }

  Widget _imageProfile() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 80,
            backgroundImage: _imageFile == null
                ? AssetImage('assets/images/robert.jpg')
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

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
