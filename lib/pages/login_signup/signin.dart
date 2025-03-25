// ignore_for_file: camel_case_types, prefer_const_constructors
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_priest/index.dart';
import 'package:my_priest/main.dart';
import 'package:my_priest/pages/login_signup/signup2.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:fluttertoast/fluttertoast.dart';

import '../../flutter_flow/flutter_flow_theme.dart';
import '../../shared.dart';
import 'signup1.dart';

class signin extends StatefulWidget {
  const signin({super.key});

  @override
  State<signin> createState() => _signinState();
}

class _signinState extends State<signin> {
  bool securetext = true;
  bool visibility = true;

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  DateTime backpressed = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;

    final screenwidth = MediaQuery.of(context).size.width;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(backpressed);
        final isexisting = difference >= Duration(seconds: 2);
        backpressed = DateTime.now();
        if (isexisting) {
          Fluttertoast.showToast(msg: "Press back again to exit", fontSize: 18);
          return false;
        } else {
          return true;
        }
      },
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Color(0xFFFEF2DA),
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: Container(
              // decoration: BoxDecoration(
              //   image: DecorationImage(image: AssetImage("assets/images/Login_background.png",)),
              // ),

              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/images/Login_background.png",
                      fit: BoxFit.fill,
                      width: screenwidth,
                      height: screenheight - statusBarHeight,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
                      child: Form(
                        key: formkey,
                        child: Column(
                          children: [
                            // Image.asset('images/priest logo.png'),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 30.0, 0.0, 23.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  'assets/images/Group.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Color.fromARGB(255, 200, 4, 50),
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                           
                            Padding(
                               padding: const EdgeInsets.only(bottom: 20),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Please login to continue',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          color: Colors.black,
                                          letterSpacing: 0.0,
                                          fontSize: 14,
                                          lineHeight: 1.2,
                                        ),
                                  )),
                            ),

                            
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: TextFormField(
                                controller: emailcontroller,
                                keyboardType: TextInputType.emailAddress,
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                  filled: true,
                                                          fillColor: Colors.white,
                                  hoverColor: Colors.white,
                              
                                  labelText: "Email Address",
                                  labelStyle: TextStyle(
                                      color:
                                          Color.fromARGB(255, 204, 204, 204)),
                                  // hintText: "Enter Email",
                                  hintStyle:
                                      TextStyle(fontWeight: FontWeight.bold),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 232, 232, 232),
                                          width: 0.1)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 214, 98, 35),
                                          width: 1)),
                                  prefixIcon: Icon(
                                    Icons.mail,
                                    color: Color.fromARGB(255, 204, 204, 204),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(visibility ? null : Icons.clear),
                                    onPressed: () {
                                      emailcontroller.clear();
                                    },
                                    color: Color.fromARGB(255, 204, 204, 204),
                                  ),
                                ),
                                textInputAction: TextInputAction.next,
                                // onEditingComplete: () {
                                //   FocusScope.of(context).requestFocus(passordfocus);
                                // },
                                maxLines: 1,
                                validator: (value) {
                                  if (value!.isEmpty ||
                                      !RegExp("^[a-zA-Z0-9+_.-]+@[a-z-A-Z0-9]+[.][a-zA-Z]+[a-zA-Z]")
                                          .hasMatch(value)) {
                                    setState(() {
                                      visibility = false;
                                    });
                                    if (value.isNotEmpty) {
                                      return ('Please enter valid email id ');
                                    }
                                    return "enter email id";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                        
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: TextFormField(
                                cursorColor: Colors.black,
                                controller: passwordcontroller,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: "Password",
                                  labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 204, 204, 204)),
                                  // hintText: "Password",
                                  // hintStyle: TextStyle(fontWeight: FontWeight.bold),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 232, 232, 232),
                                          width: 0.1)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(255, 214, 98, 35),
                                          width: 1)),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Color.fromARGB(255, 204, 204, 204),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(securetext
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined),
                                    onPressed: () {
                                      setState(() {
                                        securetext = !securetext;
                                      });
                                    },
                                    color: Color.fromARGB(255, 204, 204, 204),
                                  ),
                                ),
                                obscureText: securetext,
                                obscuringCharacter: "*",
                                maxLines: 1,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "required";
                                  } else if (value.length < 8) {
                                    return "enter valid Password";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                        
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: MaterialButton(
                                onPressed: () {
                                  if (formkey.currentState!.validate()) {
                                    String email = emailcontroller.text;
                                    String password = passwordcontroller.text;
                                    userlogin(email, password);
                                  } else {
                                    print('error');
                                  }
                                },
                                color: Color.fromARGB(255, 214, 98, 35),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 19),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      Text('Login',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          
                            Row(
                              children: [
                                TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'Forgot Password?',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Inter',
                                            color: Color.fromARGB(
                                                255, 214, 98, 35),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.0,
                                            lineHeight: 1.2,
                                          ),
                                    )),
                              ],
                            ),

                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     Container(
                            //       height: screenheight * 0.082,
                            //       width: screenwidth * 0.165,
                            //       child: MaterialButton(
                            //         onPressed: () async {
                            //           //googleLogin();
                            //         },
                            //         color: Colors.white,
                            //         shape: RoundedRectangleBorder(
                            //             borderRadius: BorderRadius.circular(5)),
                            //         child: Padding(
                            //           padding: EdgeInsets.symmetric(vertical: 20),
                            //           child: Row(
                            //             mainAxisAlignment: MainAxisAlignment.center,
                            //             // ignore: prefer_const_literals_to_create_immutables
                            //             children: [
                            //               Container(
                            //                 height: screenheight * 0.052,
                            //                 width: screenwidth * 0.075,
                            //                 child: SvgPicture.asset(
                            //                   'images/Group.svg',
                            //                 ),
                            //               )
                            //             ],
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     SizedBox(
                            //       width: screenwidth * 0.02,
                            //     ),
                            //     Container(
                            //       height: screenheight * 0.082,
                            //       width: screenwidth * 0.165,
                            //       child: MaterialButton(
                            //         onPressed: () async {
                            //           //googleLogin();
                            //         },
                            //         color: Colors.white,
                            //         shape: RoundedRectangleBorder(
                            //             borderRadius: BorderRadius.circular(5)),
                            //         child: Padding(
                            //           padding: EdgeInsets.symmetric(vertical: 20),
                            //           child: Row(
                            //             mainAxisAlignment: MainAxisAlignment.center,
                            //             // ignore: prefer_const_literals_to_create_immutables
                            //             children: [
                            //               Container(
                            //                   height: screenheight * 0.052,
                            //                   width: screenwidth * 0.075,
                            //                   child:
                            //                       Image.asset('images/Facebook-logo.png')
                            //                   // SvgPicture.asset(
                            //                   //   'images/f_logo_RGB-Blue_1441.svg',
                            //                   //   height: 25,
                            //                   //   width: 25,
                            //                   // )
                            //                   )
                            //             ],
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     SizedBox(
                            //       width: screenwidth * 0.02,
                            //     ),
                            //     Container(
                            //       height: screenheight * 0.082,
                            //       width: screenwidth * 0.165,
                            //       child: MaterialButton(
                            //         onPressed: () async {
                            //           //googleLogin();
                            //         },
                            //         color: Colors.white,
                            //         shape: RoundedRectangleBorder(
                            //             borderRadius: BorderRadius.circular(5)),
                            //         child: Padding(
                            //           padding: EdgeInsets.symmetric(vertical: 20),
                            //           child: Row(
                            //             mainAxisAlignment: MainAxisAlignment.center,
                            //             // ignore: prefer_const_literals_to_create_immutables
                            //             children: [
                            //               Container(
                            //                 height: screenheight * 0.052,
                            //                 width: screenwidth * 0.075,
                            //                 child: SvgPicture.asset(
                            //                   'images/apple-black 1.svg',
                            //                 ),
                            //               )
                            //             ],
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     SizedBox(
                            //       width: screenwidth * 0.02,
                            //     ),
                            //     Container(
                            //       height: screenheight * 0.082,
                            //       width: screenwidth * 0.165,
                            //       child: MaterialButton(
                            //         onPressed: () async {
                            //           //googleLogin();
                            //         },
                            //         color: Colors.white,
                            //         shape: RoundedRectangleBorder(
                            //             borderRadius: BorderRadius.circular(5)),
                            //         child: Padding(
                            //           padding: EdgeInsets.symmetric(vertical: 20),
                            //           child: Row(
                            //             mainAxisAlignment: MainAxisAlignment.center,
                            //             // ignore: prefer_const_literals_to_create_immutables
                            //             children: [
                            //               Container(
                            //                 height: screenheight * 0.052,
                            //                 width: screenwidth * 0.075,
                            //                 child: SvgPicture.asset(
                            //                   'images/twitter-color 1.svg',
                            //                 ),
                            //               ),
                            //             ],
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // SizedBox(
                            //   height: screenheight * 0.012,
                            // ),

                            // Padding(
                            //   padding:
                            //       const EdgeInsets.only(top: 10, bottom: 20),
                            //   child: Image.asset(
                            //     "assets/images/Group 4.png",
                            //     fit: BoxFit.fitWidth,
                            //   ),
                            // ),
                            
                            // MaterialButton(
                            //   onPressed: () async {
                            //     Get.defaultDialog(
                            //         title: "Coming Soon",
                            //         titlePadding: EdgeInsets.only(top: 10),
                            //         content: Text(""),
                            //         actions: [
                            //           MaterialButton(
                            //             color: Color.fromARGB(
                            //                 255, 214, 98, 35),
                            //             onPressed: () {
                            //               Get.back();
                            //             },
                            //             child: Text(
                            //               'OK',
                            //               style: TextStyle(
                            //                   color: Colors.white),
                            //             ),
                            //           )
                            //         ]);
                            //     //googleLogin();
                            //   },
                            //   color: Colors.white,
                            //   elevation: 0,
                            //   shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(5)),
                            //   child: Padding(
                            //     padding: EdgeInsets.symmetric(vertical: 19),
                            //     child: Row(
                            //       mainAxisAlignment:
                            //           MainAxisAlignment.center,
                            //       // ignore: prefer_const_literals_to_create_immutables
                            //       children: [
                            //         Row(
                            //           children: [
                            //             Container(
                            //                 height: screenheight * 0.022,
                            //                 // width: screenwidth * 0.08,
                            //                 child: SvgPicture.asset(
                            //                   'images/Group.svg',
                            //                   fit: BoxFit.contain,
                            //                 )),
                            //             Text("Login with Google",
                            //                 style: TextStyle(fontSize: 14)),
                            //           ],
                            //         )
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Don't have an account?",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400)),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => signup2()));
                                    },
                                    child: Text('Create Now',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 214, 98, 35),
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400)))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Future userlogin(String email, String password) async {
    var data = json.encode({
      "email": email,
      "password": password,
    });
    Map mapresponse;
    print("login api is hit");
    http.Response response = await http.post(
        Uri.parse(
            "https://${AppConstants.ipaddress.ipaddress}/api/auth/sign-in"),
        headers: {"accept": "*/*", "Content-Type": "application/json"},
        body: data);

    if (response.statusCode == 200) {
      mapresponse = json.decode(response.body);

      print('Login with email & password');
      print(mapresponse['user']['firstName']);
      // print(response.body);
      // var Lastname = mapresponse['user']['lastName'];
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
          sharedPreferences.setString("name","${ mapresponse['user']['firstName']} ${mapresponse['user']['lastName']}");
      sharedPreferences.setString("token", mapresponse['token']);
      sharedPreferences.setInt("userid", mapresponse['user']['id']);
      
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Welcome ${mapresponse['user']['firstName']} ${mapresponse['user']['lastName']}'),
                actions: [
                  MaterialButton(
                    color: Color.fromARGB(255, 214, 98, 35),
                    onPressed: () async {
                      final SharedPreferences sharedPreferences =
                          await SharedPreferences.getInstance();
                      sharedPreferences.setBool("flow", true);
                      Get.offAll(NavBarPage());
                    },
                    child: Text(
                      'OK',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ));
      // Get.defaultDialog(
      //   content: Text(
      //     "Welcome ",
      //     style: TextStyle(fontSize: 20),
      //   ),
      //   textConfirm: "Next>>",
      //   confirmTextColor: Colors.white,
      //   onConfirm: () {
      //     Navigator.push(
      //         context, MaterialPageRoute(builder: (context) => screen4_5()));
      //     // Get.offNamed(Routes.PRODUCTS);
      //   },
      // );
    } else {
      print('fail');
      Get.defaultDialog(
        title: "Invalid Email/Password",
        titleStyle: TextStyle(color: Colors.red),
        content: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Text(
            "Please enter valid Email/Password to sign-in",
          ),
        ),
        textConfirm: "ok",
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back();
        },
      );
      print(response.statusCode);
      print(response.body);
    }
  }
}
