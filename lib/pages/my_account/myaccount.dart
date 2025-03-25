// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../shared.dart';
import '../Account.dart';
import '../login_signup/signin.dart';
import '../my_bookings/Mybookings.dart';




class myaccount extends StatefulWidget {
  const myaccount({super.key});

  @override
  State<myaccount> createState() => _myaccountState();
}

class _myaccountState extends State<myaccount> {
  @override
  void initState() {
    super.initState();
    _getuserdataapicall();
    profilepic();
  }

  File? image;
  String? name;
  profilepic() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var images = sharedPreferences.getString("image");

    setState(() {
      image = images==null?null: File(images);
    });
  }

  Future _getuserdataapicall() async {
    Map mapresponse;
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    var userid = sharedPreferences.getInt("userid");
    print("$userid");
    http.Response response1;
    response1 = await http.get(
      Uri.parse("https://${AppConstants.ipaddress.ipaddress}/api/users/$userid"),
      headers: {
        "accept": "*/*",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    if (response1.statusCode == 200) {
      print('successful');
      mapresponse = json.decode(response1.body);

      sharedPreferences.setString("name",
          "${mapresponse["firstName"]==""? "":mapresponse["firstName"]=="string"?"":mapresponse["firstName"]} ${mapresponse["lastName"]==""? "":mapresponse["lastName"]=="string"?"":mapresponse["lastName"]}");
      setState(() {
        name =
            "${mapresponse["firstName"]==""? "":mapresponse["firstName"]=="string"?"":mapresponse["firstName"]} ${mapresponse["lastName"]==""? "":mapresponse["lastName"]=="string"?"":mapresponse["lastName"]}";
      });

      print(mapresponse);
    } else {
      print('fetch unsuccessful');
      print(response1.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;
    final screensize = MediaQuery.of(context).size;
    final screenwidth = MediaQuery.of(context).size.width;
    final tabbarheight = MediaQuery.of(context).padding.top;
    return Scaffold(
           appBar: AppBar(
            backgroundColor: Color(0xFFFFF7EA),
            automaticallyImplyLeading: false,
            // leading: FlutterFlowIconButton(
            //   borderColor: Colors.transparent,
            //   borderRadius: 30.0,
            //   borderWidth: 1.0,
            //   buttonSize: 60.0,
            //   icon: Icon(
            //     Icons.arrow_back_ios,
            //     color: Color(0xFF1E2022),
            //     size: 30.0,
            //   ),
            //   onPressed: () async {
            //     Get.back();
            //   },
            // ),
            title: Text(
              'My Account',
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily: 'Inter Tight',
                    color: Color(0xFF1E2022),
                    fontSize: 22.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w500,
                  ),
            ),
         
            centerTitle: true,
            elevation: 0.0,
          ),
   backgroundColor:  Color(0xFFFFF6EA),
      body: Container(
        height: screenheight,
        width: screenwidth,
        decoration: const BoxDecoration(
            color: Colors.white,
           ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 50, 30, 0),
          child: Column(
            children: [
              Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Stack(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      CircleAvatar(
                          radius: 60.0,
                          backgroundImage: image == null
                              ? NetworkImage(
                                  "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png")
                              : FileImage(image!) as ImageProvider),
                    ],
                  ),
                  SizedBox(
                    height: screenheight * 0.008,
                  ),
                  Text(
                    name == null ? "Full name" : name!.removeAllWhitespace==""?"Full name":name!,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenheight * 0.04,
              ),
              Divider(
                thickness: 1,
                height: 0,
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(()=>mybookings(),arguments: false);
                    },
                    child: SizedBox(
                      height: screenheight * 0.075,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          TextButton(
                            onPressed: () {
                               Get.to(()=>mybookings(),arguments: false);
                            },
                            child: Text(
                              'My Bookings',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,color: Colors.black),
                            ),
                          ),
                          IconButton(
                              onPressed: () {Get.to(()=>mybookings(),arguments: false);},
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                                size: 20,
                              ))
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    height: 0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(()=>Accountwidget());
                    },
                    child: SizedBox(
                      height: screenheight * 0.075,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          TextButton(onPressed: (){
                            Get.to(()=>Accountwidget());
                            }, child: Text(
                            'My Profile',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,color: Colors.black),
                          ),),
                          
                          IconButton(
                              onPressed: () {
                                Get.to(()=>Accountwidget());
                                },
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                                size: 20,
                              ))
                        ],
                      ),
                    ),
                  ),
                
                  Divider(
                    thickness: 1,
                    height: 0,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  final SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  sharedPreferences.remove("flow");
                  Get.offAll(signin());
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 214, 98, 35),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text(
                          'Logout',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        IconButton(
                            onPressed: () async {},
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
