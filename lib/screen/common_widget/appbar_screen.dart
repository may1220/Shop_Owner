import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_owner/screen/profile_page/profile_screen.dart';
import '../../helpers/styleguide.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final AppBar appBar;
  // final List<Widget> widgets;

  BaseAppBar({Key key, this.title, this.appBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Builder(
        builder: (context) => IconButton(
          icon: Image.asset(
            "assets/images/menu.png",
            height: 22,
            width: 34,
          ),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: TextField(
        controller: TextEditingController(text: this.title),
        keyboardType: TextInputType.text,
        cursorColor: Colors.black,
        style: GoogleFonts.openSans(fontSize: 18),
        textAlign: TextAlign.center,
        enabled: false,
        decoration: InputDecoration(
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          border: InputBorder.none,
          // suffix: Container(
          //   height: 30.0,
          //   width: 30.0,
          //   margin: EdgeInsets.only(top: 2.0),
          //   decoration: BoxDecoration(
          //     shape: BoxShape.circle,
          //     border: Border.all(color: Colors.black),
          //   ),
          // child: Icon(
          //   Icons.search,
          //   color: Colors.black,
          // ),
          // ),
        ),
      ),

      actions: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EditProfileScreen(),
              ),
            );
          },
          child: profileContainer,
        ),
      ],
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      //actions: widgets,
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
