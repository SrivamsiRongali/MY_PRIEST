import 'dart:convert';

import 'package:get/get.dart';
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

class TemplesWidget extends StatefulWidget {
  const TemplesWidget({super.key});

  @override
  State<TemplesWidget> createState() => _TemplesWidgetState();
}

class _TemplesWidgetState extends State<TemplesWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _apicall();
  }

  var servicedata = Get.arguments;

  List templeList = List.empty(growable: true);
  Map? mapresponse = null;
  Future _apicall() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    var priestid = sharedPreferences.getInt("priest_id");
    http.Response response1;

    response1 = await http.get(
      Uri.parse(
          "https://${AppConstants.ipaddress.ipaddress}/api/temples?pageIndex=0&pageSize=200&sortBy=id&sortOrder=DESC"),
      headers: {
        "accept": "*/*",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    if (response1.statusCode == 200) {
      print('successful');
      print(response1.body);
      mapresponse = json.decode(response1.body);
      setState(() {
        templeList = mapresponse!['data'];
      });

      return mapresponse;
    } else {
      print(response1.statusCode);
      print('fetch unsuccessful');
      print(response1.body);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
 var flow = Get.arguments;
  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xFFFFF7EA),
           automaticallyImplyLeading: false,
            leading: flow==null? Container():FlutterFlowIconButton(
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
            'Temples',
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
        body: SafeArea(
          top: true,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 15.0, 10.0),
              child: SingleChildScrollView(
                child: templeList.length == 0
                    ? Container(
                        height: 200,
                        width: double.infinity,
                        child: Center(
                            child: Text("No Temple(s) are available near you")),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: templeList.length,
                        itemBuilder: (BuildContext context, int index) =>
                            Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 10.0, 0.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        height: screensize.height * 0.13,
                                        width: screensize.width * 0.26,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Image.network(
                                            templeList[index]['user']
                                                        ['profileImage'] ==
                                                    null
                                                ? "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"
                                                : templeList[index]['user']
                                                    ['profileImage'],
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            15.0, 0.0, 0.0, 0.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: screensize.width * 0.622,
                                              child: Text(
                                                templeList[index]['name'],
                                                // maxLines: 2,
                                                // overflow: TextOverflow.ellipsis,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          color: Colors.black,
                                                          fontFamily: 'Inter',
                                                          fontSize: 18.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                              ),
                                            ),
                                            templeList[index]['street'] == null
                                                ? Container()
                                                : SizedBox(
                                                    height: 5,
                                                  ),
                                            templeList[index]['street'] == null
                                                ? Container()
                                                : Container(
                                                    width:
                                                        screensize.width * 0.6,
                                                    child: Text(
                                                      templeList[index]
                                                          ['street'],
                                                      // overflow: TextOverflow.ellipsis,
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            color: Colors.black,
                                                            fontFamily: 'Inter',
                                                            fontSize: 12.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                          ),
                                                    ),
                                                  ),
                                            templeList[index]['website'] == null
                                                ? Container()
                                                : SizedBox(
                                                    height: 5,
                                                  ),
                                            templeList[index]['website'] == null
                                                ? Container()
                                                : Container(
                                                    width:
                                                        screensize.width * 0.6,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        launchURL(
                                                            templeList[index]
                                                                ['website']);
                                                      },
                                                      child: Text(
                                                        templeList[index]
                                                            ['website'],
                                                        // overflow: TextOverflow.ellipsis,
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyMedium
                                                            .override(
                                                              color:
                                                                  Colors.blue,
                                                              fontFamily:
                                                                  'Inter',
                                                              fontSize: 12.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  MaterialButton(
                                    elevation: 0,
                                    onPressed: () {
                                      // lat = listresponse![index]['address']['geo']
                                      //         ['lat']
                                      //     ;
                                      // lng = listresponse![index]['address']['geo']
                                      //         ['lng']
                                      //     ;
                                      launchURL(
                                          "https://www.google.com/maps/search/${templeList[index]['street'] == null ? templeList[index]['name'] : Uri.encodeComponent(templeList[index]['name'] + templeList[index]['street'])}");
                                    },
                                    color: Color.fromARGB(255, 255, 183, 2),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 19),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          Text('Directions',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight:
                                                      FontWeight.w700)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 2.0,
                              height: 20,
                              color: const Color.fromARGB(146, 220, 220, 220),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
