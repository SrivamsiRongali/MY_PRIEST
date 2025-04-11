// ignore_for_file: prefer_const_constructors

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_priest/index.dart';
import 'package:my_priest/pages/catering.dart';
import 'package:my_priest/pages/flowerdecor.dart';
import 'package:my_priest/pages/poojaitem.dart';
import 'package:my_priest/pages/pravachanam.dart';

import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'services_model.dart';
export 'services_model.dart';

class ServicesWidget extends StatefulWidget {
  const ServicesWidget({super.key});

  @override
  State<ServicesWidget> createState() => _ServicesWidgetState();
}

class _ServicesWidgetState extends State<ServicesWidget> {
  late ServicesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ServicesModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          key: scaffoldKey,
        
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Color(0xFFFEF2DA),
          
          ),
          backgroundColor:Colors.white,
          body: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                 Container(
                   width: double.infinity,
                   
                   decoration: BoxDecoration(
                     color: Color(0xFFFEF2DA),
                   ),
                   child: Column(
                     mainAxisSize: MainAxisSize.max,
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       Padding(
                         padding: EdgeInsetsDirectional.fromSTEB(
                             0.0, 3.0, 0.0, 23.0),
                         child: ClipRRect(
                           borderRadius: BorderRadius.circular(8.0),
                           child:SvgPicture.asset(
                                'images/Priest Services Logo SVG.svg',
                                fit: BoxFit.cover,
                                height: 90,
                              ),
                         ),
                       ),
                     ],
                   ),
                 ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: SizedBox(
                      width: double.infinity,
                     
                      
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Services',
                              style:
                                  FlutterFlowTheme.of(context).bodyMedium.override(
                                    color: Colors.black,
                                        fontFamily: 'Inter',
                                        fontSize: 24.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 10.0, 0.0, 0.0),
                              child: Text(
                                'Currently available Services',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(color: Colors.black,
                                      fontFamily: 'Inter',
                                      fontSize: 12.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5.0, 10.0, 5.0, 20.0),
                                    child: GestureDetector(
                                      onTap: () {
                                         Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PoojasWidget()));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 4.0,
                                              color: Color(0x33000000),
                                              offset: Offset(
                                                0.0,
                                                2.0,
                                              ),
                                            )
                                          ],
                                          borderRadius: BorderRadius.circular(12.0),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              5.0, 10.0, 5.0, 10.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(6.0),
                                                child: Image.asset(
                                                  'assets/images/ganesh_(2).png',
                                                  fit: BoxFit.fitHeight,
                                                  alignment: Alignment(0.0, 0.0),
                                                ),
                                              ),
                                              Container(
                                                height: 10.0,
                                                
                                              ),
                                              Text(
                                                'Book a Pooja',
                                                textAlign: TextAlign.center,
                                                maxLines: 2,
                                                style: FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0xFFFD642A),
                                                      fontSize: 10.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5.0, 10.0, 5.0, 20.0),
                                    child: GestureDetector(
                                      onTap: () {
                                     Get.to(pravachanamWidget());
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 4.0,
                                              color: Color(0x33000000),
                                              offset: Offset(
                                                0.0,
                                                2.0,
                                              ),
                                            )
                                          ],
                                          borderRadius: BorderRadius.circular(12.0),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              5.0, 10.0, 5.0, 10.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(6.0),
                                                child: Image.asset(
                                                  'assets/images/image_(1).png',
                                                  fit: BoxFit.fitHeight,
                                                  alignment: Alignment(0.0, 0.0),
                                                ),
                                              ),
                                              Container(
                                                height: 10.0,
                                                
                                              ),
                                              Text(
                                                'Pravachanam',
                                                textAlign: TextAlign.center,
                                                maxLines: 2,
                                                style: FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0xFFFD642A),
                                                      fontSize: 10.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                  Expanded(
                                    child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5.0, 10.0, 5.0, 20.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(flowerdecorWidget());
                                            // Get.defaultDialog(
                                            //         title: "",
                                            //         content: Text("Coming soon"),
                                            //         actions: [
                                            //           MaterialButton(
                                            //             onPressed: () {
                                            //               Get.back();
                                            //             },
                                            //             child: Text("Ok"),
                                            //           )
                                            //         ]);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 4.0,
                                              color: Color(0x33000000),
                                              offset: Offset(
                                                0.0,
                                                2.0,
                                              ),
                                            )
                                          ],
                                          borderRadius: BorderRadius.circular(12.0),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              5.0, 10.0, 5.0, 10.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(6.0),
                                                child: Image.asset(
                                                  'assets/images/ganesh_(5).png',
                                                  fit: BoxFit.fitHeight,
                                                  alignment: Alignment(0.0, 0.0),
                                                ),
                                              ),
                                              Container(
                                                height: 10.0,
                                                
                                              ),
                                              Text(
                                                'Flower Decor',
                                                textAlign: TextAlign.center,
                                                maxLines: 2,
                                                style: FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0xFFFD642A),
                                                      fontSize: 10.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                                                    ),
                                  ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5.0, 10.0, 5.0, 20.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(cateringWidget());
                                            // Get.defaultDialog(
                                            //         title: "",
                                            //         content: Text("Coming soon"),
                                            //         actions: [
                                            //           MaterialButton(
                                            //             onPressed: () {
                                            //               Get.back();
                                            //             },
                                            //             child: Text("Ok"),
                                            //           )
                                            //         ]);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 4.0,
                                              color: Color(0x33000000),
                                              offset: Offset(
                                                0.0,
                                                2.0,
                                              ),
                                            )
                                          ],
                                          borderRadius: BorderRadius.circular(12.0),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              5.0, 10.0, 5.0, 10.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(6.0),
                                                child: Image.asset(
                                                  'assets/images/image_(2).png',
                                                  fit: BoxFit.fitHeight,
                                                  alignment: Alignment(0.0, 0.0),
                                                ),
                                              ),
                                              Container(
                                                height: 10.0,
                                                
                                              ),
                                              Text(
                                                'Catering',
                                                textAlign: TextAlign.center,
                                                maxLines: 2,
                                                style: FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0xFFFD642A),
                                                      fontSize: 10.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight: FontWeight.w600,
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
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5.0, 0.0, 5.0, 20.0),
                                  child: GestureDetector(onTap: () {
                                    Get.to(PoojasitemsWidget());
                                  //  Get.defaultDialog(
                                  //               title: "",
                                  //               content: Text("Coming soon"),
                                  //               actions: [
                                  //                 MaterialButton(
                                  //                   onPressed: () {
                                  //                     Get.back();
                                  //                   },
                                  //                   child: Text("Ok"),
                                  //                 )
                                  //               ]);
                                    },
                                    child: Container(
                                   
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 4.0,
                                            color: Color(0x33000000),
                                            offset: Offset(
                                              0.0,
                                              2.0,
                                            ),
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            5.0, 10.0, 5.0, 10.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(6.0),
                                              child: Image.asset(
                                                'assets/images/ganesh_(4).png',
                                                fit: BoxFit.fitHeight,
                                                alignment: Alignment(0.0, 0.0),
                                              ),
                                            ),
                                            Container(
                                              height: 10.0,
                                              
                                            ),
                                            Text(
                                              'Pooja Items',
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Color(0xFFFD642A),
                                                    fontSize: 10.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 10.0, 0.0, 0.0),
                              child: Text(
                                'Upcoming Services',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      fontSize: 12.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5.0, 10.0, 5.0, 20.0),
                                  child: GestureDetector(onTap: () {
                                       Get.defaultDialog(
                                                title: "",
                                                content: Text("Coming soon"),
                                                actions: [
                                                  MaterialButton(
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                    child: Text("Ok"),
                                                  )
                                                ]);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 4.0,
                                            color: Color(0x33000000),
                                            offset: Offset(
                                              0.0,
                                              2.0,
                                            ),
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            5.0, 10.0, 5.0, 10.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(6.0),
                                              child: Image.asset(
                                                'assets/images/ganesh_(6).png',
                                                fit: BoxFit.fitHeight,
                                                alignment: Alignment(0.0, 0.0),
                                              ),
                                            ),
                                            Container(
                                              height: 10.0,
                                              
                                            ),
                                            Text(
                                              'Astrology',
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Color(0xFFFD642A),
                                                    fontSize: 10.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                // Expanded(
                                //   child: Padding(
                                //     padding: EdgeInsetsDirectional.fromSTEB(
                                //         5.0, 10.0, 5.0, 20.0),
                                //     child: Container(
                                //       decoration: BoxDecoration(
                                //         color: Colors.white,
                                //         boxShadow: [
                                //           BoxShadow(
                                //             blurRadius: 4.0,
                                //             color: Color(0x33000000),
                                //             offset: Offset(
                                //               0.0,
                                //               2.0,
                                //             ),
                                //           )
                                //         ],
                                //         borderRadius: BorderRadius.circular(12.0),
                                //       ),
                                //       child: Padding(
                                //         padding: EdgeInsetsDirectional.fromSTEB(
                                //             5.0, 10.0, 5.0, 10.0),
                                //         child: Column(
                                //           mainAxisSize: MainAxisSize.max,
                                //           mainAxisAlignment:
                                //               MainAxisAlignment.spaceEvenly,
                                //           children: [
                                //             ClipRRect(
                                //               borderRadius:
                                //                   BorderRadius.circular(6.0),
                                //               child: Image.asset(
                                //                 'assets/images/ganesh_(6).png',
                                //                 fit: BoxFit.fitHeight,
                                //                 alignment: Alignment(0.0, 0.0),
                                //               ),
                                //             ),
                                //             Container(
                                //               height: 10.0,
                                              
                                //             ),
                                //             Text(
                                //               'Horoscope',
                                //               textAlign: TextAlign.center,
                                //               maxLines: 2,
                                //               style: FlutterFlowTheme.of(context)
                                //                   .bodyMedium
                                //                   .override(
                                //                     fontFamily: 'Montserrat',
                                //                     color: Color(0xFFFD642A),
                                //                     fontSize: 10.0,
                                //                     letterSpacing: 0.0,
                                //                     fontWeight: FontWeight.w600,
                                //                   ),
                                //             ),
                                //           ],
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5.0, 10.0, 5.0, 20.0),
                                  child: GestureDetector(
                                    onTap: () {
                                          Get.defaultDialog(
                                                  title: "",
                                                  content: Text("Coming soon"),
                                                  actions: [
                                                    MaterialButton(
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      child: Text("Ok"),
                                                    )
                                                  ]);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 4.0,
                                            color: Color(0x33000000),
                                            offset: Offset(
                                              0.0,
                                              2.0,
                                            ),
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            5.0, 10.0, 5.0, 10.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(6.0),
                                              child: Image.asset(
                                                'assets/images/ganesh_(4).png',
                                                fit: BoxFit.fitHeight,
                                                alignment: Alignment(0.0, 0.0),
                                              ),
                                            ),
                                            Container(
                                              height: 10.0,
                                              
                                            ),
                                            Text(
                                              'Idols',
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Color(0xFFFD642A),
                                                    fontSize: 10.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
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
    );
  }
}
