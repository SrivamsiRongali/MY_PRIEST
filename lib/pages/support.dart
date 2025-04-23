// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../database/dbhelper.dart';
import '../../database/pojoclass.dart';
import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../shared.dart';

class support extends StatefulWidget {
  const support({super.key});

  @override
  State<support> createState() => _supportState();
}

class _supportState extends State<support> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;
    final screensize = MediaQuery.of(context).size;
    final screenwidth = MediaQuery.of(context).size.width;
    final tabbarheight = MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFEF2DA),
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30.0,
          borderWidth: 1.0,
          buttonSize: 60.0,
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF1E2022),
            size: 30.0,
          ),
          onPressed: () async {
            Get.back();
          },
        ),
        // title: Text(
        //   'Support',
        //   style: FlutterFlowTheme.of(context).headlineMedium.override(
        //         fontFamily: 'Inter Tight',
        //         color: Color(0xFF1E2022),
        //         fontSize: 22.0,
        //         letterSpacing: 0.0,
        //         fontWeight: FontWeight.w500,
        //       ),
        // ),
        centerTitle: true,
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: Container(
        height: 200,
        width: screenwidth,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Text(
                'For support / help, write to us @',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            TextButton.icon(
              
              onPressed: () {
                Clipboard.setData(
                    ClipboardData(text: 'info@indianpriestservices.com'));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                    'Copied to clipboard!',
                  )),
                );
              },
              icon: Icon(Icons.copy),
              label: Text(
                'info@indianpriestservices.com',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
