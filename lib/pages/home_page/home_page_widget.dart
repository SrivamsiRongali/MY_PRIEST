// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:my_priest/pages/Temples.dart';
import 'package:my_priest/pages/my_bookings/Mybookings.dart';
import 'package:my_priest/shared.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../alertdialog.dart';
import '../poojas/poojas_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

class bookedserviceList {
  bookedserviceList({required this.bookedserviceobject, required this.bookingDate});
  Map bookedserviceobject = {};
  String bookingDate = "";
}
class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());
    _apicall();
    currentPosition();
  }
  bool loader = false;
     List listresponse=[];
   List<bookedserviceList> bookingslist=List.empty(growable: true);
   String username = "";
   _apicall() async {
    setState(() {
      loader=true;
    });
   
    Map mapresponse;
    http.Response response1;
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    var userid = sharedPreferences.getInt("userid");
    var name =  sharedPreferences.getString("name");
    setState(() {
      username=name!;
    });
    response1 = await http.get(
      Uri.parse(
          "https://${AppConstants.ipaddress.ipaddress}/api/bookings?bookingStatus=Booked&pageIndex=0&pageSize=4&sortBy=bookingDate&sortOrder=ASC&userId=$userid"),
      headers: {
        "accept": "*/*",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    if (response1.statusCode == 200) {
      setState(() {
        loader=false;
     
      print('successful');
      mapresponse = json.decode(response1.body);
      listresponse = mapresponse['data'];
      for(int n =0; n<listresponse.length;n++){
        for(int i=0;i<listresponse[n]['bookingServiceResponse'].length;i++){
          bookingslist.add(bookedserviceList(bookedserviceobject: listresponse[n]['bookingServiceResponse'][i], bookingDate: listresponse[n]['bookingDate']));
        }
      }
       });
      print("my bookings response $listresponse");
            // for(int n=0; n < listresponse.length ; n++){
      //   expandlist.add(false);
      // }
       currentPosition();
      return listresponse;
    } else {
      setState(() {
        loader=false;
      });
      print('fetch unsuccessful');
    }
  }



     Future<Position> currentPosition() async {
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
        Position position = await Geolocator.getCurrentPosition();
    print(position.latitude);
    _panchangapicall(DateTime.now(),position.latitude,position.longitude);
    }

    // Handling the case where permission is permanently denied
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    // Getting the current position of the user
    Position position = await Geolocator.getCurrentPosition();
    print(position.latitude);
    _panchangapicall(DateTime.now(),position.latitude,position.longitude);
    return position;
  }

  Map panchangresponse={};
  _panchangapicall(DateTime date,double lat, double long) async {
    setState(() {
      loader=true;
    });
   
    Map mapresponse;
    http.Response response1;
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    var userid = sharedPreferences.getInt("userid");
    var name =  sharedPreferences.getString("name");
    print("https://${AppConstants.ipaddress.ipaddress}/api/prokerala/panchang?ayanamsa=1&datetime=${DateFormat("y-MM-ddTHH%3Amm%3Ass").format(DateTime.now())}%2B00%3A00&language=en&latitude=$lat&longitude=$long");
    response1 = await http.get(
      Uri.parse(
          "https://${AppConstants.ipaddress.ipaddress}/api/prokerala/panchang?ayanamsa=1&datetime=${DateFormat("y-MM-ddTHH%3Amm%3Ass").format(DateTime.now())}%2B00%3A00&language=en&latitude=$lat&longitude=$long"),
      headers: {
        "accept": "*/*",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    if (response1.statusCode == 200) {
      setState(() {
        loader=false;
     
      print('successful');
      mapresponse = json.decode(response1.body);
      panchangresponse = mapresponse['data'];
      
       });
      print("my panchang response $panchangresponse");
            // for(int n=0; n < listresponse.length ; n++){
      //   expandlist.add(false);
      // }
      return panchangresponse;
    } else {
      setState(() {
        loader=false;
      });
      print('fetch unsuccessful');
    }
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
        final screenheight = MediaQuery.of(context).size.height;
      final screesize = MediaQuery.of(context).size;
    final screenwidth = MediaQuery.of(context).size.width;
double statusBarHeight = MediaQuery.of(context).padding.top;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor:Color(0xFFFEF2DA),
           extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
        
          ),
          body: Container(
            decoration: BoxDecoration(
              color: Color(0xFFFEF2DA),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Container(
                      width: double.infinity,
                      
                      decoration: BoxDecoration(
                        color: Color(0xFFFEF2DA),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 30.0, 0.0, 23.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: SvgPicture.asset(
                                'images/Priest Services Logo SVG.svg',
                                fit: BoxFit.cover,
                                height: 90,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      width: double.infinity,
                     
                      decoration: BoxDecoration(
                        color: Color(0xFFFEF2DA),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(15.0, 25.0, 15.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome $username',
                              style:
                                  FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Inter',
                                        color: Color(0xFFC80431),
                                        fontSize: 24.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 10.0, 0.0, 15.0),
                              child: Text(
                                'Welcome to My Priest, Please select from below to start searching',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      color: Colors.black,
                                      letterSpacing: 0.0,
                                      lineHeight: 1.2,
                                    ),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    'assets/images/Frame.png',
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top :10,bottom: 10),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                10.0, 0.0, 10.0, 0.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.asset(
                                                'assets/images/Group_(2).png',
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        panchangresponse['tithi']==null? Container() :  SizedBox(
                                            width: screenwidth*0.6,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(3.0),
                                                  child: Text(
                                                    DateFormat("dd, MMMM y - EEEE").format(DateTime.now()),
                                                    style: FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Montserrat',
                                                          color: Color(0xFFFD642A),
                                                          fontSize: 14.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(3.0),
                                                  child: RichText(
                                                    textScaler:
                                                        MediaQuery.of(context).textScaler,
                                                    text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: 'Tithi: ',
                                                          style:
                                                              FlutterFlowTheme.of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    color: Colors.black,
                                                                    fontFamily: 'Inter',
                                                                    letterSpacing: 0.0,
                                                                    fontWeight:
                                                                        FontWeight.bold,
                                                                  ),
                                                        ),
                                                        TextSpan(
                                                          text: panchangresponse['tithi']==null? "" :panchangresponse['tithi'][0]['name'],
                                                          style: FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  color: Colors.black,
                                                                  fontFamily: 'Inter',
                                                                  letterSpacing: 0.0,
                                                                )
                                                        ),
                                                        TextSpan(
                                                          text: ' till ${DateFormat("hh:mm").format(DateTime.parse(panchangresponse['tithi']==null? "${DateTime.now()}" :panchangresponse['tithi'][0]['end'].toString()))}',
                                                          style: FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  color: Colors.black,
                                                                  fontFamily: 'Inter',
                                                                  letterSpacing: 0.0,
                                                                )
                                                        )
                                                      ],
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
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(3.0),
                                                  child: RichText(
                                                    textScaler:
                                                        MediaQuery.of(context).textScaler,
                                                    text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: 'Nakshatra:  ',
                                                          style:
                                                              FlutterFlowTheme.of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    color: Colors.black,
                                                                    fontFamily: 'Inter',
                                                                    letterSpacing: 0.0,
                                                                    fontWeight:
                                                                        FontWeight.bold,
                                                                  ),
                                                        ),
                                                        TextSpan(
                                                            text: panchangresponse['nakshatra']==null? "" :panchangresponse['nakshatra'][0]['name'],
                                                            style: FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  color: Colors.black,
                                                                  fontFamily: 'Inter',
                                                                  letterSpacing: 0.0,
                                                                )
                                                                
                                                                ),
                                                        TextSpan(
                                                          text: ' till ${DateFormat("hh:mm").format(DateTime.parse(panchangresponse['nakshatra']==null? "${DateTime.now()}" :panchangresponse['nakshatra'][0]['end'].toString()))}',
                                                          style: FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  color: Colors.black,
                                                                  fontFamily: 'Inter',
                                                                  letterSpacing: 0.0,
                                                                )
                                                        )
                                                      ],
                                                      style: FlutterFlowTheme.of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily: 'Inter',
                                                            fontSize: 12.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight: FontWeight.normal,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                                // Padding(
                                                //   padding: const EdgeInsets.all(3.0),
                                                //   child: RichText(
                                                //     textScaler:
                                                //         MediaQuery.of(context).textScaler,
                                                //     text: TextSpan(
                                                //       children: [
                                                //         TextSpan(
                                                //             text: 'Visistatha: ',
                                                //             style: FlutterFlowTheme.of(
                                                //                     context)
                                                //                 .bodyMedium
                                                //                 .override(
                                                //                   color: Colors.black,
                                                //                   fontFamily: 'Inter',
                                                //                   letterSpacing: 0.0,
                                                //                   fontWeight:
                                                //                       FontWeight.bold,
                                                //                 )),
                                                //         TextSpan(
                                                //             text: 'Anantha Chaturdasi',
                                                //             style: FlutterFlowTheme.of(
                                                //                     context)
                                                //                 .bodyMedium
                                                //                 .override(
                                                //                   color: Colors.black,
                                                //                   fontFamily: 'Inter',
                                                //                   letterSpacing: 0.0,
                                                //                 )),
                                                //         TextSpan(
                                                //           text: '',
                                                //           style: GoogleFonts.getFont(
                                                //             'Inter',
                                                //             color: Colors.black,
                                                //             fontWeight: FontWeight.w500,
                                                //           ),
                                                //         )
                                                //       ],
                                                //       style: FlutterFlowTheme.of(context)
                                                //           .bodyMedium
                                                //           .override(
                                                //             fontFamily: 'Inter',
                                                //             fontSize: 12.0,
                                                //             letterSpacing: 0.0,
                                                //             fontWeight: FontWeight.normal,
                                                //           ),
                                                //     ),
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    'assets/images/border-art.png',
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 20.0, 0.0, 20.0),
                                    child: GestureDetector(onTap: () {
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
                                          borderRadius: BorderRadius.circular(24.0),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              10.0, 10.0, 10.0, 10.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(6.0),
                                                child: Image.asset(
                                                  'assets/images/ganesh_(1).png',
                                                  fit: BoxFit.fitHeight,
                                                  alignment: Alignment(0.0, 0.0),
                                                ),
                                              ),
                                              Container(
                                                height: 10.0,
                                              ),
                                              Text(
                                                'Book a Pooja',
                                                style: FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0xFFFD642A),
                                                      fontSize: 12.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 10.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(TemplesWidget(),arguments: true);
                    //                    showDialog(
                                 
                    //           context: context,
                    //           builder: (BuildContext context) {
                    //             return popup(
                    //                 onPressed: () {
                    // Navigator.pop(context);
                    //                 },
                    //                 content: "Coming soon", buttontext: 'Ok',);
                    //           },
                    //         );
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
                                        borderRadius: BorderRadius.circular(24.0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10.0, 10.0, 10.0, 10.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.asset(
                                                'assets/images/ganesh.png',
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            Container(
                                              height: 10.0,
                                            ),
                                            Text(
                                              'Temples around you',
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Color(0xFFFD642A),
                                                    fontSize: 12.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
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
                            GestureDetector(
                              onTap: () {
                                Get.to(mybookings(),arguments: true);
                              },
                              child: Container(
                                
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ClipRRect(
                                      
                                      child: Image.asset(
                                        'assets/images/Frame.png',
                                       
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        width: 340.0,
                                        
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsetsDirectional.fromSTEB(
                                                          10.0, 10.0, 10.0, 10.0),
                                                  child: Text(
                                                    'Upcoming',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Montserrat',
                                                          color: Color(0xFFFD642A),
                                                          fontSize: 14.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            bookingslist.isEmpty? Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(top:10,bottom: 20),
                                                  child: Text(
                                                            "No services booked yet",
                                                            overflow: TextOverflow.ellipsis,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  color:
                                                                      Colors.black,
                                                                  fontFamily:
                                                                      'Inter',
                                                                  fontSize: 12.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                          ),
                                                ),
                                              ],
                                            ):
                                            GridView.builder(
                                              padding: EdgeInsets.all(0),
                                              itemCount: bookingslist.length,
                                                gridDelegate:    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 1.0,
                                        mainAxisSpacing: 1.0,
                                        childAspectRatio: 3.0,
                                      ),
                              
                                      shrinkWrap: true,
                                              itemBuilder: (BuildContext context, int index) => Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 8,left: 8,right: 8),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                   
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        width: screenwidth*0.4,
                                                        child: Text(
                                                          bookingslist[index].bookedserviceobject['serviceResponse']['name'],
                                                          overflow: TextOverflow.ellipsis,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                color:
                                                                    Colors.black,
                                                                fontFamily:
                                                                    'Inter',
                                                                fontSize: 12.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                        ),
                                                      ),
                                                      Text(
                                                        DateFormat('MMMM d, y').format(DateTime.parse(bookingslist[index].bookingDate.toString())) ,
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyMedium
                                                            .override(
                                                              color:
                                                                  Colors.black,
                                                              fontFamily:
                                                                  'Inter',
                                                              fontSize: 12.0,
                                                              letterSpacing:
                                                                  0.0,
                                                            ),
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
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        'assets/images/border-art.png',
                                        
                                        fit: BoxFit.fitHeight,
                                      ),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
