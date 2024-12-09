import 'package:flutter/material.dart';

class Accountwidget extends StatefulWidget {
  const Accountwidget({super.key});

  @override
  State<Accountwidget> createState() => _AccountwidgetState();
}

class _AccountwidgetState extends State<Accountwidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: 300,
        color: Colors.white,
        width: double.infinity,
        child: Center(child: Text("Coming soon",style: TextStyle(color: Colors.black),),),
      ),
    );
  }
}