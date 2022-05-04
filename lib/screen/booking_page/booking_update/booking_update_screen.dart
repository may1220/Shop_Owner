import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shop_owner/screen/background_screen.dart';
import 'package:shop_owner/screen/drawer_page/drawer.dart';
import 'package:shop_owner/helpers/styleguide.dart';

class BookingUpdateScreen extends StatefulWidget {
  const BookingUpdateScreen({Key key}) : super(key: key);

  @override
  _BookingUpdateScreenState createState() => _BookingUpdateScreenState();
}

class _BookingUpdateScreenState extends State<BookingUpdateScreen> {
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  bool loading = false;
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
                  'Edit Booking',
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
                _updateBooking(),
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

  _updateBooking() {
    return Container(
      padding: EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
      margin: cardPadding,
      decoration: cardShawdowDecoration,
      width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  image: DecorationImage(
                    image: _imageFile == null
                        ? AssetImage('assets/images/5.jpg')
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
                        context: context,
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
          SizedBox(
            height: 15,
          ),
          Column(
            children: [
              SizedBox(height: 13),
              Padding(
                padding: const EdgeInsets.only(
                  right: 5.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: RaisedButton(
                        onPressed: bookingUpdate,
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

  void takephoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }

  bookingUpdate() {}
}
