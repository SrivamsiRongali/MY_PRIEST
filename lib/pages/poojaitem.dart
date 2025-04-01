import 'dart:convert';

import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:my_priest/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../shared.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PoojasitemsWidget extends StatefulWidget {
  const PoojasitemsWidget({super.key});

  @override
  State<PoojasitemsWidget> createState() => _PoojasitemsWidgetState();
}

class _PoojasitemsWidgetState extends State<PoojasitemsWidget> {
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

  List ServicesList = List.empty(growable: true);

  Map? mapresponse;
  Future _apicall() async {
    setState(() {
      loader = true;
    });
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    var priestid = sharedPreferences.getInt("priest_id");
    http.Response response1;
    response1 = await http.get(
      Uri.parse(
          "https://${AppConstants.ipaddress.ipaddress}/api/groceries?pageIndex=0&pageSize=200&sortBy=id&sortOrder=ASC"),
      headers: {
        "accept": "*/*",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    if (response1.statusCode == 200) {
      print('successful');
      mapresponse = json.decode(response1.body);
      setState(() {
        loader = false;
        ServicesList = mapresponse!['data'];
      });

      return mapresponse;
    } else {
      setState(() {
        loader = false;
      });
      print('fetch unsuccessful');
      print(response1.body);
    }
  }

  Future _searchapicall(String search) async {
    setState(() {
      loader = true;
    });
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    var priestid = sharedPreferences.getInt("priest_id");
    http.Response response1;
    response1 = await http.get(
      Uri.parse(
          "https://${AppConstants.ipaddress.ipaddress}/api/groceries?pageIndex=0&pageSize=20&search=$search&sortBy=id&sortOrder=ASC"),
      headers: {
        "accept": "*/*",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    if (response1.statusCode == 200) {
      print('successful');
      mapresponse = json.decode(response1.body);

      setState(() {
        loader = false;
        ServicesList = mapresponse!['data'];
      });

      return mapresponse;
    } else {
      setState(() {
        loader = false;
      });
      print('fetch unsuccessful');
      print(response1.body);
    }
  }

  bool loader = false;
  TextEditingController searchcontroller = TextEditingController();
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
          key: scaffoldKey,
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: const Color(0xFFFFF7EA),
            automaticallyImplyLeading: false,
            leading: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30.0,
              borderWidth: 1.0,
              buttonSize: 60.0,
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Color(0xFF1E2022),
                size: 30.0,
              ),
              onPressed: () async {
                Get.back();
              },
            ),
            title: Text(
              'Pooja items',
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily: 'Inter Tight',
                    color: const Color(0xFF1E2022),
                    fontSize: 22.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            centerTitle: true,
            elevation: 0.0,
          ),
          body: ModalProgressHUD(
            inAsyncCall: loader,
            progressIndicator: const CircularProgressIndicator(
              color: Color.fromARGB(255, 214, 98, 35),
            ),
            child: SizedBox(
              height: remainingHeight,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: const Color(0xFFFFF7EA),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            10.0, 10.0, 10.0, 10.0),
                        child: TextFormField(
                          cursorColor: Colors.black,
                          controller: searchcontroller,
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: (value) {
                            if (value.length >= 3) {
                              _searchapicall(value);
                            } else {
                              _apicall();
                            }
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: "Search Pooja item",
                            labelStyle: const TextStyle(
                                color: Color.fromARGB(255, 204, 204, 204)),
                            // hintText: "Password",
                            // hintStyle: TextStyle(fontWeight: FontWeight.bold),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                    color: Colors.transparent, width: 2)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 2)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                    color: Colors.transparent, width: 0)),
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Color.fromARGB(255, 204, 204, 204),
                            ),
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ),
                    ServicesList.length == 0
                        ? loader
                            ? Container()
                            : Container(
                                height: 200,
                                child: const Center(
                                  child: Text(
                                      "No services are available at the moment"),
                                ),
                              )
                        : ListView.builder(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                10.0, 10.0, 10.0, 60.0),
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: ServicesList.length,
                            itemBuilder: (BuildContext context, int index) =>
                                Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                // width: double.infinity,

                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    const BoxShadow(
                                      blurRadius: 4.0,
                                      color: Color(0x33000000),
                                      offset: Offset(
                                        0.0,
                                        2.0,
                                      ),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10.0, 10.0, 10.0, 10.0),
                                  child: Container(
                                    width: screensize.width * 0.84,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          ServicesList[index]['name'],
                                          textAlign: TextAlign.start,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                color: Colors.black,
                                                fontFamily: 'Inter',
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                        Text(
                                          ServicesList[index]['description']==null?"": ServicesList[index]['description']=="string"?"": ServicesList[index]['description'],
                                          textAlign: TextAlign.start,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                color: Colors.black,
                                                fontFamily: 'Inter',
                                                fontSize: 12.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
