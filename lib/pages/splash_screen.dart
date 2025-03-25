// ignore_for_file: prefer_const_constructors, unused_local_variable
import 'package:flutter/material.dart';
import 'package:my_priest/index.dart';


import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'login_signup/signin.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

// mathod for navigating to login screen after 1500 millisecond //
  void _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 1500), () {});
    bool flow = false;
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var flo = sharedPreferences.getBool("flow");
    flow = flo ?? false;
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      if (flow == false) {
        return signin();
      } else {
        return NavBarPage();
      }
    }));
  }

  @override
  Widget build(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Container(
          height: screenheight * 1,
          constraints: BoxConstraints.tightForFinite(width: 1000),
          child: Image.asset(
            'images/Frame (5).png',
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
