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
import 'poojas_model.dart';
export 'poojas_model.dart';

class priestList {
  priestList({required this.Priestobject, required this.selected});
  Map Priestobject = {};
  bool selected = false;
}

class PoojasWidget extends StatefulWidget {
  const PoojasWidget({super.key});

  @override
  State<PoojasWidget> createState() => _PoojasWidgetState();
}

class _PoojasWidgetState extends State<PoojasWidget> {
  late PoojasModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _apicall();
    _model = createModel(context, () => PoojasModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  List<priestList> ServicesList = List.empty(growable: true);
  List Selected_ServicesList = List.empty(growable: true);
  Map? mapresponse = null;
  Future _apicall() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    var priestid = sharedPreferences.getInt("priest_id");
    http.Response response1;
    response1 = await http.get(
      Uri.parse(
          "https://${AppConstants.ipaddress.ipaddress}/api/services?pageIndex=0&pageSize=200&sortBy=id&sortOrder=DESC&status=1"),
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
        for (int n = 0; n < mapresponse!['data'].length; n++) {
          ServicesList.add(priestList(
              Priestobject: mapresponse!['data'][n], selected: false));
        }
      });

      return mapresponse;
    } else {
      print('fetch unsuccessful');
      print(response1.body);
    }
  }

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
              if (Selected_ServicesList.length>0) {
                Get.to(PriestsWidget(), arguments: Selected_ServicesList);
              }
            },
            label: Container(
              width: screensize.width * 0.8,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Continue',
                  style: FlutterFlowTheme.of(context).titleLarge.override(
                        fontFamily: 'Inter Tight',
                        color: Selected_ServicesList.length == 0
                            ? Color.fromARGB(255, 209, 209, 209)
                            : Color(0xFFD66223),
                        fontSize: 16.0,
                        letterSpacing: 0.0,
                      ),
                ),
              ),
            ),
            backgroundColor: Color(0xFFFFF6EA),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                    width: 2,
                    color: Selected_ServicesList.length == 0
                        ? Color.fromARGB(255, 209, 209, 209)
                        : Color(0xFFD66223))),
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
              'Poojas',
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
          body: Container(
            height: remainingHeight,
            child: SingleChildScrollView(
              child: ListView.builder(
                padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 60.0),
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: ServicesList.length,
                itemBuilder: (BuildContext context, int index) => Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    width: double.infinity,
                    height: screensize.height * 0.13,
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
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          10.0, 10.0, 10.0, 10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image.asset(
                                  'assets/images/poojas_placeholder.png',
                                  width: 80.0,
                                  fit: BoxFit.fill,
                                  alignment: Alignment(0.0, 0.0),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 0.0, 0.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Align(
                                      alignment:
                                          AlignmentDirectional(-1.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 0.0),
                                        child: Container(
                                          width: screensize.width * 0.63,
                                          child: Text(
                                            ServicesList[index]
                                                .Priestobject['name'],
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
                                                  fontWeight: FontWeight.normal,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: screensize.width * 0.63,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          FFButtonWidget(
                                            onPressed: () {
                                              setState(() {
                                                ServicesList[index].selected =
                                                    !ServicesList[index]
                                                        .selected;
                                                if (Selected_ServicesList
                                                        .length >
                                                    0) {
                                                  print("---0");
                                                  if (ServicesList[index]
                                                          .selected ==
                                                      false) {
                                                    print("-----0");
                                                    for (int n = 0;
                                                        n <
                                                            Selected_ServicesList
                                                                .length;
                                                        n++) {
                                                      print("-----00");
                                                      if (ServicesList[index]
                                                              .Priestobject ==
                                                          Selected_ServicesList[
                                                              n]) {
                                                        Selected_ServicesList
                                                            .removeAt(n);
                                                      }
                                                    }
                                                  } else {
                                                    print("-0");
                                                    Selected_ServicesList.add(
                                                        ServicesList[index]
                                                            .Priestobject);
                                                  }
                                                } else {
                                                  print("--0");
                                                  Selected_ServicesList.add(
                                                      ServicesList[index]
                                                          .Priestobject);
                                                }

                                                print(
                                                    "Selected service list ${Selected_ServicesList.length} $Selected_ServicesList");
                                              });

                                              //  Get.to(PriestsWidget(),arguments: ServicesList[index]);
                                            },
                                            text: ServicesList[index].selected
                                                ? 'Remove'
                                                : 'Add',
                                            options: FFButtonOptions(
                                              height: 40.0,
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      20.0, 0.0, 20.0, 0.0),
                                              iconPadding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              color:
                                                  ServicesList[index].selected
                                                      ? Color(0xFFD66223)
                                                      : Color(0xFFFFF6EA),
                                              textStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .titleSmall
                                                  .override(
                                                    fontFamily: 'Inter Tight',
                                                    color: ServicesList[index]
                                                            .selected
                                                        ? Color(0xFFFFF6EA)
                                                        : Color(0xFFD66223),
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                  ),
                                              elevation: 0.0,
                                              borderSide: BorderSide(
                                                color: Color(0xFFD66223),
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
      ),
    );
  }
}
