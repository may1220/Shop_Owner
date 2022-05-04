import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_owner/model/default_data.dart';
import 'package:shop_owner/screen/common_widget/appbar_screen.dart';
import 'package:shop_owner/screen/drawer_page/drawer.dart';

import '../helpers/styleguide.dart';

class StaffListScreen extends StatefulWidget {
  @override
  _StaffListScreenState createState() => _StaffListScreenState();
}

class _StaffListScreenState extends State<StaffListScreen> {
  bool downButton = true;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _positionController = TextEditingController();
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  bool isLoading = false;
  var temArray;
  // AnimationController animationController;
  @override
  initState() {
    _loadData();
  }

  _loadData() {
    temArray = staffList.getRange(0, 20);
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: BaseAppBar(
          title: 'Staff List',
          appBar: AppBar(),
        ),
        drawer: DrawerScreen(),
        body: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _staffListAlert();
                  });
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
                      'ADD STAFF',
                      style: GoogleFonts.openSans(
                          color: Colors.white, fontWeight: FontWeight.bold),
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
            child: ListView(
              children: List.generate(
                staffList.length,
                (index) {
                  return Column(
                    children: [
                      Container(
                        height: 35,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (staffList[index]['checkvalue'] == false) {
                                staffList[index]['checkvalue'] = true;
                                downButton = false;
                              } else {
                                staffList[index]['checkvalue'] = false;
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
                                margin: EdgeInsets.zero,
                                decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                child: staffList[index]['checkvalue'] == false
                                    ? Icon(
                                        FontAwesomeIcons.chevronDown,
                                        color: Colors.white,
                                        size: 15,
                                      )
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 3.0),
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
                                  'Name',
                                  style: serviceTitleText,
                                ),
                              ),
                              Expanded(flex: 1, child: Text(':')),
                              Expanded(
                                flex: 6,
                                child: Text(
                                  staffList[index]['name'],
                                  style: serviceDataText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      staffList[index]['checkvalue'] == true
                          ? Column(
                              children: [
                                Container(
                                  height: 40,
                                  child: Row(
                                    children: [
                                      // SizedBox(width: 20),
                                      SizedBox(width: 61),
                                      Expanded(
                                        flex: 4,
                                        child: Text(
                                          'Email',
                                          style: serviceTitleText,
                                        ),
                                      ),
                                      Expanded(flex: 1, child: Text(':')),
                                      Expanded(
                                        flex: 6,
                                        child: Text(
                                          staffList[index]['email'],
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
                                          'Phone',
                                          style: serviceTitleText,
                                        ),
                                      ),
                                      Expanded(flex: 1, child: Text(':')),
                                      Expanded(
                                        flex: 6,
                                        child: Text(
                                          staffList[index]['phone'],
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
                                          'Position',
                                          style: serviceTitleText,
                                        ),
                                      ),
                                      Expanded(flex: 1, child: Text(':')),
                                      Expanded(
                                        flex: 6,
                                        child: Text(
                                          staffList[index]['position'],
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
                                          'Status',
                                          style: serviceTitleText,
                                        ),
                                      ),
                                      Expanded(flex: 1, child: Text(':')),
                                      Expanded(
                                        flex: 6,
                                        child: Text(
                                          staffList[index]['status'],
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
                                          'Action',
                                          style: serviceTitleText,
                                        ),
                                      ),
                                      Expanded(flex: 1, child: Text(':')),
                                      Expanded(
                                        flex: 6,
                                        child: Row(
                                          children: [
                                            _deleteContainer(),
                                            _editContainer(
                                                staffList[index], index),
                                            _eyeContainer()
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : SizedBox(),
                      Divider(
                        color: Colors.grey[100],
                        thickness: 1.5,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),

          Divider(
            color: Colors.grey[100],
            thickness: 1.5,
          ),
          // Container(
          //   height: isLoading ? 25.0 : 0,
          //   width: isLoading ? 25.0 : 0,
          //   margin: EdgeInsets.only(bottom: 10.0),
          //   color: Colors.transparent,
          //   child: Center(
          //     child: new CircularProgressIndicator(
          //       valueColor: AlwaysStoppedAnimation<Color>(color),
          //     ),
          //   ),
          // ),
        ]),
      ),
    );
  }

  _staffListAlert() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        contentPadding: EdgeInsets.only(top: 15.0, left: 20.0, right: 10.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Container(
          width: MediaQuery.of(context).size.width - 10,
          height: MediaQuery.of(context).size.height / 2.3,
          child: ClipRRect(
            child: Card(
              margin: EdgeInsets.zero,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(children: [
                            Container(
                              height: 135,
                              margin: EdgeInsets.only(
                                right: 10.0,
                              ),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: _imageFile == null
                                        ? AssetImage('assets/images/robert.jpg')
                                        : FileImage(File(_imageFile.path)),
                                    // AssetImage('assets/images/robert.jpg'),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              // child: Image(
                              //   image: _imageFile == null
                              //       ? AssetImage('assets/images/robert.jpg')
                              //       : FileImage(File(_imageFile.path)),
                              //       fit: BoxFit.cover,
                              // ),
                            ),
                            SizedBox(height: 15),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  showModalBottomSheet(
                                      isDismissible: false,
                                      context: context,
                                      builder: ((builder) => bottomSheet()));
                                });
                              },
                              child: Container(
                                height: 32.0,
                                // width: 10,
                                margin:
                                    EdgeInsets.only(bottom: 5.0, right: 10.0),
                                decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    'Upload Photo',
                                    style: GoogleFonts.openSans(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 35,
                                decoration: boxDecoration,
                                padding: EdgeInsets.only(
                                  left: 12.0,
                                ),
                                margin: EdgeInsets.only(
                                  top: 10.0,
                                ),
                                child: TextField(
                                  controller: _nameController,
                                  textInputAction: TextInputAction.go,
                                  decoration: InputDecoration(
                                      hintText: "Name",
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                        bottom: 12.0,
                                      )),
                                ),
                              ),
                              SizedBox(height: 15),
                              Container(
                                height: 35,
                                decoration: boxDecoration,
                                padding: EdgeInsets.only(left: 12.0),
                                // margin: EdgeInsets.only(right: 12.0),
                                child: TextField(
                                  controller: _emailController,
                                  textInputAction: TextInputAction.go,
                                  decoration: InputDecoration(
                                      hintText: "Email",
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                        bottom: 12.0,
                                      )),
                                ),
                              ),
                              SizedBox(height: 15),
                              Container(
                                height: 35,
                                decoration: boxDecoration,
                                padding: EdgeInsets.only(left: 12.0),
                                // margin: EdgeInsets.only(right: 12.0),
                                child: TextField(
                                  controller: _phoneController,
                                  textInputAction: TextInputAction.go,
                                  decoration: InputDecoration(
                                      hintText: "Phone",
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                        bottom: 12.0,
                                      )),
                                ),
                              ),
                              SizedBox(height: 15),
                              Container(
                                height: 35,
                                decoration: boxDecoration,
                                padding: EdgeInsets.only(left: 12.0),
                                // margin: EdgeInsets.only(right: 12.0),
                                child: TextField(
                                  controller: _positionController,
                                  textInputAction: TextInputAction.go,
                                  decoration: InputDecoration(
                                      hintText: "Position",
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                        bottom: 12.0,
                                      )),
                                ),
                              ),
                              SizedBox(height: 15),
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      // height: 35,
                      decoration: boxDecoration,
                      padding: EdgeInsets.only(
                        left: 12.0,
                      ),
                      margin: EdgeInsets.only(
                        top: 5.0,
                      ),
                      child: TextField(
                        controller: _nameController,
                        maxLines: 4,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.go,
                        decoration: InputDecoration(
                          hintText: "Adress",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                            top: 5.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _nameController.clear();
                            _emailController.clear();
                            _phoneController.clear();
                            _positionController.clear();
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
                              // events.add(Holiday(
                              //     title: _titleController.text,
                              //     startDate: _startDateController.text,
                              //     endDate: _endDateController.text));
                              if (_nameController.text != "" &&
                                  _emailController.text != "" &&
                                  _phoneController.text != "" &&
                                  _positionController.text != "") {
                                staffList.add({
                                  "name": _nameController.text,
                                  "email": _emailController.text,
                                  "phone": _phoneController.text,
                                  "position": _positionController.text,
                                  "status": "Active",
                                  "checkvalue": false
                                });
                              }

                              Navigator.pop(context);
                            });
                            _nameController.clear();
                            _emailController.clear();
                            _phoneController.clear();
                            _positionController.clear();
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
                                'ADD',
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

  Widget bottomSheet() {
    return Container(
      height: 85,
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
                  setState(() {
                    takephoto(ImageSource.camera);
                  });
                  Navigator.pop(context);
                },
                label: Text('Camera'),
              ),
              FlatButton.icon(
                icon: Icon(Icons.image),
                onPressed: () {
                  takephoto(ImageSource.gallery);
                  Navigator.pop(context);
                },
                label: Text('Gallery'),
              ),
            ],
          )
        ],
      ),
    );
  }

  takephoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
    });
    return _imageFile;
  }

  _deleteContainer() {
    return Container(
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
    );
  }

  _editContainer(data, index) {
    return GestureDetector(
      onTap: () {},
      child: Container(
          margin: EdgeInsets.only(right: 10.0),
          padding: EdgeInsets.all(5.0),
          height: 28.0,
          width: 28.0,
          decoration: BoxDecoration(
            color: Colors.purple[50],
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white),
            // image: DecorationImage(image: AssetImage("assets/images/pen-color.png",hei))
          ),
          child: Image.asset("assets/images/pen-color.png")),
    );
  }

  _eyeContainer() {
    return Container(
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
    );
  }
}
