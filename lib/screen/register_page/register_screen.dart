import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shop_owner/helpers/response_ob.dart';
import 'package:shop_owner/screen/dashboard_page/dashboard_screen.dart';
import 'package:shop_owner/screen/login_page/login_screen.dart';
import 'package:shop_owner/screen/register_page/register_bloc.dart';

import '../../helpers/styleguide.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var frirstnameController = TextEditingController();
  var lastnameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmpwController = TextEditingController();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  var _formKey = GlobalKey<FormState>();
  final _bloc = RegisterBloc();
  String dropdownValue;
  List<String> monthList = ["Male", "Female"];
  String startDate;
  DateTime selectedDate = DateTime.now();
  bool loading = false;
  String emailError;
  bool isEmail = false;
  String phoneError;
  bool isPhone = false;
  String firstName;
  bool isFirstName = false;
  String lastName;
  bool isLastName = false;
  String password;
  bool isPassword = false;
  String confirmPW;
  bool isConfirmPW = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _registerblocListen();
  }

  _registerblocListen() {
    _bloc.registerStream().listen((ResponseOb resp) {
      print(resp.data);
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
        setState(() {
          loading = false;
        });
        if (resp.data != null) {
          if (resp.data["errors"] != null) {
            if (resp.data["errors"]["first_name"] != null) {
              setState(() {
                isFirstName = true;
                firstName = resp.data["errors"]["first_name"][0];
              });
            } else {
              setState(() {
                isFirstName = false;
              });
            }
            if (resp.data["errors"]["last_name"] != null) {
              setState(() {
                isLastName = true;
                lastName = resp.data["errors"]["last_name"][0];
              });
            } else {
              setState(() {
                print("Email False v***************");
                isLastName = false;
              });
            }
            if (resp.data["errors"]["phone"] != null) {
              setState(() {
                isPhone = true;
                phoneError = resp.data["errors"]["phone"][0];
              });
            } else {
              setState(() {
                isPhone = false;
              });
            }
            if (resp.data["errors"]["email"] != null) {
              setState(() {
                isEmail = true;
                emailError = resp.data["errors"]["email"][0];
              });
            } else {
              setState(() {
                isEmail = false;
              });
            }
            if (resp.data["errors"]["password"] != null) {
              setState(() {
                isPassword = true;
                password = resp.data["errors"]["password"][0];
              });
            } else {
              setState(() {
                isPassword = false;
              });
            }
            if (resp.data["errors"]["password_confirmation"] != null) {
              setState(() {
                isConfirmPW = true;
                confirmPW = resp.data["errors"]["password_confirmation"][0];
              });
            } else {
              setState(() {
                isConfirmPW = false;
              });
            }
          } else {
            print("****************&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*********");
          }
        } else {
          print("*************************");
          print(resp.data["message"]);
        }

        // if (resp.errState == ErrState.userErr) {
        //   AppUtils.showSnackBar(
        //       resp.data.toString(), _scaffoldKey.currentState);
        // } else {
        // AppUtils.showSnackBar(resp.error == null ? resp.msgerror : resp.error,
        //     _scaffoldKey.currentState);
        // }
      }
    });
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
        startDate = DateFormat("dd-MM-yyyy").format(selectedDate);
      });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: ModalProgressHUD(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/in-up-bg.jpg'),
                fit: BoxFit.fill),
          ),
          child: Center(
            child: Container(
              // height: 500,
              margin: EdgeInsets.only(
                left: 30.0,
                right: 30.0,
              ),
              padding: EdgeInsets.only(left: 30.0, right: 30.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white38,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                image: AssetImage(
                                  'assets/images/beaute-logo-only-blue.png',
                                ),
                                height: 60,
                                width: 60,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "BEAUTE",
                                    style: loginTitleStyle,
                                  ),
                                  Text(
                                    "A RIGHT CHOICE FOR YOUR BEAUTY",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
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
                              controller: frirstnameController,
                              decoration: registerInputDecoration("First Name"),
                              style: loginTextStyle,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "First Name must not be empty";
                                }
                                return null;
                              },
                            ),
                          ),
                          isFirstName == true
                              ? Container(
                                  margin: const EdgeInsets.only(
                                    top: 7,
                                    left: 12.0,
                                  ),
                                  child: Text(
                                    firstName,
                                    style: validationTextStyle,
                                  ),
                                )
                              : SizedBox(),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: TextFormField(
                              controller: lastnameController,
                              decoration: registerInputDecoration("Last Name"),
                              style: loginTextStyle,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Last Name must not be empty";
                                }
                                return null;
                              },
                            ),
                          ),
                          isLastName == true
                              ? Container(
                                  margin: const EdgeInsets.only(
                                    top: 7,
                                    left: 12.0,
                                  ),
                                  child: Text(
                                    lastName,
                                    style: validationTextStyle,
                                  ),
                                )
                              : SizedBox(),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: TextFormField(
                              controller: emailController,
                              decoration: registerInputDecoration("Email"),
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
                          isEmail == true
                              ? Container(
                                  margin: const EdgeInsets.only(
                                    top: 7,
                                    left: 12.0,
                                  ),
                                  child: Text(
                                    emailError,
                                    style: validationTextStyle,
                                  ),
                                )
                              : SizedBox(),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: TextFormField(
                              controller: phoneController,
                              keyboardType: TextInputType.number,
                              decoration: registerInputDecoration("Phone"),
                              style: loginTextStyle,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Phone not be empty";
                                }
                                return null;
                              },
                            ),
                          ),
                          isPhone == true
                              ? Container(
                                  margin: const EdgeInsets.only(
                                    top: 7,
                                    left: 12.0,
                                  ),
                                  child: Text(
                                    phoneError,
                                    style: TextStyle(
                                      color: Color(0xFFA93226),
                                    ),
                                  ),
                                )
                              : SizedBox(),
                          // Container(
                          //   margin: EdgeInsets.only(bottom: 15.0),
                          //   decoration: BoxDecoration(
                          //     color: Colors.white,
                          //     borderRadius: BorderRadius.circular(25),
                          //   ),
                          //   child: DropdownButtonHideUnderline(
                          //     child: ButtonTheme(
                          //       alignedDropdown: true,
                          //       child: new DropdownButton<String>(
                          //         value: dropdownValue,
                          //         isExpanded: true,
                          //         hint: Text('Gender',
                          //             style: GoogleFonts.openSans(
                          //                 color: color, fontWeight: FontWeight.bold)),
                          //         // hintStyle: GoogleFonts.openSans(),
                          //         items: monthList.map((value) {
                          //           return new DropdownMenuItem<String>(
                          //             value: value,
                          //             child: new Text(
                          //               value,
                          //               style: GoogleFonts.openSans(
                          //                   color: color, fontWeight: FontWeight.bold),
                          //             ),
                          //           );
                          //         }).toList(),
                          //         onChanged: (value) {
                          //           // value = value;
                          //           setState(() {
                          //             dropdownValue = value;
                          //           });
                          //         },
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // Container(
                          //   margin: EdgeInsets.only(bottom: 15.0),
                          //   decoration: BoxDecoration(
                          //     color: Colors.white,
                          //     borderRadius: BorderRadius.circular(25),
                          //   ),
                          //   child: Theme(
                          //     data: Theme.of(context)
                          //         .copyWith(primaryColor: (Colors.black45)),
                          //     child: TextField(
                          //         controller: TextEditingController(text: startDate),
                          //         readOnly: true,
                          //         style: GoogleFonts.openSans(
                          //             fontWeight: FontWeight.bold, color: color),
                          //         decoration: InputDecoration(
                          //           hintStyle: GoogleFonts.openSans(
                          //               fontSize: 14,
                          //               color: color,
                          //               fontWeight: FontWeight.bold),
                          //           hintText: 'Date Of Birth',
                          //           border: InputBorder.none,
                          //           contentPadding: EdgeInsets.only(
                          //             left: 14,
                          //           ),
                          //           suffix: InkWell(
                          //             onTap: () {
                          //               _selectDate(context);
                          //             },
                          //             child: Padding(
                          //               padding: const EdgeInsets.only(right: 8.0),
                          //               child: Icon(
                          //                 FontAwesomeIcons.calendarAlt,
                          //                 size: 19,
                          //                 color: Colors.black45,
                          //               ),
                          //             ),
                          //           ),
                          //         )),
                          //   ),
                          // ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: registerInputDecoration("Password"),
                              style: loginTextStyle,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Password must not be empty";
                                }
                                return null;
                              },
                            ),
                          ),
                          isPassword == true
                              ? Container(
                                  margin: const EdgeInsets.only(
                                    top: 7,
                                    left: 12.0,
                                  ),
                                  child: Text(
                                    password,
                                    style: TextStyle(
                                      color: Color(0xFFA93226),
                                    ),
                                  ),
                                )
                              : SizedBox(),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: TextFormField(
                              controller: confirmpwController,
                              obscureText: true,
                              decoration:
                                  registerInputDecoration("Confirm Password"),
                              style: loginTextStyle,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Confirm Password must not be empty";
                                }
                                return null;
                              },
                            ),
                          ),
                          isConfirmPW == true
                              ? Container(
                                  margin: const EdgeInsets.only(
                                    top: 7,
                                    left: 12.0,
                                  ),
                                  child: Text(
                                    confirmPW,
                                    style: TextStyle(
                                      color: Color(0xFFA93226),
                                    ),
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: checkRegister,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 5.0),
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(
                          child: Text(
                            'SIGN UP',
                            style: GoogleFonts.openSans(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (BuildContext context) {
                            return LoginScreen();
                          }), (route) => false);
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                              color: color,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 20)
                  ],
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

  checkRegister() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        loading = true;
      });
      Map<String, String> map = {
        'first_name': frirstnameController.text,
        'last_name': lastnameController.text,
        'phone': phoneController.text,
        'email': emailController.text,
        // 'date_of_birth': startDate,
        'is_shopowner': "1",
        'password': passwordController.text,
        'password_confirmation': confirmpwController.text,
        'gender': dropdownValue == null ? "" : dropdownValue
      };
      print("Regist Data => $map");
      _bloc.register(map);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _bloc.dispose();
    super.dispose();
  }
}

