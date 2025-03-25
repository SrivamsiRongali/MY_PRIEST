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

class pravachanamWidget extends StatefulWidget {
  const pravachanamWidget({super.key});

  @override
  State<pravachanamWidget> createState() => _pravachanamWidgetState();
}

class _pravachanamWidgetState extends State<pravachanamWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // _apicall();
  }

  // var servicedata = Get.arguments;

  // List templeList = List.empty(growable: true);
  // Map? mapresponse;
  // Future _apicall() async {
  //   setState(() {
  //     loader=true;
  //   });
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   var token = sharedPreferences.getString("token");
  //   var priestid = sharedPreferences.getInt("priest_id");
  //   http.Response response1;

  //   response1 = await http.get(
  //     Uri.parse(
  //         "https://${AppConstants.ipaddress.ipaddress}/api/temples?pageIndex=0&pageSize=200&sortBy=id&sortOrder=DESC"),
  //     headers: {
  //       "accept": "*/*",
  //       "Content-Type": "application/json",
  //       "Authorization": "Bearer $token"
  //     },
  //   );
  //   if (response1.statusCode == 200) {
  //     print('successful');
  //     print(response1.body);
  //     mapresponse = json.decode(response1.body);
  //     setState(() {
  //       loader=false;
  //       templeList=[];
  //       templeList = mapresponse!['data'];
  //     });

  //     return mapresponse;
  //   } else {
  //       setState(() {
  //     loader=false;
  //   });
  //     print(response1.statusCode);
  //     print('fetch unsuccessful');
  //     print(response1.body);
  //   }
  // }
 

//  Future _searchapicall(String search) async {
//     setState(() {
//       loader=true;
//     });
//     final SharedPreferences sharedPreferences =
//         await SharedPreferences.getInstance();
//     var token = sharedPreferences.getString("token");
//     var priestid = sharedPreferences.getInt("priest_id");
//     http.Response response1;

//     response1 = await http.get(
//       Uri.parse(
//           "https://${AppConstants.ipaddress.ipaddress}/api/temples?pageIndex=0&pageSize=20&search=$search&sortBy=name&sortOrder=DESC"),
//       headers: {
//         "accept": "*/*",
//         "Content-Type": "application/json",
//         "Authorization": "Bearer $token"
//       },
//     );
//     if (response1.statusCode == 200) {
//       print('successful');
//       print(response1.body);
//       mapresponse = json.decode(response1.body);
//       setState(() {
//         loader=false;
//         templeList=[];
//         templeList = mapresponse!['data'];
//       });

