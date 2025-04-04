// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:my_priest/alertdialog.dart';
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

class flowerdecorWidget extends StatefulWidget {
  const flowerdecorWidget({super.key});

  @override
  State<flowerdecorWidget> createState() => _flowerdecorWidgetState();
}

class templedetails {
  Map templedata = {};

  Uint8List imageurl =
      Uint8List.fromList([110, 111, 32, 105, 109, 97, 103, 101]);
  templedetails({required this.templedata, required this.imageurl});
}

class _flowerdecorWidgetState extends State<flowerdecorWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // _apicall();

    _configapicall("");
  }

  var servicedata = Get.arguments;

  List templeList = List.empty(growable: true);
  Map? mapresponse;
  // Future _apicall() async {
  //   setState(() {
  //     loader = true;
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
  //       loader = false;
  //       templeList = [];
  //       templeList = mapresponse!['data'];
  //     });

  //     return mapresponse;
  //   } else {
  //     setState(() {
  //       loader = false;
  //     });
  //     print(response1.statusCode);
  //     print('fetch unsuccessful');
  //     print(response1.body);
  //   }
  // }

  Map? configmapresponse;
 _configapicall(String keyword) async {
    setState(() {
      loader = true;
    });
    http.Response response1;

    response1 = await http.get(
      Uri.parse("https://www.indianpriestservices.com/app-config.php"),
      headers: {
        "accept": "*/*",
        "Content-Type": "application/json",
      },
    );
    if (response1.statusCode == 200) {
      print('successful');
      print(response1.body);
      setState(() {
        configmapresponse = json.decode(response1.body);

  

        configmapresponse!['temples_around_me_radius'];
        currentPosition(configmapresponse!['temples_around_me_radius'],keyword);
      });

      return mapresponse;
    } else {
      setState(() {
        loader = false;
      });
      currentPosition(
          configmapresponse == null
              ? 10000
              : configmapresponse!['temples_around_me_radius'],
          keyword);
      print(response1.statusCode);
      print('fetch unsuccessful');
      print(response1.body);
    }
  }

  Future<Position> currentPosition(String radius,String keyword) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Checking if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    // Checking the location permission status
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Requesting permission if it is denied
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    // Handling the case where permission is permanently denied
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    // Getting the current position of the user
    Position position = await Geolocator.getCurrentPosition();
    print(position.latitude);
    _templesbasedonlocationapicall(
        position.latitude, position.longitude, radius,keyword);
    return position;
  }

  List templesresponse = [];
  List<templedetails> finaltemplelist = List.empty(growable: true);

  _templesbasedonlocationapicall(double lat, double long, String radius,String keyword) async {
    setState(() {
      loader = true;
    });

    Map mapresponse;
    http.Response response1;
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    var userid = sharedPreferences.getInt("userid");
    var name = sharedPreferences.getString("name");
    print(
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$long&radius=$radius&keyword=flower+decoration&key=AIzaSyBC_WlEM3KJ0iga1292EjUx6k-Ah_ws5FE");
    response1 = await http.get(
      Uri.parse(
          "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$long&radius=$radius&keyword=flower+decoration&key=AIzaSyBC_WlEM3KJ0iga1292EjUx6k-Ah_ws5FE"),
      headers: {
        "accept": "*/*",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    if (response1.statusCode == 200) {
      setState(() {
        loader = false;
finaltemplelist=[];
        print('successful');
        mapresponse = json.decode(response1.body);
        templesresponse = mapresponse['results'];
        print("total temple response length ${templesresponse.length}");
      });
      for (int n = 0; n < templesresponse.length; n++) {
        finaltemplelist.add(
            templedetails(templedata: templesresponse[n], imageurl: dummyData));
        // print(
        //     "my temples response ${templesresponse[n]['name']}  ${templesresponse[n]['photos'][0]['photo_reference'].toString()}");
        fetchTemplePhoto(
            "${templesresponse[n].containsKey('photos') ? templesresponse[n]['photos'][0]['photo_reference'] : "no image"}",
            templesresponse[n],
            n);
      }

      // for(int n=0; n < listresponse.length ; n++){
      //   expandlist.add(false);
      // }
      return templesresponse;
    } else {
      setState(() {
        loader = false;
      });
      print('fetch unsuccessful');
    }
  }

  Uint8List dummyData =
      Uint8List.fromList([110, 111, 32, 105, 109, 97, 103, 101]);
  fetchTemplePhoto(String photoReference, Map templeobject, int index) async {
    if (photoReference == "no image") {
      finaltemplelist[index].imageurl = dummyData;
      print("no image available");
    } else {
      // Construct the Place Photos endpoint
      final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/photo'
        '?maxwidth=400'
        '&photo_reference=${photoReference}'
        '&key=AIzaSyBC_WlEM3KJ0iga1292EjUx6k-Ah_ws5FE',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        // print("image data ${response.bodyBytes}");
        // `response.bodyBytes` contains raw bytes of the image
        setState(() {
          finaltemplelist[index].imageurl = response.bodyBytes;
        });

        return response.bodyBytes;
      } else {
        throw Exception(
            'Failed to load temple photo. Status code: ${response.statusCode}');
      }
    }
  }

  // Future _searchapicall(String search) async {
  //   setState(() {
  //     loader = true;
  //   });
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   var token = sharedPreferences.getString("token");
  //   var priestid = sharedPreferences.getInt("priest_id");
  //   http.Response response1;

  //   response1 = await http.get(
  //     Uri.parse(
  //         "https://${AppConstants.ipaddress.ipaddress}/api/temples?pageIndex=0&pageSize=20&search=$search&sortBy=name&sortOrder=DESC"),
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
  //       loader = false;
  //       templeList = [];
  //       templeList = mapresponse!['data'];
  //     });

  //     return mapresponse;
  //   } else {
  //     setState(() {
  //       loader = false;
  //     });
  //     print(response1.statusCode);
  //     print('fetch unsuccessful');
  //     print(response1.body);
  //   }
  // }

  @override
  void dispose() {
    super.dispose();
  }

  RangeValues values = RangeValues(5000, 150000);
  RangeLabels labels = RangeLabels('5km', '150km');
 double _discreteValue=5000;

  bool loader = false;
  var flow = Get.arguments;
  // TextEditingController searchcontroller = TextEditingController();
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
          leading: flow == null
              ? Container()
              : FlutterFlowIconButton(
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
            'Flower Decor',
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
          actions: [
            IconButton(
                onPressed: () {
                  
                  showDialog(
        context: context,
        builder: (BuildContext context) {
          return popupwithcustombuttons(
              onPressedforbutton1: () {

                setState(() {
                  _discreteValue=5000;
                });
                 currentPosition(configmapresponse!['temples_around_me_radius'],"");
                 this.setState(() {
                      loader=true;
                    });
              Get.back();},
              onPressedforbutton2: () {currentPosition(_discreteValue.toString(),"");
              this.setState(() {
                _discreteValue=5000;
                      loader=true;
                    });
              Get.back();},
              content: Container(height: 150,
                child: StatefulBuilder(
                  builder: (context, setState) => Container(
                   
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text("Distance",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
                              ],
                            ),
                            SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                               Text("${configmapresponse==null?5000: double.parse(configmapresponse!['temples_around_me_filter_config']['min_radius'])/1000}km",style: TextStyle(fontSize: 10),),
                               Text("${configmapresponse==null?150000:double.parse(configmapresponse!['temples_around_me_filter_config']['max_radius'])/1000}km",style: TextStyle(fontSize: 10),),
                              ],
                            ),
                             Slider(
                  value: _discreteValue,
                  min: configmapresponse==null?5000: double.parse(configmapresponse!['temples_around_me_filter_config']['min_radius']),
                  max: configmapresponse==null?150000:double.parse(configmapresponse!['temples_around_me_filter_config']['max_radius']),
                  divisions: 1000,
                  label: '${_discreteValue.round()}',
                  onChanged: (double value) {
                   setState(() {
                      _discreteValue = value;
                     
                    });
                    
                
                  },
                ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ), title: Text("Filter"), button1label: 'Clear', button2label: 'Apply',);
        });
                },
                icon: Icon(
                  Icons.filter_alt_outlined,
                  color: Colors.black,
                )),
          ],
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    finaltemplelist.isEmpty
                        ? loader
                            ? Container()
                            : SizedBox(
                                height: 200,
                                width: double.infinity,
                                child: const Center(
                                    child: Text(
                                        "No Flower Decor(s) are available near you")),
                              )
                        : Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                15.0, 15.0, 15.0, 10.0),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: finaltemplelist.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
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
                                                child: finaltemplelist[index]
                                                            .imageurl ==
                                                        dummyData
                                                    ? Image.asset(
                                                        'assets/images/ganesh_(5).png',
                                                        // height: screensize.height * 0.13,
                                                        fit: BoxFit.fill,
                                                      )
                                                    : Image.memory(
                                                        finaltemplelist[index]
                                                            .imageurl,
                                                        fit: BoxFit.fill,
                                                      ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      15.0, 0.0, 0.0, 0.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: screensize.width *
                                                        0.622,
                                                    child: Text(
                                                      finaltemplelist[index]
                                                          .templedata['name'],
                                                      // maxLines: 2,
                                                      // overflow: TextOverflow.ellipsis,
                                                      style: FlutterFlowTheme
                                                              .of(context)
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
                                                  SizedBox(
                                                    width:
                                                        screensize.width * 0.6,
                                                    child: Text(
                                                      finaltemplelist[index]
                                                              .templedata[
                                                          'vicinity'],
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
                                                  // templeList[index]
                                                  //             ['website'] ==
                                                  //         null
                                                  //     ? Container()
                                                  //     : const SizedBox(
                                                  //         height: 5,
                                                  //       ),
                                                  // templeList[index]
                                                  //             ['website'] ==
                                                  //         null
                                                  //     ? Container()
                                                  //     : SizedBox(
                                                  //         width:
                                                  //             screensize.width *
                                                  //                 0.6,
                                                  //         child:
                                                  //             GestureDetector(
                                                  //           onTap: () {
                                                  //             launchURL(
                                                  //                 templeList[
                                                  //                         index]
                                                  //                     [
                                                  //                     'website']);
                                                  //           },
                                                  //           child: Text(
                                                  //             templeList[index]
                                                  //                 ['website'],
                                                  //             // overflow: TextOverflow.ellipsis,
                                                  //             style: FlutterFlowTheme
                                                  //                     .of(context)
                                                  //                 .bodyMedium
                                                  //                 .override(
                                                  //                   color: Colors
                                                  //                       .blue,
                                                  //                   fontFamily:
                                                  //                       'Inter',
                                                  //                   fontSize:
                                                  //                       12.0,
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
                                                "https://www.google.com/maps/search/${finaltemplelist[index].templedata['name']},${finaltemplelist[index].templedata['vicinity']}");
                                          },
                                          color: const Color.fromARGB(
                                              255, 255, 183, 2),
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
                                  const Divider(
                                    thickness: 2.0,
                                    height: 20,
                                    color: Color.fromARGB(146, 220, 220, 220),
                                  ),
                                ],
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
