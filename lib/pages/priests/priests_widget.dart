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
import 'priests_model.dart';
export 'priests_model.dart';

class PriestsWidget extends StatefulWidget {
  const PriestsWidget({super.key});

  @override
  State<PriestsWidget> createState() => _PriestsWidgetState();
}

class _PriestsWidgetState extends State<PriestsWidget> {
  late PriestsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _apicall();
    _model = createModel(context, () => PriestsModel());
  }
  var servicedata = Get.arguments;
    List priestList = List.empty(growable: true);
  Map? mapresponse;
  Future _apicall() async {
     setState(() {
      loader=true;
    });
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    var priestid = sharedPreferences.getInt("priest_id");
    http.Response response1;
    List serviceId = [];
    for(int n =0;n<servicedata.length;n++){
      serviceId.add(servicedata[n]['id']);
    }
    var data = jsonEncode(serviceId);
    response1 = await http.post(
      Uri.parse(
          "https://${AppConstants.ipaddress.ipaddress}/api/priest-services/service-ids"),
      headers: {
        "accept": "*/*",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: data
    );
    if (response1.statusCode == 200) {
    
      print('successful');
      // mapresponse = json.decode(response1.body);
      setState(() {
        loader=false;
        priestList = json.decode(response1.body);
      });
      
      return mapresponse;
    } else {
       setState(() {
      loader=false;
    });
      print(response1.statusCode);
      print('fetch unsuccessful');
      print(response1.body);
    }
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }
  bool loader=false;
  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xFFFEF2DA),
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
            'Priests',
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
          child: ModalProgressHUD(
            inAsyncCall: loader,
             progressIndicator: CircularProgressIndicator(
                color: Color.fromARGB(255, 214, 98, 35),
              ),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 15.0, 10.0),
                child: SingleChildScrollView(
                  child: 
                  priestList.isEmpty&&loader==false? 
                  SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: const Center(child: Text("No priest(s) are available for the opted Pooja(s)")),
                  )
                  :
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount:priestList.length,
                    itemBuilder: (BuildContext context, int index) =>
                     Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(50.0),
                                    child: Image.asset(
                                      'assets/images/Mask_Group.png',
                                      width: 100.0,
                                      height: 100.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        15.0, 0.0, 0.0, 0.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          
                                          width: screensize.width*0.622,
                                          child: Text(
                                            priestList[index]['priest']['user']['userName'],
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  color: Colors.black,
                                                  fontFamily: 'Inter',
                                                  fontSize: 18.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                        ),
                                          priestList[index]['priest']['user']['address'].length==0? Container():const SizedBox(height: 5,),
                                       priestList[index]['priest']['user']['address'].length==0? Container(): Text(
                                          priestList[index]['priest']['user']['address'][0]['city']['name']+', '
                                          +priestList[index]['priest']['user']['address'][0]['city']['state']['name']+', '
                                          +priestList[index]['priest']['user']['address'][0]['city']['state']['country']['name'],
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(color: Colors.black,
                                                fontFamily: 'Inter',
                                                fontSize: 12.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w300,
                                              ),
                                        ),const SizedBox(height: 10,),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFF2F3F4),
                                                borderRadius:
                                                    BorderRadius.circular(24.0),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional.fromSTEB(
                                                        15.0, 5.0, 15.0, 5.0),
                                                child: Text(
                                                  'Hindi',
                                                  style:
                                                      FlutterFlowTheme.of(context)
                                                          .bodyMedium
                                                          .override(color: Colors.black,
                                                            fontFamily: 'Inter',
                                                            fontSize: 10.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                          ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 5.0,
                                              decoration: BoxDecoration(
                                                color: FlutterFlowTheme.of(context)
                                                    .secondaryBackground,
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFF2F3F4),
                                                borderRadius:
                                                    BorderRadius.circular(24.0),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional.fromSTEB(
                                                        15.0, 5.0, 15.0, 5.0),
                                                child: Text(
                                                  'Telugu',
                                                  style:
                                                      FlutterFlowTheme.of(context)
                                                          .bodyMedium
                                                          .override(color: Colors.black,
                                                            fontFamily: 'Inter',
                                                            fontSize: 10.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                          ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      const Icon(
                                        Icons.message,
                                        color: Color(0xFFD66223),
                                        size: 24.0,
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            5.0, 0.0, 0.0, 0.0),
                                        child: Text(
                                          '4',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(color: Colors.black,
                                                fontFamily: 'Inter',
                                                fontSize: 12.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w300,
                                              ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10.0, 0.0, 0.0, 0.0),
                                        child: Icon(
                                          Icons.star_rounded,
                                          color: Color(0xFFD66223),
                                          size: 24.0,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            5.0, 0.0, 0.0, 0.0),
                                        child: Text(
                                          '4.4',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(color: Colors.black,
                                                fontFamily: 'Inter',
                                                fontSize: 12.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w300,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Flexible(
                                    child: FFButtonWidget(
                                      onPressed: () {
                                       
                                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              scrollable: true,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  backgroundColor:Colors.white,
                  surfaceTintColor: Colors.white,
                  actions: [Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              FFButtonWidget(
                                      onPressed: () {
                                         Get.to(const ConfirmationWidget(),arguments: [servicedata,priestList[index]]);
                                      },
                                      text: 'Continue',
                                      options: FFButtonOptions(
                                        height: 60.0,
                                        width: screensize.width*0.7,
                                      
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            20.0, 20.0, 20.0, 20.0),
                                        iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 0.0),
                                        color: const Color(0xFFFFF6EA),
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Inter Tight',
                                              color: const Color(0xFFD66223),
                                              fontSize: 14.0,
                                              letterSpacing: 0.0,
                                            ),
                                        elevation: 0.0,
                                        borderSide: const BorderSide(
                                          color: Color(0xFFD66223),
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                    ),
                             
                             
                            ],
                          ),
                        ),],
                  content:  SizedBox(
                    height: screensize.height*0.425,
                    width: screensize.width*0.8,
                    child: Column(
                      
                        children: [
                          Padding(
                            padding:
                                const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50.0),
                                      child: Image.asset(
                                        'assets/images/Mask_Group.png',
                                        width: 75.0,
                                        height: 75.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          15.0, 0.0, 0.0, 0.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            
                                            width: screensize.width*0.4,
                                            child: Text(
                                              priestList[index]['priest']['user']['userName'],
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
                                          ),
                                          const SizedBox(height: 5,),
                                         priestList[index]['priest']['user']['address'].length==0?Container():  SizedBox(
                                            width: screensize.width*0.4,
                                            child: Text(
                                              priestList[index]['priest']['user']['address'][0]['city']['name']+', '
                                              +priestList[index]['priest']['user']['address'][0]['city']['state']['name']+', '
                                              +priestList[index]['priest']['user']['address'][0]['city']['state']['country']['name'],
                                               maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(color: Colors.black,
                                                    fontFamily: 'Inter',
                                                    fontSize: 12.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                            ),
                                          ),const SizedBox(height: 10,),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: const Color(0xFFF2F3F4),
                                                  borderRadius:
                                                      BorderRadius.circular(24.0),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional.fromSTEB(
                                                          15.0, 5.0, 15.0, 5.0),
                                                  child: Text(
                                                    'Hindi',
                                                    style:
                                                        FlutterFlowTheme.of(context)
                                                            .bodyMedium
                                                            .override(color: Colors.black,
                                                              fontFamily: 'Inter',
                                                              fontSize: 10.0,
                                                              letterSpacing: 0.0,
                                                              fontWeight:
                                                                  FontWeight.w300,
                                                            ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 5.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: const Color(0xFFF2F3F4),
                                                  borderRadius:
                                                      BorderRadius.circular(24.0),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional.fromSTEB(
                                                          15.0, 5.0, 15.0, 5.0),
                                                  child: Text(
                                                    'Telugu',
                                                    style:
                                                        FlutterFlowTheme.of(context)
                                                            .bodyMedium
                                                            .override(color: Colors.black,
                                                              fontFamily: 'Inter',
                                                              fontSize: 10.0,
                                                              letterSpacing: 0.0,
                                                              fontWeight:
                                                                  FontWeight.w300,
                                                            ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        const Icon(
                                          Icons.message,
                                          color: Color(0xFFD66223),
                                          size: 24.0,
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                              5.0, 0.0, 0.0, 0.0),
                                          child: Text(
                                            '4',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(color: Colors.black,
                                                  fontFamily: 'Inter',
                                                  fontSize: 12.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              10.0, 0.0, 0.0, 0.0),
                                          child: Icon(
                                            Icons.star_rounded,
                                            color: Color(0xFFD66223),
                                            size: 24.0,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                              5.0, 0.0, 0.0, 0.0),
                                          child: Text(
                                            '4.4',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(color: Colors.black,
                                                  fontFamily: 'Inter',
                                                  fontSize: 12.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            thickness: 2.0,
                            height: 20,
                            color:Color.fromARGB(146, 220, 220, 220),
                          ),
                           Row(
                             children: [
                               Text(
                                    'Specialities',
                                    style:
                                        FlutterFlowTheme.of(context).bodyMedium.override(
                                              fontFamily: 'Inter',
                                              color: const Color(0xFFC80431),
                                              fontSize: 16.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                  ),
                             ],
                           ),
                          
                         SizedBox(
                          height: screensize.height*0.2,
                          width: screensize.width*0.7,
                           child: SingleChildScrollView(
                             child: ListView.builder(
                              itemCount:priestList[index]['priest']['priestServices'].length ,
                              
                                     shrinkWrap: true,
                                     physics: const BouncingScrollPhysics(),
                               itemBuilder: (BuildContext context, int index2) => Padding(
                                 padding: const EdgeInsets.all(5.0),
                                 child: Container(
                                                     // width: 300.0,
                                                     // height: 100.0,
                                                     decoration: BoxDecoration(
                                                       color: const Color(0xFFF2F3F4),
                                                       borderRadius: BorderRadius.circular(20.0),
                                                      
                                                     ),
                                                     child: Padding(
                                                       padding: const EdgeInsetsDirectional.fromSTEB(
                                    10.0, 5.0, 10.0, 5.0),
                                                       child: Text(
                                                   "${priestList[index]['priest']['priestServices'][index2]['services']['name']}",
                                  textAlign: TextAlign.center,
                                  
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w300
                                  ),
                                                       ),
                                                     ),
                                                   ),
                               ),
                             ),
                           ),
                         ),
                        ],
                      ),
                  ),
                  
                  
                  
                  
                 
                );
                          },
                        );
                                        // Get.to(ConfirmationWidget(),arguments: [servicedata,priestList[index]]);
                                       
                                      },
                                      text: 'Select',
                                      options: FFButtonOptions(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            30.0, 20.0, 30.0, 20.0),
                                        iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 0.0),
                                        color: const Color(0xFFFFF6EA),
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Inter Tight',
                                              color: const Color(0xFFD66223),
                                              fontSize: 14.0,
                                              letterSpacing: 0.0,
                                            ),
                                        elevation: 0.0,
                                        borderSide: const BorderSide(
                                          color: Color(0xFFD66223),
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 2.0,
                          height: 20,
                          color:Color.fromARGB(146, 220, 220, 220),
                        ),
                      
                      ],
                    ),
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