//       return mapresponse;
//     } else {
//         setState(() {
//       loader=false;
//     });
//       print(response1.statusCode);
//       print('fetch unsuccessful');
//       print(response1.body);
//     }
//   }
  @override
  void dispose() {
    super.dispose();
  }
  bool loader=false;
 var flow = Get.arguments;
 TextEditingController searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xFFFFF7EA),
           automaticallyImplyLeading: false,
            leading:FlutterFlowIconButton(
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
            'Pravachanam',
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
        body: SafeArea(
          top: true,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: ModalProgressHUD(
               inAsyncCall: loader,
          progressIndicator: CircularProgressIndicator(
            color: Color.fromARGB(255, 214, 98, 35),
          ),
              child: Padding(
               padding: const EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 15.0, 10.0),
                child: ListView(
                    // shrinkWrap: true,
                    // physics: const BouncingScrollPhysics(),
                    // itemCount: templeList.length,
                    // itemBuilder: (BuildContext context, int index) =>
                      
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 10.0, 0.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  SizedBox(
                                    height: screensize.height * 0.13,
                                    width: screensize.width * 0.26,
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(15),
                                      child: 
                                     Image.network(
                                        "https://yt3.googleusercontent.com/ytc/AIdro_nKTFb81hssbUfVziNrcNj309ODR22MPQY9u81zniyBGbc=s160-c-k-c0x00ffffff-no-rj" ,
                                        fit: BoxFit.fill,
                                      )
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        15.0, 0.0, 0.0, 0.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: screensize.width * 0.622,
                                          child: Text(
                                            "Sri Garikipati Narasimha Rao",
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
                                        // SizedBox(
                                        //         width:
                                        //             screensize.width * 0.6,
                                        //         child: GestureDetector(
                                        //           onTap: () {
                                        //             launchURL(
                                        //                 "https://youtube.com/@garikipati_offl?si=OSqMXF9_-8SOHgDQ");
                                        //           },
                                        //           child: Text(
                                        //             "https://youtube.com/@garikipati_offl?si=OSqMXF9_-8SOHgDQ",
                                        //             // overflow: TextOverflow.ellipsis,
                                        //             style: FlutterFlowTheme
                                        //                     .of(context)
                                        //                 .bodyMedium
                                        //                 .override(
                                        //                   color:
                                        //                       Colors.blue,
                                        //                   fontFamily:
                                        //                       'Inter',
                                        //                   fontSize: 12.0,
                                        //                   letterSpacing:
                                        //                       0.0,
                                        //                   fontWeight:
                                        //                       FontWeight
                                        //                           .w300,
                                        //                 ),
                                        //           ),
                                        //         ),
                                        //       ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
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
                                      "https://youtube.com/@garikipati_offl?si=OSqMXF9_-8SOHgDQ");
                                },
                                color: const Color.fromARGB(255, 255, 183, 2),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(10)),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 19),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      Text('Visit',
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
                        const Divider(
                          thickness: 2.0,
                          height: 20,
                          color: Color.fromARGB(146, 220, 220, 220),
                        ),
                         Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 10.0, 0.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  SizedBox(
                                    height: screensize.height * 0.13,
                                    width: screensize.width * 0.26,
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(15),
                                      child: 
                                     Image.network(
                                        "https://yt3.googleusercontent.com/fpVGmXN_pLvWxs1aI6A2CdNV6U_tWN9NWnLqqOhaEzcV8CrKaq3N54EdLMWuyerFKga77AJLNg=s160-c-k-c0x00ffffff-no-rj" ,
                                        fit: BoxFit.fill,
                                      )
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        15.0, 0.0, 0.0, 0.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: screensize.width * 0.622,
                                          child: Text(
                                            "Sri Chaganti Vaani",
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
                                        // SizedBox(
                                        //         width:
                                        //             screensize.width * 0.6,
                                        //         child: GestureDetector(
                                        //           onTap: () {
                                        //             launchURL(
                                        //                 "https://youtube.com/@garikipati_offl?si=OSqMXF9_-8SOHgDQ");
                                        //           },
                                        //           child: Text(
                                        //             "https://youtube.com/@garikipati_offl?si=OSqMXF9_-8SOHgDQ",
                                        //             // overflow: TextOverflow.ellipsis,
                                        //             style: FlutterFlowTheme
                                        //                     .of(context)
                                        //                 .bodyMedium
                                        //                 .override(
                                        //                   color:
                                        //                       Colors.blue,
                                        //                   fontFamily:
                                        //                       'Inter',
                                        //                   fontSize: 12.0,
                                        //                   letterSpacing:
                                        //                       0.0,
                                        //                   fontWeight:
                                        //                       FontWeight
                                        //                           .w300,
                                        //                 ),
                                        //           ),
                                        //         ),
                                        //       ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
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
                                      "https://youtube.com/@srichagantivaani?si=2NON-bTE57SEn8-o");
                                },
                                color: const Color.fromARGB(255, 255, 183, 2),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(10)),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 19),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      Text('Visit',
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
                        const Divider(
                          thickness: 2.0,
                          height: 20,
                          color: Color.fromARGB(146, 220, 220, 220),
                        ),
                         Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 10.0, 0.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  SizedBox(
                                    height: screensize.height * 0.13,
                                    width: screensize.width * 0.26,
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(15),
                                      child: 
                                     Image.network(
                                        "https://yt3.googleusercontent.com/ytc/AIdro_m0Qcqin0gLqsLy0-r74MU9Mg8_s-5ORsgon-pNVVkgb1Q=s160-c-k-c0x00ffffff-no-rj" ,
                                        fit: BoxFit.fill,
                                      )
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        15.0, 0.0, 0.0, 0.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: screensize.width * 0.622,
                                          child: Text(
                                            "Gurudev Sri Sri Ravi Shankar",
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
                                        // SizedBox(
                                        //         width:
                                        //             screensize.width * 0.6,
                                        //         child: GestureDetector(
                                        //           onTap: () {
                                        //             launchURL(
                                        //                 "https://youtube.com/@garikipati_offl?si=OSqMXF9_-8SOHgDQ");
                                        //           },
                                        //           child: Text(
                                        //             "https://youtube.com/@garikipati_offl?si=OSqMXF9_-8SOHgDQ",
                                        //             // overflow: TextOverflow.ellipsis,
                                        //             style: FlutterFlowTheme
                                        //                     .of(context)
                                        //                 .bodyMedium
                                        //                 .override(
                                        //                   color:
                                        //                       Colors.blue,
                                        //                   fontFamily:
                                        //                       'Inter',
                                        //                   fontSize: 12.0,
                                        //                   letterSpacing:
                                        //                       0.0,
                                        //                   fontWeight:
                                        //                       FontWeight
                                        //                           .w300,
                                        //                 ),
                                        //           ),
                                        //         ),
                                        //       ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
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
                                      "https://youtube.com/@gurudev?si=DRQg6zP8dRcO6olO");
                                },
                                color: const Color.fromARGB(255, 255, 183, 2),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(10)),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 19),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      Text('Visit',
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
                        const Divider(
                          thickness: 2.0,
                          height: 20,
                          color: Color.fromARGB(146, 220, 220, 220),
                        ),
                         Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 10.0, 0.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  SizedBox(
                                    height: screensize.height * 0.13,
                                    width: screensize.width * 0.26,
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(15),
                                      child: 
                                     Image.network(
                                        "https://yt3.googleusercontent.com/FqDui8u9mCPqp8thR6CtDOp64MrOJ33VDtAGQsfkvb-DRKm8JDsy6EWzper6XYcaqw2M2iizjFc=s160-c-k-c0x00ffffff-no-rj" ,
                                        fit: BoxFit.fill,
                                      )
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        15.0, 0.0, 0.0, 0.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: screensize.width * 0.622,
                                          child: Text(
                                            "Shri Harivansh Kripa",
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
                                        // SizedBox(
                                        //         width:
                                        //             screensize.width * 0.6,
                                        //         child: GestureDetector(
                                        //           onTap: () {
                                        //             launchURL(
                                        //                 "https://youtube.com/@garikipati_offl?si=OSqMXF9_-8SOHgDQ");
                                        //           },
                                        //           child: Text(
                                        //             "https://youtube.com/@garikipati_offl?si=OSqMXF9_-8SOHgDQ",
                                        //             // overflow: TextOverflow.ellipsis,
                                        //             style: FlutterFlowTheme
                                        //                     .of(context)
                                        //                 .bodyMedium
                                        //                 .override(
                                        //                   color:
                                        //                       Colors.blue,
                                        //                   fontFamily:
                                        //                       'Inter',
                                        //                   fontSize: 12.0,
                                        //                   letterSpacing:
                                        //                       0.0,
                                        //                   fontWeight:
                                        //                       FontWeight
                                        //                           .w300,
                                        //                 ),
                                        //           ),
                                        //         ),
                                        //       ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
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
                                      "https://youtube.com/@shriharivanshkripa-dq3jm?si=rx1ZjfBURrv_2O9L");
                                },
                                color: const Color.fromARGB(255, 255, 183, 2),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(10)),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 19),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      Text('Visit',
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
                        const Divider(
                          thickness: 2.0,
                          height: 20,
                          color: Color.fromARGB(146, 220, 220, 220),
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
