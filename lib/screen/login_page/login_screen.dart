import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shop_owner/helpers/response_ob.dart';
import 'package:shop_owner/screen/dashboard_page/dashboard_screen.dart';
import 'package:shop_owner/screen/forgetpw_page/forget_password.dart';
import 'package:shop_owner/screen/login_page/login_bloc.dart';
import 'package:shop_owner/screen/register_page/formstate_screen.dart';
import 'package:shop_owner/screen/register_page/register_screen.dart';
import 'package:shop_owner/utils/app_utils.dart';

import '../../helpers/styleguide.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  // var passwordController = TextEditingController(text: "12345678");
  // var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  var _formKey = GlobalKey<FormState>();
  final _bloc = LoginBloc();
  bool loading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loginListener();
  }

  loginListener() {
    _bloc.loginStream().listen((ResponseOb resp) {
      print(resp.message);
      if (resp.message == MsgState.data) {
        setState(() {
          loading = false;
        });
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) {
          return DashboardScreen();
        }), (route) => false);
      }
      if (resp.message == MsgState.errors) {
        print(resp.data["error"]);
        setState(() {
          loading = false;
        });
        // if (resp.errState == ErrState.userErr) {
        AppUtils.showSnackBar(
            resp.data["error"].toString(), _scaffoldKey.currentState);
        // }
        //else {
        // AppUtils.showSnackBar(
        //     resp.data['error'].toString(), _scaffoldKey.currentState);
        // AppUtils.showSnackBar(resp.error == null ? resp.msgerror : resp.error,
        //     _scaffoldKey.currentState);
        // }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      body: ModalProgressHUD(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/in-up-bg.jpg'),
                fit: BoxFit.fill),
          ),
          child: Center(
            child: Container(
              // height: 400,
              margin: EdgeInsets.only(left: 30.0, right: 30.0),
              padding: EdgeInsets.only(left: 30.0, right: 30.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white38,
              ),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          Image(
                            image: AssetImage(
                              'assets/images/beaute-logo-only-blue.png',
                            ),
                            height: 70,
                            width: 70,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "BEAUTE",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF68409B),
                                    fontSize: 45),
                              ),
                              Text(
                                "A RIGHT CHOICE FOR YOUR BEAUTY",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 11),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            hintStyle: GoogleFonts.openSans(
                                fontSize: 17.0,
                                color: color,
                                fontWeight: FontWeight.bold),
                            hintText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            contentPadding:
                                EdgeInsets.only(left: 12, bottom: 0),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          style: loginTextStyle,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email must not be empty";
                            } else {
                              if (!value.endsWith("@gmail.com") &&
                                  !value.endsWith("@demo.com")) {
                                return "Invalid email";
                              }
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintStyle: GoogleFonts.openSans(
                                fontSize: 17.0,
                                color: color,
                                fontWeight: FontWeight.bold),
                            hintText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            contentPadding:
                                EdgeInsets.only(left: 12, bottom: 0),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          style: loginTextStyle,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Password must not be empty.";
                            } else {
                              if (value.length < 6) {
                                return "Password must be a minimum of 6 characters.";
                              }
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: checklogin,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 3.0),
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: Text(
                              'Login',
                              style: GoogleFonts.openSans(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0, top: 7.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => RegisterScreen()),
                                );
                              },
                              child: Text(
                                "Register",
                                style: TextStyle(
                                    color: color,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 4.0, top: 7.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => ForgetPassword()),
                                );
                              },
                              child: Text(
                                "Forget Password",
                                style: TextStyle(
                                    color: color,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 25),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        inAsyncCall: loading,
        opacity: 0.5,
        progressIndicator: CircularProgressIndicator(
          color: color,
        ),
      ),
    ));
  }

  checklogin() {
    if (_formKey.currentState.validate()) {
      setState(() {
        loading = true;
      });
      Map<String, String> map = {
        'email': emailController.text,
        'password': passwordController.text,
      };
      print(map);
      _bloc.login(map);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _bloc.dispose();
    super.dispose();
  }
}
