import 'package:flutter/material.dart';

class Templeswidget extends StatefulWidget {
  const Templeswidget({super.key});

  @override
  State<Templeswidget> createState() => _TempleswidgetState();
}

class _TempleswidgetState extends State<Templeswidget> {
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