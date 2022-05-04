import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shop_owner/helpers/response_ob.dart';
import 'package:shop_owner/screen/alert_widget/alert_dialogbox.dart';
import 'package:shop_owner/screen/background_screen.dart';
import 'package:shop_owner/screen/profile_page/profile_bloc.dart';
import 'package:shop_owner/screen/profile_page/profile_ob.dart';
import 'package:shop_owner/utils/app_constants.dart';
import 'package:path/path.dart';

import '../../helpers/styleguide.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String dropdownValue;
  File _imageFile;
  List<String> monthList = ["Male", "Female"];
  final ImagePicker _picker = ImagePicker();
  TextEditingController nameController = new TextEditingController();
  String firstName;
  String lastName;
  String fullName;
  String phone;
  String email;
  String dateofbirth;
  String birthdayDate;
  String imagepath;
  String address;
  DateTime selectedDate = DateTime.now();
  final _bloc = ProfileBloc();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  bool loading = false;
  ProfileOb profileOb;
  var _formKey = GlobalKey<FormState>();

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
        birthdayDate = DateFormat("yyyy-MM-dd").format(selectedDate);
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc.getProfile();
    alertUpdate();
  }

  alertUpdate() {
    _bloc.profileUpdateStream().listen((ResponseOb responseOb) {
      if (responseOb.message == MsgState.data) {
        setState(() {
          loading = false;
        });
        return showDialog(
          context: this.context,
          builder: (BuildContext context) => ShowAlertBOx(
              title: "Your profile has been updated successfully."),
        );
      }
    });
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
                'Edit Profile',
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
        body: ModalProgressHUD(
          child: SingleChildScrollView(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                HomeBackgroundPage(
                  screenHeight: 600,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 16.0),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        StreamBuilder<ResponseOb>(
                          builder: (context, snapshot) {
                            ResponseOb resp = snapshot.data;
                            if (resp.message == MsgState.loading) {
                              return CircularProgressIndicator(
                                color: color,
                              );
                            } else if (resp.message == MsgState.errors) {
                              return Center(
                                child: Text("Something Wrong, try again!",
                                    style: TextStyle(color: Colors.white)),
                              );
                            } else {
                              profileOb = resp.data;
                              firstName = profileOb.firstName;
                              lastName = profileOb.lastName;
                              fullName = profileOb.fullName;
                              email = profileOb.email;
                              phone = profileOb.phone;
                              dateofbirth = profileOb.dateOfBirth;
                              imagepath = profileOb.avatar;
                              address = profileOb.address;
                              return Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 80.0),
                                    padding: EdgeInsets.only(top: 75.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.8),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              5), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Form(
                                      key: _formKey,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(height: 25.0),
                                          Container(
                                            margin: edgeInsets,
                                            child: TextFormField(
                                              autofocus: false,
                                              controller: TextEditingController(
                                                  text: profileOb.firstName),
                                              decoration:
                                                  inputDecoration("First Name"),
                                              onChanged: (value) {
                                                profileOb.firstName = value;
                                                firstName = value;
                                              },
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "First Name must not be empty";
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          Container(
                                            margin: edgeInsets,
                                            child: TextFormField(
                                              controller: TextEditingController(
                                                  text: profileOb.lastName),
                                              decoration:
                                                  inputDecoration("Last Name"),
                                              onChanged: (value) {
                                                profileOb.lastName = value;
                                                lastName = value;
                                              },
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "Last Name must not be empty";
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          Container(
                                            margin: edgeInsets,
                                            child: TextFormField(
                                              controller: TextEditingController(
                                                  text: profileOb.fullName),
                                              decoration:
                                                  inputDecoration("Full Name"),
                                              onChanged: (value) {
                                                profileOb.fullName = value;
                                                fullName = value;
                                              },
                                            ),
                                          ),
                                          Container(
                                            margin: edgeInsets,
                                            child: TextFormField(
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: TextEditingController(
                                                  text: profileOb.phone),
                                              decoration:
                                                  inputDecoration("Phone"),
                                              onChanged: (value) {
                                                profileOb.phone = value;
                                                phone = value;
                                              },
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "Phone must not be empty";
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          Container(
                                            margin: edgeInsets,
                                            child: TextFormField(
                                              controller: TextEditingController(
                                                  text: profileOb.email),
                                              decoration:
                                                  inputDecoration("Email"),
                                              onChanged: (value) {
                                                profileOb.email = value;
                                                email = value;
                                              },
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "Email must not be empty";
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          Container(
                                            margin: edgeInsets,
                                            decoration: boxDecoration,
                                            child: DropdownButtonHideUnderline(
                                              child: ButtonTheme(
                                                alignedDropdown: true,
                                                child:
                                                    new DropdownButton<String>(
                                                  value: profileOb.gender,
                                                  isExpanded: true,
                                                  hint: Text('Gender',
                                                      style: GoogleFonts
                                                          .openSans()),
                                                  // hintStyle: GoogleFonts.openSans(),
                                                  items: monthList.map((value) {
                                                    return new DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: new Text(
                                                        value,
                                                      ),
                                                    );
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    // v alue = value;
                                                    setState(() {
                                                      dropdownValue = value;
                                                      profileOb.gender = value;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: edgeInsets,
                                            decoration: boxDecoration,
                                            child: Theme(
                                              data: Theme.of(context).copyWith(
                                                  primaryColor:
                                                      (Colors.black45)),
                                              child: TextFormField(
                                                controller:
                                                    TextEditingController(
                                                        text:
                                                            birthdayDate == null
                                                                ? profileOb
                                                                    .dateOfBirth
                                                                : birthdayDate),
                                                readOnly: true,
                                                onTap: () {
                                                  profileOb.dateOfBirth =
                                                      dateofbirth;
                                                },
                                                decoration: InputDecoration(
                                                  hintStyle:
                                                      GoogleFonts.openSans(
                                                          fontSize: 14),
                                                  hintText: 'Date Of Birth',
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    borderSide: BorderSide(
                                                      width: 0,
                                                      style: BorderStyle.none,
                                                    ),
                                                  ),
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                    left: 14,
                                                  ),
                                                  filled: true,
                                                  fillColor: Colors.grey[200],
                                                  suffix: InkWell(
                                                    onTap: () {
                                                      _selectDate(context);
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8.0),
                                                      child: Icon(
                                                        FontAwesomeIcons
                                                            .calendarAlt,
                                                        size: 22,
                                                        color: Colors.black45,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return "Email must not be empty";
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: edgeInsets,
                                            decoration: boxDecoration,
                                            child: TextField(
                                              // expands: true,
                                              minLines: null,
                                              maxLines: null,

                                              controller: TextEditingController(
                                                  text: profileOb.address),
                                              decoration:
                                                  addressInputDecoration,
                                              onChanged: (value) {
                                                profileOb.address = value;
                                              },
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              editProfile(profileOb);
                                            },
                                            child: Container(
                                              margin: buttonPadding,
                                              height: 40.0,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                color: color,
                                                borderRadius:
                                                    BorderRadius.circular(35),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Save Change',
                                                  style: GoogleFonts.openSans(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 20.0)
                                        ],
                                      ),
                                    ),
                                  ),
                                  _imageProfile(profileOb.avatar),
                                ],
                              );
                            }
                          },
                          stream: _bloc.profileStream(),
                          initialData: ResponseOb(message: MsgState.loading),
                        )
                      ],
                    ),
                  ),
                ),
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

  Widget _imageProfile(image) {
    return Center(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(100)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  spreadRadius: 1,
                  // blurRadius: 7,
                  offset: Offset(0, 0.5), // changes position of shadow
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 80,
              backgroundColor: Colors.white,
              backgroundImage: _imageFile == null
                  ? NetworkImage(PROFILE_IMAGE_URL + image)
                  : FileImage(File(_imageFile.path)),
            ),
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
      // width: MediaQuery.of(context).size.width,
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

  editProfile(data) async {
    print(_imageFile);
    profileOb = data;
    if (birthdayDate == null) {
      profileOb.dateOfBirth =
          DateFormat("yyyy-MM-dd").format(selectedDate).toString();
    }

    // if (_imageFile == null) {
    //   AppUtils.showSnackBar("Select Image", _scaffoldKey.currentState);
    //   return;
    // }
    if (_formKey.currentState.validate()) {
      setState(() {
        loading = true;
      });
      Map<String, dynamic> map;

      map = {
        "first_name": profileOb.firstName,
        "last_name": profileOb.lastName,
        "full_name": profileOb.fullName,
        "email": profileOb.email,
        "phone": profileOb.phone,
        "gender": profileOb.gender,
        "date_of_birth": profileOb.dateOfBirth,
        "address": profileOb.address,
        "avatar": _imageFile == null
            ? ""
            : await MultipartFile.fromFile(_imageFile.path,
                filename: basename(_imageFile.path))
      };

      print(map);
      _bloc.postProfile(map);
    }
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
    // TODO: implement dispose
    _bloc.dispose();
    super.dispose();
  }
}
