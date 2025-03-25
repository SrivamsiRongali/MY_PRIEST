// ignore_for_file: camel_case_types, prefer_const_constructors
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../flutter_flow/flutter_flow_theme.dart';
import '../../shared.dart';
import 'signin.dart';


class signup2 extends StatefulWidget {
  const signup2({super.key});

  @override
  State<signup2> createState() => _signup2State();
}

class _signup2State extends State<signup2> {
  bool securetext = true;
  bool securetext2 = true;
  bool visibility = true;
  TextEditingController firstnamecontroller = TextEditingController();
  // TextEditingController middlenamecontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController passwordcontroller2 = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController mobilecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;

    final screenwidth = MediaQuery.of(context).size.width;
double statusBarHeight = MediaQuery.of(context).padding.top;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
            child: Container(
              width: 40,
              height: 10,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Get.back();
                },
                color: Colors.white,
              ),
            ),
          ),
          leadingWidth: 80,
        ),
        body: Container(
          
          child: SingleChildScrollView(
            child: Stack(
              children: [
                 Image.asset("assets/images/Login_background.png",fit: BoxFit.fill,width: screenwidth,height: screenheight-statusBarHeight,),
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
                                          'Sign Up',
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
                                'Enter your information below to create an account',
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
                            controller: firstnamecontroller,
                            keyboardType: TextInputType.name,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                              labelText: "First name",
                              labelStyle: TextStyle(color: Color.fromARGB(255, 204, 204, 204)),
                              // hintText: "Enter Email",
                              hintStyle: TextStyle(fontWeight: FontWeight.bold),
                              border:  OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      BorderSide(color: Color.fromARGB(255, 232, 232, 232), width: 1)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      BorderSide(color: Color.fromARGB(255, 214, 98, 35), width: 1)),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Color.fromARGB(255, 204, 204, 204),
                              ),
                            
                            ),
                            textInputAction: TextInputAction.next,
                            // onEditingComplete: () {
                            //   FocusScope.of(context).requestFocus(passordfocus);
                            // },
                            maxLines: 1,
                           validator: (value) {
                              if (value!.isEmpty ) {
                                return "Please enter First name";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ), 
                        // Padding(
                        //    padding: const EdgeInsets.only(bottom: 10),
                        //   child: TextFormField(
                        //     controller: middlenamecontroller,
                        //     keyboardType: TextInputType.name,
                        //     cursorColor: Colors.black,
                        //     decoration: InputDecoration(
                        //     filled: true,
                        //     fillColor: Colors.white,
                        //       labelText: "Middle name",
                        //       labelStyle: TextStyle(color: Color.fromARGB(255, 204, 204, 204)),
                        //       // hintText: "Enter Email",
                        //       hintStyle: TextStyle(fontWeight: FontWeight.bold),
                        //       border:  OutlineInputBorder(
                        //           borderRadius: BorderRadius.circular(5),
                        //           borderSide:
                        //               BorderSide(color: Color.fromARGB(255, 232, 232, 232), width: 1)),
                        //       focusedBorder: OutlineInputBorder(
                        //           borderRadius: BorderRadius.circular(5),
                        //           borderSide:
                        //               BorderSide(color: Color.fromARGB(255, 214, 98, 35), width: 1)),
                        //       prefixIcon: Icon(
                        //         Icons.person,
                        //         color: Color.fromARGB(255, 204, 204, 204),
                        //       ),
                              
                        //     ),
                        //     textInputAction: TextInputAction.next,
                        //     // onEditingComplete: () {
                        //     //   FocusScope.of(context).requestFocus(passordfocus);
                        //     // },
                        //     maxLines: 1,
                        //     validator: (value) {
                        //       if (value!.isEmpty ) {
                        //         return "Please enter Middle name";
                        //       } else {
                        //         return null;
                        //       }
                        //     },
                        //   ),
                        // ),
                         Padding(
                           padding: const EdgeInsets.only(bottom: 10),
                          child: TextFormField(
                            controller: lastnamecontroller,
                            keyboardType: TextInputType.name,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                              labelText: "Last name",
                              labelStyle: TextStyle(color: Color.fromARGB(255, 204, 204, 204)),
                              // hintText: "Enter Email",
                              hintStyle: TextStyle(fontWeight: FontWeight.bold),
                              border:  OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      BorderSide(color: Color.fromARGB(255, 232, 232, 232), width: 1)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      BorderSide(color: Color.fromARGB(255, 214, 98, 35), width: 1)),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Color.fromARGB(255, 204, 204, 204),
                              ),
                              
                            ),
                            textInputAction: TextInputAction.next,
                            // onEditingComplete: () {
                            //   FocusScope.of(context).requestFocus(passordfocus);
                            // },
                            maxLines: 1,
                            validator: (value) {
                              if (value!.isEmpty ) {
                                return "Please enter Last name";
                              } else {
                                return null;
                              }
                            },
                          ),
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
                              labelText: "Email Address",
                              labelStyle: TextStyle(color: Color.fromARGB(255, 204, 204, 204)),
                              // hintText: "Enter Email",
                              hintStyle: TextStyle(fontWeight: FontWeight.bold),
                              border:  OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      BorderSide(color: Color.fromARGB(255, 232, 232, 232), width: 1)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      BorderSide(color: Color.fromARGB(255, 214, 98, 35), width: 1)),
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
                                  return ('Please enter valid Email Id ');
                                }
                                return "Enter Email Id";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      
                        Padding(
                           padding: const EdgeInsets.only(bottom: 10),
                          child: TextFormField(
                            controller: mobilecontroller,
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.black,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              filled: true,
                            fillColor: Colors.white,
                              labelText: "Mobile Number",
                              labelStyle: TextStyle(color: Color.fromARGB(255, 204, 204, 204)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      BorderSide(color: Color.fromARGB(255, 232, 232, 232), width: 1)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      BorderSide(color: Color.fromARGB(255, 214, 98, 35), width: 1)),
                              prefixIcon: Icon(
                                Icons.phone_android,
                                color: Color.fromARGB(255, 204, 204, 204),
                              ),
                              suffixIcon: IconButton(
                                  icon: Icon(visibility ? null : Icons.clear),
                                  onPressed: () {
                                    mobilecontroller.clear();
                                  },
                                  color: Color.fromARGB(255, 204, 204, 204),
                                  ),
                            ),
                            maxLines: 1,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Phone Number";
                              }
                              // if (countryCode == null) {
                              //   return "select country code";
                              // }
                              if (value.length != 10) {
                                setState(() {
                                  visibility = false;
                                });
                                return "Enter valid Phone Number";
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
                              labelStyle: TextStyle(color: Color.fromARGB(255, 204, 204, 204)),
                              // hintText: "Password",
                              // hintStyle: TextStyle(fontWeight: FontWeight.bold),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      BorderSide(color: Color.fromARGB(255, 232, 232, 232), width: 1)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      BorderSide(color: Color.fromARGB(255, 214, 98, 35), width: 1)),
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
                                return "Required";
                              } else if (value.length < 8) {
                                return "Enter valid Password";
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
                            controller: passwordcontroller2,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: "Re-enter password",
                              labelStyle: TextStyle(color: Color.fromARGB(255, 204, 204, 204)),
                              // hintText: "Password",
                              // hintStyle: TextStyle(fontWeight: FontWeight.bold),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      BorderSide(color: Color.fromARGB(255, 232, 232, 232), width: 1)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      BorderSide(color: Color.fromARGB(255, 214, 98, 35), width: 1)),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Color.fromARGB(255, 204, 204, 204),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(securetext2
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined),
                                onPressed: () {
                                  setState(() {
                                    securetext2 = !securetext2;
                                  });
                                },
                                color: Color.fromARGB(255, 204, 204, 204),
                              ),
                            ),
                            obscureText: securetext2,
                            obscuringCharacter: "*",
                            maxLines: 1,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Required";
                              } else if (value.length < 8) {
                                return "Enter valid Password";
                              } 
                              else if (value!=passwordcontroller.text) {
                                return "Enter valid Password";
                              }
                              else {
                                return null;
                              }
                            },
                          ),
                        ),
                    
                        MaterialButton(
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              String email = emailcontroller.text;
                              String password = passwordcontroller.text;
                              String mobilenumber = mobilecontroller.text;
                
                              // Get.to(screen4_5());
                              usersignup(email, password, mobilenumber);
                              print(
                                  " email = $email,password=$password,mobilenumber=$mobilenumber");
                            } else {
                              print('error');
                            }
                          },
                          color: Color.fromARGB(255, 214, 98, 35),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 19),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                Text('Sign Up',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   height: screenheight * 0.05,
                        // ),
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
                        //                   child: Image.asset(
                        //                       'images/Facebook-logo.png')
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
                        // Text(
                        //   'Or Continue with Social Account',
                        //   style: TextStyle(
                        //       color: Colors.grey,
                        //       fontSize: 13,
                        //       fontWeight: FontWeight.w400),
                        // ),
                        // SizedBox(
                        //   height: screenheight * 0.0005,
                        // ),
                        // Container(
                        //   height: screenheight * 0.072,
                        //   width: screenwidth * 0.8,
                        //   child: Center(
                        //     child: MaterialButton(
                        //       onPressed: () async {
                        //         Get.defaultDialog(
                        //             title: "Coming Soon",
                        //             titlePadding: EdgeInsets.only(top: 10),
                        //             content: Text(""),
                        //             actions: [
                        //               MaterialButton(
                        //                 color: Color.fromARGB(255, 255, 123, 0),
                        //                 onPressed: () {
                        //                   Get.back();
                        //                 },
                        //                 child: Text(
                        //                   'OK',
                        //                   style: TextStyle(color: Colors.white),
                        //                 ),
                        //               )
                        //             ]);
                        //         //googleLogin();
                        //       },
                        //       color: Colors.white,
                        //       shape: RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.circular(50)),
                        //       child: Padding(
                        //         padding: EdgeInsets.symmetric(vertical: 15),
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.center,
                        //           // ignore: prefer_const_literals_to_create_immutables
                        //           children: [
                        //             Row(
                        //               children: [
                        //                 Container(
                        //                   height: screenheight * 0.022,
                        //                   // width: screenwidth * 0.1,
                        //                   child: SvgPicture.asset(
                        //                     'images/Group.svg',
                        //                     fit: BoxFit.contain,
                        //                   ),
                        //                 ),
                        //                 Text("Sign Up with Google")
                        //               ],
                        //             )
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future usersignup(String email, String password, String mobilenumber) async {
    print(" email = $email,password=$password,mobilenumber=$mobilenumber");
    var data = json.encode({
  "alternativeMobile":  mobilenumber.toString(),
  "confirmPassword": password,
  "dateOfBirth": "2024-08-05T04:57:29.754Z",
  "email": email,
  "fatherName": "string",
  "firstName": firstnamecontroller.text,
  "gender": "Female",
  "lastName": lastnamecontroller.text,
  // "middleName": middlenamecontroller.text,
  "password":  password,
  "primaryMobile": mobilenumber.toString(),
  "profileImage": "string",
  "roleId": 1,
  "userType": "USER"
    });
 print("sign-up object = $data");
    http.Response response = await http.post(
        Uri.parse(
            "https://${AppConstants.ipaddress.ipaddress}/api/auth/sign-up"),
        headers: {"accept": "*/*", "Content-Type": "application/json"},
        body: data);

    if (response.statusCode == 201) {
      print('Login with email & password');

      print(response.body);

      // var Lastname = mapresponse['user']['lastName'];
      // showDialog(
      //     context: context,
      //     builder: (context) => AlertDialog(
      //           title: Text('Account Created'),
      //           actions: [
      //             MaterialButton(
      //               color: Color.fromARGB(255, 255, 123, 0),
      //               onPressed: () {
      //                 Navigator.push(context,
      //                     MaterialPageRoute(builder: (context) => screen4_5()));
      //               },
      //               child: Text(
      //                 'OK',
      //                 style: TextStyle(color: Colors.white),
      //               ),
      //             )
      //           ],
      //         ));
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Resgistered Successfully'),
                actions: [
                  MaterialButton(
                    color: Color.fromARGB(255, 255, 123, 0),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => signin()));
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
      //     "Account Created",
      //     style: TextStyle(fontSize: 20),
      //   ),
      //   textConfirm: "Ok",
      //   confirmTextColor: Colors.white,
      //   onConfirm: () {

      //     // Get.offNamed(Routes.PRODUCTS);
      //   },
      // );
    } else {
      print(" data =$data");
      print('fail');
      Get.defaultDialog(
        title: " ",
        titleStyle: TextStyle(color: Colors.red),
        content: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Text(
            "Unable to create account please try again later",
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
