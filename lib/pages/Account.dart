import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:my_priest/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../shared.dart';
import '../flutter_flow/flutter_flow_drop_down.dart';
import '../flutter_flow/form_field_controller.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class priestList {
  priestList({required this.Priestobject, required this.selected});
  Map Priestobject = {};
  bool selected = false;
}

class Accountwidget extends StatefulWidget {
  const Accountwidget({super.key});

  @override
  State<Accountwidget> createState() => _AccountwidgetState();
}

class _AccountwidgetState extends State<Accountwidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _apicall();
  }

  @override
  void dispose() {
    super.dispose();
  }

  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController fathername = TextEditingController();
  TextEditingController dobname = TextEditingController();
  TextEditingController motherTongue = TextEditingController();
  TextEditingController mobilenumber = TextEditingController();
  TextEditingController address1 = TextEditingController();
  TextEditingController address2 = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;

  Map? mapresponse = null;
  Future _apicall() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    var userid = sharedPreferences.getInt("userid");
    http.Response response1;
    response1 = await http.get(
      Uri.parse(
          "https://${AppConstants.ipaddress.ipaddress}/api/users/$userid"),
      headers: {
        "accept": "*/*",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    if (response1.statusCode == 200) {
      print('successful');

      setState(() {
        mapresponse = json.decode(response1.body);
        fname.text = mapresponse!['firstName'];
        lname.text = mapresponse!['lastName'];
        fathername.text = mapresponse!['fatherName'] == null
            ? ""
            : mapresponse!['fatherName']== "string"
            ? ""
            :mapresponse!['fatherName'];
        motherTongue.text = mapresponse!['motherTongue'] == null
            ? ""
            : mapresponse!['motherTongue']== "string"
            ? ""
            : mapresponse!['motherTongue'];
        mobilenumber.text = mapresponse!['primaryMobile'] == null
            ? ""
            : mapresponse!['primaryMobile'];
        address1.text = mapresponse!['address'] == []
            ? ""
            : mapresponse!['address'][0]['addressLine1'] == null
                ? ""
                : mapresponse!['address'][0]['addressLine1']== "string"
            ? ""
            : mapresponse!['address'][0]['addressLine1'];
        address2.text = mapresponse!['address'] == []
            ? ""
            : mapresponse!['address'][0]['addressLine2'] == null
                ? ""
                : mapresponse!['address'][0]['addressLine2']== "string"
            ? ""
            : mapresponse!['address'][0]['addressLine1'];
                List addressdata=[];
                if(mapresponse!['address'].length > 0 ){
                  if(mapresponse!['address'][0]['description'] != null){
addressdata.addAll(mapresponse!['address'][0]['description'].toString().split('-'));
                  }
                  
                }
                print(mapresponse!['address'][0]['description']);
        city.text = addressdata.length == 0
            ? ""
            : addressdata[0];
        state.text =addressdata.length == 0
            ? ""
            : addressdata[1];
        dropDownValue = addressdata.length == 0
            ? null
            : addressdata[2];
      });

      return mapresponse;
    } else {
      print('fetch unsuccessful');
      print(response1.body);
    }
  }

    Future _updateapicall() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    var userid = sharedPreferences.getInt("userid");
    http.Response response1;
    var data = json.encode(
      {
  "address": [
    {
      "addressLine1": address1.text.length==0?"string":address1.text,
      "addressLine2": address2.text.length==0?"string":address2.text,
      "addressType": "Current",
      "cityId": 1,
      "description": city.text+"-"+state.text+"-"+dropDownValue!,
      "fax": "string",
      "zip": "string"
    }
  ],
  "alternativeMobile": mobilenumber.text,
  "email":mapresponse!['email'],
  "fatherName": fathername.text.length==0?"string":fathername.text,
  "firstName": fname.text,
  "gender": "Male",
  "lastName": lname.text,
  "motherTongue": motherTongue.text.length==0?"string":motherTongue.text,
  "primaryMobile": mobilenumber.text,
  "profileImage": "string",
  "roleId": 1,
  "userType": "USER"
}
    );
    print("update object $data");
    response1 = await http.put(
      Uri.parse(
          "https://${AppConstants.ipaddress.ipaddress}/api/users/$userid"),
      headers: {
        "accept": "*/*",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: data
    );
    if (response1.statusCode == 200) {
      print('successful');
_apicall();
    Fluttertoast.showToast(msg: "Saved", fontSize: 18);

      return mapresponse;
    } else {
      print('fetch unsuccessful');
      print(response1.body);
    }
  }
GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    // Get the height of the app bar
    final double appBarHeight = AppBar().preferredSize.height;

    // Get the height of the status bar
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    // Get the height of the bottom safe area (including any navigation bars)
    final double bottomSafeAreaHeight = MediaQuery.of(context).padding.bottom;

    // Calculate the remaining height after subtracting the app bar, status bar, and bottom safe area heights
    double remainingHeight = screensize.height -
        appBarHeight -
        statusBarHeight -
        bottomSafeAreaHeight;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
            floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              if (formkey.currentState!.validate()) {
                 _updateapicall();
              }
            },
            label: Container(
              width: screensize.width * 0.8,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Save',
                  style: FlutterFlowTheme.of(context).titleLarge.override(
                        fontFamily: 'Inter Tight',
                        color:  Color(0xFFD66223),
                        fontSize: 16.0,
                        letterSpacing: 0.0,
                      ),
                ),
              ),
            ),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                    width: 2,
                    color:Color(0xFFD66223))),
          ),
          key: scaffoldKey,
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Color(0xFFFFF7EA),
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
            title: Text(
              'My Profile',
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily: 'Inter Tight',
                    color: Color(0xFF1E2022),
                    fontSize: 22.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            actions: [
              Align(
                alignment: AlignmentDirectional(-1.0, 0.0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                  child: FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 8.0,
                    buttonSize: 40.0,
                    fillColor: Color(0x00FFFFFF),
                    icon: Icon(
                      Icons.menu,
                      color: Color(0xFF1E2022),
                      size: 30.0,
                    ),
                    onPressed: () {
                      print('IconButton pressed ...');
                    },
                  ),
                ),
              ),
            ],
            centerTitle: true,
            elevation: 0.0,
          ),
          body: Form(
            key: formkey,
            child: Container(
              height: remainingHeight,
              child: SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.only(top: 12,left: 12,right: 12,bottom: 80),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Personal Details',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Montserrat',
                                color: Color(0xFFFD642A),
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15, bottom: 10),
                              child: Text(
                                'Name',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Montserrat',
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                            TextFormField(
                              controller: fname,
                              autofocus: false,
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: 'First name',
                                labelStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                  ),
                              cursorColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Required";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: lname,
                              autofocus: false,
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: 'Last name',
                                labelStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                  ),
                              cursorColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Required";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15, bottom: 10),
                              child: Text(
                                'Father Name',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Montserrat',
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                            TextFormField(
                              controller: fathername,
                              autofocus: false,
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: 'Father name',
                                labelStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                  ),
                              cursorColor:
                                  FlutterFlowTheme.of(context).primaryText,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15, bottom: 10),
                              child: Text(
                                'Mother Tongue',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Montserrat',
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                            TextFormField(
                              controller: motherTongue,
                              autofocus: false,
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: 'Mother Tongue',
                                labelStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                  ),
                              cursorColor:
                                  FlutterFlowTheme.of(context).primaryText,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15, bottom: 10),
                              child: Text(
                                'Mobile number',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Montserrat',
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                            TextFormField(
                              controller: mobilenumber,
                              autofocus: false,
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: 'Mobile number',
                                labelStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                  ),
                              cursorColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Required";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Address Details',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Montserrat',
                                color: Color(0xFFFD642A),
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15, bottom: 10),
                              child: Text(
                                'Address',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Montserrat',
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                            TextFormField(
                              controller: address1,
                              autofocus: false,
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: 'Address line 1',
                                labelStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                  ),
                              cursorColor:
                                  FlutterFlowTheme.of(context).primaryText,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: address2,
                              autofocus: false,
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: 'Address line 2',
                                labelStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                  ),
                              cursorColor:
                                  FlutterFlowTheme.of(context).primaryText,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15, bottom: 10),
                              child: Text(
                                'City',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Montserrat',
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                            TextFormField(
                              controller: city,
                              autofocus: false,
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: 'City',
                                labelStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                  ),
                              cursorColor:
                                  FlutterFlowTheme.of(context).primaryText,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15, bottom: 10),
                              child: Text(
                                'State',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Montserrat',
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                            TextFormField(
                              controller: state,
                              autofocus: false,
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: 'State',
                                labelStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                  ),
                              cursorColor:
                                  FlutterFlowTheme.of(context).primaryText,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15, bottom: 10),
                              child: Text(
                                'Country',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Montserrat',
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                            FlutterFlowDropDown<String>(
                              controller: dropDownValueController ??=
                                  FormFieldController<String>(null),
                              options: ['India', 'USA', 'Australia'],
                              onChanged: (val) =>
                                  safeSetState(() => dropDownValue = val),
                              width: double.infinity,
                              height: 40.0,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w300,
                                  ),
                              hintText:dropDownValue==null? 'Select Country':dropDownValue,
                              icon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: FlutterFlowTheme.of(context).secondaryText,
                                size: 24.0,
                              ),
                              fillColor: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              elevation: 2.0,
                              borderColor: Colors.transparent,
                              borderWidth: 0.0,
                              borderRadius: 8.0,
                              margin: EdgeInsetsDirectional.fromSTEB(
                                  12.0, 0.0, 12.0, 0.0),
                              hidesUnderline: true,
                              isOverButton: false,
                              isSearchable: false,
                              isMultiSelect: false,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )),
            ),
          ),
        ),
      ),
    );
  }
}