// if (passwordController.text != confirmpwController.text) {
//   setState(() {
//     isConfirmPW = true;
//     confirmPW = "The password confirmation does not match.";
//   });
// } else {
//   isConfirmPW = false;
// }
// setState(() {
//   if (frirstnameController.text.isEmpty) {
//     return firstName = "First Name must not be empty.";
//   }
//   if (lastnameController.text.isEmpty) {
//     return lastName = "Last Name must not be empty.";
//   }
//   if (passwordController.text.isEmpty) {
//     return password = "Password must not be empty.";
//   }
//   if (confirmpwController.text.isEmpty) {
//     return confirmPW = "Confirmation Password must not be empty.";
//   }
// });

// final pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
// final regExp = RegExp(pattern);
// if (!regExp.hasMatch(phoneController.text)) {
//   AppUtils.showSnackBar("Invalid Phone!", _scaffoldKey.currentState);
//   return;
// } else {
//   if (phoneController.text.length >= 9 &&
//       phoneController.text.length < 10) {
//     phoneController.text = '09' + phoneController.text;
//   } else if (phoneController.text.length >= 11 &&
//       phoneController.text.length < 12) {
//     phoneController.text = '09' + phoneController.text.substring(2);
//   } else {
//     AppUtils.showSnackBar(
//         "Invalid Phone No. Please try again!", _scaffoldKey.currentState);
//     return;
//   }
// if (phoneController.text.length >= 11 &&
//     phoneController.text.length < 12) {
//   phoneController.text = '09' + phoneController.text.substring(2);
// } else {
//   AppUtils.showSnackBar(
//       "Invalid Phone No. Please try again!", _scaffoldKey.currentState);
//   return;
// }
// }

// if (!emailController.text.endsWith("@gmail.com") &&
//     !emailController.text.endsWith("@demo.com")) {
//   AppUtils.showSnackBar(
//       "Invalid Email. Please try again!", _scaffoldKey.currentState);
//   return;
// }

// if (passwordController.text != confirmpwController.text) {
//   AppUtils.showSnackBar(
//       "Invalid Password. Please try again!", _scaffoldKey.currentState);
//   return;
// }
