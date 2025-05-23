// ignore_for_file: prefer_const_constructors, prefer_if_null_operators, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../../alertdialog.dart';
import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../main.dart';
import '../../shared.dart';
import '../home_page/home_page_widget.dart';
import 'booking_details_model.dart';

class mybookings extends StatefulWidget {
  const mybookings({super.key});

  @override
  State<mybookings> createState() => _mybookingsState();
}

class _mybookingsState extends State<mybookings> {
  @override
  void initState() {
    super.initState();
    _apicall();
  }

  var flow = Get.arguments;
  List listresponse = [];
  List<bool> expandlist = [];
  List<bookedserviceList> bookingslist = List.empty(growable: true);
  List sharelist = [];
  void shareListToWhatsApp(List items) async {
    
    String listText = items.join("\n");
    Share.share("Here is my list:\n\n$listText");
    // String message = Uri.encodeComponent("Here is my list:\n\n$listText");
    // String url = "https://wa.me/?text=$message";

    // if (await canLaunch(url)) {
    //   await launch(url);
    // } else {
    //   print("Could not open WhatsApp");
    // }
  }

  _apicall() async {
    setState(() {
      loader = true;
    });

    Map mapresponse;
    http.Response response1;
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    var userid = sharedPreferences.getInt("userid");
    response1 = await http.get(
      Uri.parse(
          "https://${AppConstants.ipaddress.ipaddress}/api/bookings?pageIndex=0&pageSize=200&sortBy=id&sortOrder=DESC&userId=$userid"),
      headers: {
        "accept": "*/*",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    if (response1.statusCode == 200) {
      setState(() {
        loader = false;

        print('successful');
        mapresponse = json.decode(response1.body);
        listresponse = mapresponse['data'];
        for (int m = 0; m < listresponse.length; m++) {
          for (int n = 0;
              n < listresponse[m]['bookingServiceResponse'].length;
              n++) {
            listresponse[m]['bookingServiceResponse'][n]['status'] = 1;
          }
        }
      });
      return listresponse;
    } else {
      setState(() {
        loader = false;
      });
      print('fetch unsuccessful');
    }
  }

  TextEditingController datecontroller = TextEditingController();
  TextEditingController timecontroller = TextEditingController();
  String selectedTime = "00:00";
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  _re_shcedule_apicall(
      int id,
      String bookingstatus,
      String description,
      int priestid,
      List servicelist,
      Map address,
      String date,
      String time,
      int index) async {
    setState(() {
      loader = true;
    });

    Map mapresponse;
    http.Response response1;
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    var userid = sharedPreferences.getInt("userid");
    var data = json.encode({
      "address": {
        "addressLine1": address['addressLine1'],
        "addressLine2": address['addressLine2'],
        "addressType": address['addressType'],
        "cityId": address['cityId'],
        "currentLatitude": 0,
        "currentLongitude": 0,
        "description": address['description'],
        "fax": "string",
        "id": address['id'],
        "zip": "string"
      },
      "bookingDate": "${date}T$time:00",
      "bookingStatus": bookingstatus,
      "description": description,
      "priestId": priestid,
      "servicesId": servicelist
    });
    print("for id $id reschedule request object $data");
    response1 = await http.put(
        Uri.parse(
            "https://${AppConstants.ipaddress.ipaddress}/api/bookings/$id"),
        headers: {
          "accept": "*/*",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: data);
    if (response1.statusCode == 200) {
      setState(() {
        loader = false;
        listresponse[index]['bookingDate'] = "${date}T$time:00";
        print('successful');
        mapresponse = json.decode(response1.body);
      });
      Get.defaultDialog(
        title: "",
        titleStyle: TextStyle(color: Colors.red),
        content: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Text("Booking Rescheduled successfully",
              style: TextStyle(color: Colors.black)),
        ),
        actions: [
          MaterialButton(
            color: Color.fromARGB(255, 255, 123, 0),
            onPressed: () {
              Get.back();
            },
            child: Text(
              'ok',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
      return listresponse;
    } else {
      print("response ${response1.body}");
      setState(() {
        loader = false;
      });
      Get.defaultDialog(
        title: "Unable to Rescheduled",
        titleStyle: TextStyle(color: Colors.red),
        content: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Text("Please try after some time",
              style: TextStyle(color: Colors.black)),
        ),
        actions: [
          MaterialButton(
            color: Color.fromARGB(255, 255, 123, 0),
            onPressed: () {
              Get.back();
            },
            child: Text(
              'ok',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
      print('fetch unsuccessful');
    }
  }

  Future updatebookingstatus(int bookingid, int index) async {
    setState(() {
      loader = true;
    });
    // print(" date = ${date}T$time:00.00Z,priest=$priestid,serviceid=$serviceid");
    var data = json
        .encode({"bookingStatus": "Cancelled", "paymentReference": "string"});
    print("booking object $data");
    Map mapresponse;
    Map mapresponse2;
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    var token = sharedPreferences.getString("token");
    http.Response response = await http.put(
        Uri.parse(
            "https://${AppConstants.ipaddress.ipaddress}/api/bookings/payment/$bookingid"),
        headers: {
          "accept": "*/*",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: data);

    if (response.statusCode == 200) {
      mapresponse = json.decode(response.body);

      setState(() {
        loader = false;
        listresponse[index]['bookingStatus'] = "Cancelled";
      });
      Get.defaultDialog(
        title: "",
        titleStyle: TextStyle(color: Colors.red),
        content: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Text("Booking canceled successfully",
              style: TextStyle(color: Colors.black)),
        ),
        actions: [
          MaterialButton(
            color: Color.fromARGB(255, 255, 123, 0),
            onPressed: () {
              Get.back();
            },
            child: Text(
              'ok',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
      print('Booking status updated successfully');

      print(response.body);
    } else {
      setState(() {
        loader = false;
      });

      print(" data =$data");
      print('fail');
      Get.defaultDialog(
        title: "Unable to update payment status",
        titleStyle: TextStyle(color: Colors.red),
        content: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Text("Please try after some time",
              style: TextStyle(color: Colors.black)),
        ),
        actions: [
          MaterialButton(
            color: Color.fromARGB(255, 255, 123, 0),
            onPressed: () {
              Get.back();
            },
            child: Text(
              'ok',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
      print(response.statusCode);
      print(response.body);
    }
  }

  bool loader = false;
  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        if (flow) {
          Get.offAll(NavBarPage());
        } else {
          Get.back();
        }

        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFFEF2DA),
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
              if (flow) {
                Get.offAll(NavBarPage());
              } else {
                Get.back();
              }
            },
          ),
          title: Text(
            'My Bookings',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Inter Tight',
                  color: Color(0xFF1E2022),
                  fontSize: 22.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                ),
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        backgroundColor: Color(0xFFFFF6EA),
        body: ModalProgressHUD(
          inAsyncCall: loader,
          progressIndicator: CircularProgressIndicator(
            color: Color.fromARGB(255, 214, 98, 35),
          ),
          child: Container(
              height: double.infinity,
              width: double.maxFinite,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 249, 249, 249),
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
              child: listresponse.isEmpty && loader == false
                  ? SizedBox(
                      height: 200, child: Center(child: Text("No bookings")))
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                      // addAutomaticKeepAlives: false,
                      itemCount: listresponse.length,

                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Container(
                              //height: 250,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                    )
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20),
                                      bottom: Radius.circular(20))),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(25, 15, 20, 15),
                                child: Column(
                                  children: [
                                    Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 35,
                                                backgroundImage: NetworkImage(listresponse[index]
                                                                        ['priestResponse']
                                                                    ['user'][
                                                                'profileImage'] ==
                                                            null ||
                                                        listresponse[index]
                                                                        ['priestResponse']
                                                                    ['user'][
                                                                'profileImage'] ==
                                                            "string"
                                                    ? "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"
                                                    : listresponse[index]
                                                            ['priestResponse']
                                                        ['user']['profileImage']),
                                              ),
                                              SizedBox(
                                                width: screensize.width * 0.05,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        screensize.width * 0.45,
                                                    child: RichText(
                                                      // overflow: TextOverflow.ellipsis,
                                                      softWrap: true,
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text: listresponse[index]['priestResponse']
                                                                            [
                                                                            'user']
                                                                        [
                                                                        'firstName'] ==
                                                                    null
                                                                ? ""
                                                                : listresponse[index]
                                                                            [
                                                                            'priestResponse']
                                                                        ['user']
                                                                    [
                                                                    'firstName'],
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          TextSpan(
                                                            text: listresponse[index]['priestResponse']
                                                                            [
                                                                            'user']
                                                                        [
                                                                        'middleName'] ==
                                                                    null
                                                                ? ""
                                                                : listresponse[index]
                                                                            [
                                                                            'priestResponse']
                                                                        ['user']
                                                                    [
                                                                    'middleName'],
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          TextSpan(
                                                            text: listresponse[index]['priestResponse']
                                                                            [
                                                                            'user']
                                                                        [
                                                                        'lastName'] ==
                                                                    null
                                                                ? ""
                                                                : listresponse[index]
                                                                            [
                                                                            'priestResponse']
                                                                        ['user']
                                                                    [
                                                                    'lastName'],
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  SizedBox(
                                                    width:
                                                        screensize.width * 0.45,
                                                    child: RichText(
                                                      // overflow: TextOverflow.ellipsis,
                                                      softWrap: true,
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text: listresponse[index]['priestResponse']['user']
                                                                            [
                                                                            'address']
                                                                        .length ==
                                                                    0
                                                                ? ""
                                                                : listresponse[index]['priestResponse']['user']['address'][0]["city"]
                                                                            [
                                                                            "name"] ==
                                                                        null
                                                                    ? ""
                                                                    : "${listresponse[index]['priestResponse']['user']['address'][0]["city"]["name"]},",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                          TextSpan(
                                                            text: listresponse[index]['priestResponse']['user']
                                                                            [
                                                                            'address']
                                                                        .length ==
                                                                    0
                                                                ? ""
                                                                : listresponse[index]['priestResponse']['user']['address'][0]["city"]["state"]
                                                                            [
                                                                            "name"] ==
                                                                        null
                                                                    ? ""
                                                                    : "${listresponse[index]['priestResponse']['user']['address'][0]["city"]["state"]["name"]},",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                          TextSpan(
                                                            text: listresponse[index]['priestResponse']['user']
                                                                            [
                                                                            'address']
                                                                        .length ==
                                                                    0
                                                                ? ""
                                                                : listresponse[index]['priestResponse']['user']['address'][0]["city"]["state"]["country"]
                                                                            [
                                                                            "name"] ==
                                                                        null
                                                                    ? ""
                                                                    : "${listresponse[index]['priestResponse']['user']['address'][0]["city"]["state"]["country"]["name"]},",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    // ignore: prefer_const_literals_to_create_immutables
                                                    children: [
                                                      Container(
                                                        width: 60,
                                                        height: 20,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            color:
                                                                Color.fromARGB(
                                                                    39,
                                                                    255,
                                                                    99,
                                                                    2)),
                                                        child: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            'Telugu',
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        214,
                                                                        98,
                                                                        35),
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      Container(
                                                        width: 60,
                                                        height: 20,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            color:
                                                                Color.fromARGB(
                                                                    39,
                                                                    255,
                                                                    99,
                                                                    2)),
                                                        child: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            'Hindi',
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        214,
                                                                        98,
                                                                        35),
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          // GestureDetector(
                                          //   onTap: () {
                                          //     // Get.to(chat());
                                          //   },
                                          //   child: Container(
                                          //     height: 45,
                                          //     width: 45,
                                          //     decoration: BoxDecoration(
                                          //         color: Color.fromARGB(
                                          //             82, 132, 197, 161),
                                          //         borderRadius:
                                          //             BorderRadius.circular(
                                          //                 100)),
                                          //     child: Padding(
                                          //       padding:
                                          //           const EdgeInsets.all(12.0),
                                          //       child: SvgPicture.asset(
                                          //         'images/Vector (1).svg',
                                          //       ),
                                          //     ),
                                          //   ),
                                          // )
                                        ]),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          // ignore: prefer_const_literals_to_create_immutables
                                          children: [
                                            Container(
                                              child: Text(
                                                "Booking Status",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        ),
                                        listresponse[index]['bookingStatus'] ==
                                                "Booked"
                                            ? SvgPicture.asset(
                                                "images/Group (1).svg",
                                                height: 80,
                                              )
                                            : Container(
                                                height: 25,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    color: listresponse[index][
                                                                    'bookingStatus'] ==
                                                                "Cancelled" ||
                                                            listresponse[index][
                                                                    'bookingStatus'] ==
                                                                "Rejected"
                                                        ? Color.fromARGB(
                                                            255, 215, 27, 27)
                                                        : listresponse[index][
                                                                    'bookingStatus'] ==
                                                                "Accepted"
                                                            ? Colors.green
                                                            : Color.fromARGB(39,
                                                                119, 119, 119)),
                                                child: Center(
                                                    child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10,
                                                          right: 10,
                                                          top: 5,
                                                          bottom: 5),
                                                  child: Text(
                                                    "${listresponse[index]['bookingStatus']}",
                                                    style: TextStyle(
                                                        color: listresponse[index]['bookingStatus'] ==
                                                                "Booked"
                                                            ? Color.fromARGB(
                                                                255, 35, 214, 104)
                                                            : listresponse[index]['bookingStatus'] ==
                                                                        "Cancelled" ||
                                                                    listresponse[index]['bookingStatus'] ==
                                                                        "Rejected"
                                                                ? Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    255)
                                                                : listresponse[index]['bookingStatus'] ==
                                                                        "Accepted"
                                                                    ? Color.fromARGB(
                                                                        255,
                                                                        255,
                                                                        255,
                                                                        255)
                                                                    : Color.fromARGB(
                                                                        255,
                                                                        147,
                                                                        147,
                                                                        147),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                )),
                                              )
                                      ],
                                    ),
                                    listresponse[index]['bookingStatus'] ==
                                            "Initiated"
                                        ? Column(
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                      "You will receive further updates over email"),
                                                ],
                                              ),
                                            ],
                                          )
                                        : Container(),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    ListView.builder(
                                      itemCount: listresponse[index]
                                              ['bookingServiceResponse']
                                          .length,
                                      shrinkWrap: true,
                                      physics: BouncingScrollPhysics(),
                                      itemBuilder:
                                          (BuildContext context, int index2) =>
                                              Column(
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                // ignore: prefer_const_literals_to_create_immutables
                                                children: [
                                                  Icon(
                                                    Icons.check_circle_rounded,
                                                    color: Color.fromARGB(
                                                        255, 214, 98, 35),
                                                    size: 30,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        screensize.width * 0.5,
                                                    child: Text(
                                                      listresponse[index]['bookingServiceResponse']
                                                                          [
                                                                          index2]
                                                                      [
                                                                      'serviceResponse']
                                                                  ['name'] ==
                                                              null
                                                          ? ""
                                                          : listresponse[index][
                                                                          'bookingServiceResponse']
                                                                      [index2][
                                                                  'serviceResponse']
                                                              ['name'],
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                height: 25,
                                                width: 70,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    color: Color.fromARGB(
                                                        39, 255, 99, 2)),
                                                child: Center(
                                                    child: Text(
                                                  " ${NumberFormat.simpleCurrency(locale: "hi-IN", decimalDigits: 2).format(listresponse[index]['bookingServiceResponse'][index2]['serviceResponse']['minPrice'] == null ? "" : listresponse[index]['bookingServiceResponse'][index2]['serviceResponse']['minPrice'])}",
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 214, 98, 35),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Consumer<Servicedetailsdata>(
                                            builder: (BuildContext context,
                                                value, Widget? child) {
                                              // print(
                                              //     "groceries details ${listresponse[index]['bookingServiceResponse'][index2]['servicesId']}");
                                              // value.servicegrocerydetails(
                                              //     listresponse[index][
                                              //             'bookingServiceResponse']
                                              //         [index2]['servicesId']);
                                              return Container(
                                                decoration: BoxDecoration(
                                                    color: Color.fromARGB(
                                                        255, 244, 244, 244),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        child: GestureDetector(
                                                          onTap: () async {
                                                            print(
                                                                "groceries details ${listresponse[index]['bookingServiceResponse'][index2]['servicesId']}");
                                                            if (listresponse[index]
                                                                            [
                                                                            'bookingServiceResponse']
                                                                        [index2]
                                                                    [
                                                                    'status'] ==
                                                                1) {
                                                              Provider.of<Servicedetailsdata>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .groceriesList = [];
                                                              value.servicegrocerydetails(
                                                                  listresponse[index]
                                                                              [
                                                                              'bookingServiceResponse']
                                                                          [
                                                                          index2]
                                                                      [
                                                                      'servicesId']);
                                                            }
                                                            setState(() {
                                                              for (int n = 0;
                                                                  n <
                                                                      listresponse[index]
                                                                              [
                                                                              'bookingServiceResponse']
                                                                          .length;
                                                                  n++) {
                                                                if (n !=
                                                                    index2) {
                                                                  listresponse[
                                                                              index]
                                                                          [
                                                                          'bookingServiceResponse'][n]
                                                                      [
                                                                      'status'] = 1;
                                                                }
                                                              }

                                                              for (int m = 0;
                                                                  m <
                                                                      listresponse
                                                                          .length;
                                                                  m++) {
                                                                for (int n = 0;
                                                                    n <
                                                                        listresponse[m]['bookingServiceResponse']
                                                                            .length;
                                                                    n++) {
                                                                  if (m !=
                                                                      index) {
                                                                    listresponse[m]
                                                                            [
                                                                            'bookingServiceResponse'][n]
                                                                        [
                                                                        'status'] = 1;
                                                                  }
                                                                }
                                                              }

                                                              listresponse[index]['bookingServiceResponse']
                                                                              [
                                                                              index2]
                                                                          [
                                                                          'status'] ==
                                                                      1
                                                                  ? listresponse[index]
                                                                              ['bookingServiceResponse']
                                                                          [index2]['status'] =
                                                                      0
                                                                  : listresponse[index]
                                                                              ['bookingServiceResponse']
                                                                          [
                                                                          index2]
                                                                      [
                                                                      'status'] = 1;
                                                            });
                                                          },
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .feed_outlined,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            214,
                                                                            98,
                                                                            35),
                                                                  ),
                                                                  SizedBox(
                                                                      width:
                                                                          10),
                                                                  Text(
                                                                    listresponse[index]['bookingServiceResponse'][index2]['status'] ==
                                                                            0
                                                                        ? "Pooja items required"
                                                                        : 'View Pooja items required',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            15),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                                width: 20,
                                                                child: listresponse[index]['bookingServiceResponse'][index2]
                                                                            [
                                                                            'status'] ==
                                                                        0
                                                                    ? Image
                                                                        .asset(
                                                                        "images/arrow-up-sign-to-navigate.png",
                                                                      )
                                                                    : Image
                                                                        .asset(
                                                                        "images/arrow-down-sign-to-navigate.png",
                                                                        fit: BoxFit
                                                                            .contain,
                                                                      ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      if (listresponse[index][
                                                                  'bookingServiceResponse']
                                                              [
                                                              index2]['status'] ==
                                                          0)
                                                        //  value.groceriesList.length==0?  Padding(
                                                        //                    padding:
                                                        //         const EdgeInsets
                                                        //             .only(
                                                        //             left: 10,
                                                        //             right: 10,
                                                        //             top: 20),
                                                        //                   child: Container(
                                                        //                     width: screensize
                                                        //                                                                                         .width *
                                                        //                                                                                     0.7,
                                                        //                     child: Center(child: Text("Unavailable"),)),
                                                        //                 ) :
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 5,
                                                                      right: 5,
                                                                      top: 20),
                                                              child: SizedBox(
                                                                width: screensize
                                                                        .width *
                                                                    0.8,
                                                                child: value
                                                                        .groceriesList
                                                                        .isEmpty
                                                                    ? Center(
                                                                        child:
                                                                            CircularProgressIndicator(
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              214,
                                                                              98,
                                                                              35),
                                                                        ),
                                                                      )
                                                                    : Table(
                                                                        border: TableBorder.all(
                                                                            color:
                                                                                Colors.grey,
                                                                            width: 1),
                                                                        columnWidths: const {
                                                                          0: FlexColumnWidth(
                                                                              2), // Name column takes 2x space
                                                                          1: FlexColumnWidth(
                                                                              1), // Quantity column takes 1x space
                                                                        },
                                                                        children: [
                                                                          // Table Header Row
                                                                          const TableRow(
                                                                            children: [
                                                                              Padding(
                                                                                padding: EdgeInsets.all(12),
                                                                                child: Text(
                                                                                  'Grocery Name',
                                                                                  style: TextStyle(
                                                                                    fontWeight: FontWeight.bold,
                                                                                  ),
                                                                                  textAlign: TextAlign.center,
                                                                                ),
                                                                              ),
                                                                              Padding(
                                                                                padding: EdgeInsets.all(12),
                                                                                child: Text(
                                                                                  'Quantity',
                                                                                  style: TextStyle(
                                                                                    fontWeight: FontWeight.bold,
                                                                                  ),
                                                                                  textAlign: TextAlign.center,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          // Loop through grocery data to create table rows
                                                                          ...value
                                                                              .groceriesList
                                                                              .map((grocery) {
                                                                            return TableRow(
                                                                              children: [
                                                                                Padding(
                                                                                  padding: const EdgeInsets.all(12),
                                                                                  child: Text(
                                                                                    grocery['grocery']['name'].toString(),
                                                                                    style: const TextStyle(fontSize: 16),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.all(12),
                                                                                  child: Text(
                                                                                    grocery['quantity'].toString(),
                                                                                    style: const TextStyle(fontSize: 16),
                                                                                    textAlign: TextAlign.center,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            );
                                                                          }).toList(),
                                                                        ],
                                                                      ),

                                                                //  DataTable2(

                                                                //   headingRowHeight: 50,
                                                                //       columnSpacing: 12,
                                                                //       horizontalMargin: 12,
                                                                //       dataRowHeight: 50,
                                                                //       minWidth: 50,
                                                                //       columns: [
                                                                //         DataColumn(
                                                                //           label: Text('Item'),
                                                                //         ),
                                                                //         DataColumn(
                                                                //           label: Text('Qty'),
                                                                //         ),
                                                                //       ],
                                                                //       rows: List<DataRow>.generate(
                                                                //           value.groceriesList.length,
                                                                //           (index4) => DataRow(cells: [
                                                                //                 DataCell(Text('${value.groceriesList[index4]['grocery']['name']}')),
                                                                //                 DataCell(Text('${value.groceriesList[index4]['grocery']['quantity']}')),
                                                                //               ]))),

                                                                // ListView
                                                                //     .builder(
                                                                //     shrinkWrap:
                                                                //         true,
                                                                //     physics:
                                                                //         BouncingScrollPhysics(),
                                                                //     itemCount: value
                                                                //         .groceriesList
                                                                //         .length,
                                                                //     itemBuilder:
                                                                //         (BuildContext context,
                                                                //             int index3) {
                                                                //       return RichText(
                                                                //         softWrap:
                                                                //             true,
                                                                //         textAlign:
                                                                //             TextAlign.justify,
                                                                //         text:
                                                                //             TextSpan(
                                                                //           children: [
                                                                //             TextSpan(
                                                                //               text: "${index3 + 1}. ${value.groceriesList[index3]['grocery']['name']}",
                                                                //               style: TextStyle(fontFamily: 'Poppins', fontSize: 15.0, color: Colors.black),
                                                                //             ),
                                                                //             TextSpan(
                                                                //               text: " [${value.groceriesList[index3]['grocery']['quantity']} qty]",
                                                                //               style: TextStyle(fontFamily: 'Poppins', fontSize: 15.0, color: Colors.black),
                                                                //             ),
                                                                //           ],
                                                                //         ),
                                                                //       );
                                                                //     },
                                                                //   ),
                                                              ),
                                                            ),

                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 20),
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50),
                                                                  color: const Color.fromARGB(255, 216, 216, 216),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              10,
                                                                          right:
                                                                              10),
                                                                  child:
                                                                      TextButton
                                                                          .icon(
                                                                    onPressed:
                                                                        () {
                                                                      setState(
                                                                          () {
                                                                        sharelist =
                                                                            [];
                                                                      });

                                                                      for (int n =
                                                                              0;
                                                                          n < value.groceriesList.length;
                                                                          n++) {
                                                                        sharelist
                                                                            .add("${n + 1}. ${value.groceriesList[n]['grocery']['name']} Qty-${value.groceriesList[n]['grocery']['quantity'].toString() + " " + value.groceriesList[n]['grocery']['quantityType'].toString()}");
                                                                      }
                                                                      if (sharelist
                                                                          .isNotEmpty) {
                                                                        shareListToWhatsApp(
                                                                            sharelist);
                                                                        // Get.to(const PriestsWidget(), arguments: Selected_ServicesList);
                                                                      }
                                                                      sharelist =
                                                                          [];
                                                                    },
                                                                    icon: Icon(
                                                                      Icons
                                                                          .share,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                    label: Text(
                                                                      "Share",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                            // SizedBox(
                                                            //   child: value
                                                            //           .groceriesList
                                                            //           .isEmpty
                                                            //       ? Center(
                                                            //           child:
                                                            //               CircularProgressIndicator(
                                                            //             color: Color.fromARGB(
                                                            //                 255,
                                                            //                 214,
                                                            //                 98,
                                                            //                 35),
                                                            //           ),
                                                            //         )
                                                            //       : Padding(
                                                            //           padding: const EdgeInsets
                                                            //               .all(
                                                            //               16),
                                                            //           child: DataTable2(
                                                            //               columnSpacing: 12,
                                                            //               horizontalMargin: 12,
                                                            //               minWidth: 600,
                                                            //               columns: [
                                                            //                 DataColumn(
                                                            //                   label: Text('Item'),
                                                            //                 ),
                                                            //                 DataColumn(
                                                            //                   label: Text('Qty'),
                                                            //                 ),
                                                            //               ],
                                                            //               rows: List<DataRow>.generate(
                                                            //                   value.groceriesList.length,
                                                            //                   (index4) => DataRow(cells: [
                                                            //                         DataCell(Text('${value.groceriesList[index4]['grocery']['name']}')),
                                                            //                         DataCell(Text('${value.groceriesList[index4]['grocery']['quantity']}')),
                                                            //                       ]))),
                                                            //         ),
                                                            // )
                                                          ],
                                                        )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 244, 244, 244),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Padding(
                                        padding: EdgeInsets.all(20),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                                'images/calendar.svg'),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              listresponse[index]
                                                          ['bookingDate'] ==
                                                      null
                                                  ? ""
                                                  : DateFormat(
                                                          "dd-MM-yyyy hh:mm")
                                                      .format(DateTime.parse(
                                                          listresponse[index]
                                                              ['bookingDate'])),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    listresponse[index]['bookingStatus'] ==
                                            "Cancelled"
                                        ? Container()
                                        : Row(
                                            children: [
                                              Flexible(
                                                child: MaterialButton(
                                                  elevation: 0,
                                                  onPressed: () {
                                                    datecontroller
                                                        .text = listresponse[
                                                                    index][
                                                                'bookingDate'] ==
                                                            null
                                                        ? ""
                                                        : DateFormat(
                                                                "dd-MM-yyyy")
                                                            .format(DateTime.parse(
                                                                listresponse[
                                                                        index][
                                                                    'bookingDate']));
                                                    timecontroller
                                                        .text = listresponse[
                                                                    index][
                                                                'bookingDate'] ==
                                                            null
                                                        ? ""
                                                        : DateFormat("hh:mm")
                                                            .format(DateTime.parse(
                                                                listresponse[
                                                                        index][
                                                                    'bookingDate']));
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return popupwithDiscardandsavebuttons(
                                                          onPressedfordiscard:
                                                              () {
                                                            datecontroller
                                                                .text = listresponse[
                                                                            index]
                                                                        [
                                                                        'bookingDate'] ==
                                                                    null
                                                                ? ""
                                                                : DateFormat(
                                                                        "dd-MM-yyyy")
                                                                    .format(DateTime.parse(
                                                                        listresponse[index]
                                                                            [
                                                                            'bookingDate']));
                                                            timecontroller
                                                                .text = listresponse[
                                                                            index]
                                                                        [
                                                                        'bookingDate'] ==
                                                                    null
                                                                ? ""
                                                                : DateFormat(
                                                                        "hh:mm")
                                                                    .format(DateTime.parse(
                                                                        listresponse[index]
                                                                            [
                                                                            'bookingDate']));
                                                            Get.back();
                                                          },
                                                          onPressedforsave:
                                                              () async {
                                                            List serviceidlist =
                                                                [];
                                                            for (int n = 0;
                                                                n <
                                                                    listresponse[index]
                                                                            [
                                                                            'bookingServiceResponse']
                                                                        .length;
                                                                n++) {
                                                              serviceidlist.add(
                                                                  listresponse[
                                                                              index]
                                                                          [
                                                                          'bookingServiceResponse'][n]
                                                                      [
                                                                      'servicesId']);
                                                            }
                                                            if (formkey
                                                                .currentState!
                                                                .validate()) {
                                                              _re_shcedule_apicall(
                                                                  listresponse[
                                                                          index][
                                                                      'id'],
                                                                  listresponse[
                                                                          index]
                                                                      [
                                                                      'bookingStatus'],
                                                                  listresponse[
                                                                          index]
                                                                      [
                                                                      'description'],
                                                                  listresponse[
                                                                          index]
                                                                      [
                                                                      'priestId'],
                                                                  serviceidlist,
                                                                  listresponse[
                                                                          index]
                                                                      [
                                                                      'address'],
                                                                  datecontroller
                                                                      .text,
                                                                  selectedTime,
                                                                  index);

                                                              Get.back();
                                                            }
                                                          },
                                                          content: Form(
                                                            key: formkey,
                                                            child: Container(
                                                              height: 100,
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    'Date/Time',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Inter',
                                                                          color:
                                                                              Color(0xFFFD642A),
                                                                          fontSize:
                                                                              16.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            10.0,
                                                                            0.0,
                                                                            10.0),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              SizedBox(
                                                                            width:
                                                                                200.0,
                                                                            child:
                                                                                TextFormField(
                                                                              controller: datecontroller,
                                                                              obscureText: false,
                                                                              decoration: InputDecoration(
                                                                                isDense: true,
                                                                                labelText: 'Select Date',
                                                                                labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                      fontFamily: 'Inter',
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.w300,
                                                                                    ),
                                                                                hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                      fontFamily: 'Inter',
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.w300,
                                                                                    ),
                                                                                filled: true,
                                                                                fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                suffixIcon: Icon(
                                                                                  Icons.calendar_today_outlined,
                                                                                ),
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Inter',
                                                                                    letterSpacing: 0.0,
                                                                                  ),
                                                                              cursorColor: Colors.black,
                                                                              onTap: () async {
                                                                                DateTime? pickeddate = await showDatePicker(
                                                                                  context: context,
                                                                                  initialDate: DateTime.now(),
                                                                                  firstDate: DateTime.now(),
                                                                                  lastDate: DateTime(2050),
                                                                                  builder: (context, child) {
                                                                                    return Theme(
                                                                                      data: Theme.of(context).copyWith(
                                                                                        colorScheme: ColorScheme.light(
                                                                                          primary: Color.fromARGB(255, 214, 98, 35), // <-- SEE HERE
                                                                                          onPrimary: Colors.white, // <-- SEE HERE
                                                                                          onSurface: Colors.black, // <-- SEE HERE
                                                                                        ),
                                                                                        textButtonTheme: TextButtonThemeData(
                                                                                          style: TextButton.styleFrom(
                                                                                            foregroundColor: Colors.orange, // button text color
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      child: child!,
                                                                                    );
                                                                                  },
                                                                                );
                                                                                if (pickeddate != null) {
                                                                                  setState(() {
                                                                                    datecontroller.text = DateFormat('yyyy-MM-dd').format(pickeddate);
                                                                                  });
                                                                                }
                                                                              },
                                                                              validator: (value) {
                                                                                if (value!.isEmpty) {
                                                                                  return "Required";
                                                                                } else {
                                                                                  return null;
                                                                                }
                                                                              },
                                                                              keyboardType: TextInputType.none,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                              SizedBox(
                                                                            width:
                                                                                200.0,
                                                                            child:
                                                                                TextFormField(
                                                                              controller: timecontroller,
                                                                              autofocus: false,
                                                                              obscureText: false,
                                                                              decoration: InputDecoration(
                                                                                isDense: true,
                                                                                labelText: 'Select Time',
                                                                                labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                      fontFamily: 'Inter',
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.w300,
                                                                                    ),
                                                                                filled: true,
                                                                                fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                suffixIcon: Icon(
                                                                                  Icons.access_time,
                                                                                ),
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Inter',
                                                                                    letterSpacing: 0.0,
                                                                                  ),
                                                                              cursorColor: FlutterFlowTheme.of(context).primaryText,
                                                                              onTap: () async {
                                                                                TimeOfDay? pickedTime = await showTimePicker(
                                                                                  context: context,
                                                                                  initialTime: TimeOfDay.now(),
                                                                                  builder: (BuildContext context, Widget? child) {
                                                                                    return MediaQuery(
                                                                                      data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
                                                                                      child: Theme(
                                                                                        data: ThemeData.light().copyWith(
                                                                                          colorScheme: ColorScheme.light(
                                                                                            primary: Color.fromARGB(255, 214, 98, 35),
                                                                                            onSurface: Color.fromARGB(255, 214, 98, 35),
                                                                                            onSecondaryContainer: Color.fromARGB(255, 214, 98, 35),
                                                                                          ),
                                                                                          buttonTheme: ButtonThemeData(
                                                                                            colorScheme: ColorScheme.light(
                                                                                              primary: Color.fromARGB(255, 214, 98, 35),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        child: child!,
                                                                                      ),
                                                                                    );
                                                                                  },
                                                                                );

                                                                                if (pickedTime != null) {
                                                                                  DateTime currentDate = DateTime.now();
                                                                                  DateTime selectedDateTime = DateTime(
                                                                                    currentDate.year,
                                                                                    currentDate.month,
                                                                                    currentDate.day,
                                                                                    pickedTime.hour,
                                                                                    pickedTime.minute,
                                                                                    1,
                                                                                    currentDate.millisecond,
                                                                                  );

                                                                                  selectedTime = DateFormat('HH:mm').format(selectedDateTime);
                                                                                  print("object: $selectedTime");

                                                                                  timecontroller.text = "${pickedTime.hourOfPeriod.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')} ${pickedTime.period.index == 0 ? 'AM' : 'PM'}";
                                                                                }
                                                                              },
                                                                              validator: (value) {
                                                                                if (value!.isEmpty) {
                                                                                  return "Required";
                                                                                } else {
                                                                                  return null;
                                                                                }
                                                                              },
                                                                              keyboardType: TextInputType.none,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  color: Color.fromARGB(
                                                      255, 214, 98, 35),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 17),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      // ignore: prefer_const_literals_to_create_immutables
                                                      children: [
                                                        Text('Re-Schedule',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700)),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Flexible(
                                                child: MaterialButton(
                                                  elevation: 0,
                                                  focusColor: Color.fromARGB(
                                                      255, 214, 98, 35),
                                                  onPressed: () {
                                                    updatebookingstatus(
                                                        listresponse[index]
                                                            ['id'],
                                                        index);
                                                    //  Navigator.push(context,
                                                    //       MaterialPageRoute(builder: (context) => screen2()));
                                                  },
                                                  color: Color.fromARGB(
                                                      39, 255, 99, 2),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 17),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      // ignore: prefer_const_literals_to_create_immutables
                                                      children: [
                                                        Text('Cancel',
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        214,
                                                                        98,
                                                                        35),
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700)),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                  ],
                                ),
                              ),
                              //child: Text('data'),
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        );
                        //  Card(
                        //   child: booking_details(Colors.white),
                        // );
                      },
                    )),
        ),
      ),
    );
  }
}
