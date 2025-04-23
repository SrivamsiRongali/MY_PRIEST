// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'dart:convert';

import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:my_priest/index.dart';
import 'package:my_priest/shared.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../my_bookings/Mybookings.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'confirmation_model.dart';
export 'confirmation_model.dart';

class ConfirmationWidget extends StatefulWidget {
  const ConfirmationWidget({super.key});

  @override
  State<ConfirmationWidget> createState() => _ConfirmationWidgetState();
}

Razorpay razorpay = Razorpay();
late ValueNotifier<String> selectedaddressdata;
late ValueNotifier<List> allcitylist;

class _ConfirmationWidgetState extends State<ConfirmationWidget> {
  late ConfirmationModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  var priestandservicedata = Get.arguments;
  @override
  void initState() {
    _apicall();
    super.initState();
    // razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    // razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    // razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);

    selectedaddressdata = ValueNotifier<String>("");
    allcitylist = ValueNotifier<List>([]);
    _model = createModel(context, () => ConfirmationModel());

    _model.datetextController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.timetextController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();

    _model.address1textController3 ??= TextEditingController();
    _model.textFieldFocusNode3 ??= FocusNode();

    _model.address2textController4 ??= TextEditingController();
    _model.textFieldFocusNode4 ??= FocusNode();

    _model.citytextController5 ??= TextEditingController();
    _model.textFieldFocusNode5 ??= FocusNode();

    _model.statetextController6 ??= TextEditingController();
    _model.textFieldFocusNode6 ??= FocusNode();

    _model.textController7 ??= TextEditingController();
    _model.textFieldFocusNode7 ??= FocusNode();

    print("passed data ${priestandservicedata[0]}");
    print("passed data ${priestandservicedata[1]}");
  }

  String Razorpaykey = '';
  Map? mapresponse;
  String request_received_message="";
  Future _apicall() async {
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
      mapresponse = json.decode(response1.body);
      setState(() {
        loader = false;
request_received_message=mapresponse!['request_received_message'];
        Razorpaykey = mapresponse!['razor_pay_key'];
      });

      return mapresponse;
    } else {
      setState(() {
        loader = false;
      });
      print(response1.statusCode);
      print('fetch unsuccessful');
      print(response1.body);
    }
  }

  bool cityresponse = false;
  Future<List<String>> fetchSearchPredictions(String query) async {
    // Ensure the query is not empty
    if (query.isEmpty) {
      return [];
    }
    print(
        '''google url 'https://maps.googleapis.com/maps/api/place/autocomplete/json?'
      'input=$query&'
      'key=AIzaSyBC_WlEM3KJ0iga1292EjUx6k-Ah_ws5FE&'
      'types=geocode&'
      'language=en-GB&'
      'components=country:IN''');
    // Define the endpoint with dynamic input
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?'
        'input=$query&'
        'key=AIzaSyBC_WlEM3KJ0iga1292EjUx6k-Ah_ws5FE&'
        'types=geocode&'
        'language=en-GB&'
        'components=country:IN');

    // Headers (optional for this API)
    final headers = {
      'accept': '/',
      'accept-language': 'en-GB,en-US;q=0.9,en;q=0.8',
      'user-agent': 'Flutter App',
    };

    try {
      // Send GET request
      final response = await http.get(url, headers: headers);

      // Check the response status
      if (response.statusCode == 200) {
        setState(() {
          cityresponse = false;
        });
        // Decode JSON response
        final jsonResponse = json.decode(response.body);

        // Extract predictions
        final predictions = jsonResponse['predictions'] as List;
        setState(() {
          allcitylist.value = jsonResponse['predictions'];
        });
        print(
            'successful fetch data: ${response.statusCode} ${jsonResponse['predictions'][0]['structured_formatting']}');
        return predictions.map((p) => p['description'] as String).toList();
      } else {
        setState(() {
          cityresponse = true;
        });
        print('Failed to fetch data: ${response.statusCode} ${response.body}');
        return [];
      }
    } catch (e) {
      setState(() {
        cityresponse = true;
      });
      print('Error efsf: $e');
      return [];
    }
  }

  citybottomsheet(TextEditingController city, double screensize) async {
    return showModalBottomSheet(
      enableDrag: false,
      useSafeArea: true,
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: StatefulBuilder(builder: (context, setState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(Icons.arrow_back_ios)),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 5.0, 24.0, 10.0),
                    child: Text(
                      "Type your building name or house number",
                      style: FlutterFlowTheme.of(context).titleSmall.override(
                            fontFamily: 'Inter Tight',
                            color: Color(0xFFD66223),
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 5.0, 24.0, 0.0),
                    child: TextFormField(
                      controller: city,
                      obscureText: false,
                      onChanged: (value) {
                        if (value.length >= 3) {
                          fetchSearchPredictions(value);
                          setState(() {});
                        } else {
                          fetchSearchPredictions("");
                          setState(() {});
                        }
                      },
                      onTapOutside: (event) {
                        if (city.text.length >= 3) {
                          fetchSearchPredictions(city.text);
                          setState(() {});
                        } else {
                          fetchSearchPredictions("");
                          setState(() {});
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Building name or house number',
                        labelStyle: FlutterFlowTheme.of(context).labelMedium,
                        hintText: "Building name or house number",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primary,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor:
                            FlutterFlowTheme.of(context).primaryBackground,
                        prefixIcon: Icon(
                          Icons.search_outlined,
                          color: FlutterFlowTheme.of(context).secondaryText,
                        ),
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium,
                      maxLines: 1,
                      // validator: cityctrl.asValidator(context),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 0.0),
                      child: SingleChildScrollView(
                        child: ValueListenableBuilder(
                          builder:
                              (BuildContext context, value, Widget? child) =>
                                  Container(
                            child: allcitylist.value == null
                                ? SizedBox(
                                    width: double.infinity,
                                    height: 200,
                                    child: Center(
                                        child: Text(
                                      'Type or search your building by name or house number',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .headlineSmall
                                          .override(
                                            fontFamily: 'Outfit',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    )))
                                : allcitylist.value!.isEmpty &&
                                        cityresponse == false
                                    ? SizedBox(
                                        width: double.infinity,
                                        height: 200,
                                        child: Center(
                                            child: Text(
                                          'Type or search your building by name or house number',
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .headlineSmall
                                              .override(
                                                fontFamily: 'Outfit',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.normal,
                                              ),
                                        )))
                                    : allcitylist.value.isEmpty &&
                                            cityresponse == true
                                        ? SizedBox(
                                            width: double.infinity,
                                            height: 200,
                                            child: Center(
                                                child: Text(
                                              'Address not found',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineSmall
                                                      .override(
                                                        fontFamily: 'Outfit',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                            )))
                                        : Container(
                                            height: screensize,
                                            child: SingleChildScrollView(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  bottom: MediaQuery.of(context)
                                                      .viewInsets
                                                      .bottom,
                                                ),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  15.0,
                                                                  10.0,
                                                                  15.0,
                                                                  10.0),
                                                      child: FFButtonWidget(
                                                        onPressed: () async {
                                                          Get.back();
                                                        },
                                                        text: 'Continue',
                                                        options:
                                                            FFButtonOptions(
                                                          width:
                                                              double.infinity,
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      16.0,
                                                                      20.0,
                                                                      16.0,
                                                                      20.0),
                                                          iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          color:
                                                              Color(0xFFFFF6EA),
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .override(
                                                                    fontFamily:
                                                                        'Inter Tight',
                                                                    color: Color(
                                                                        0xFFD66223),
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                          elevation: 0.0,
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0xFFD66223),
                                                            width: 2.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      15.0,
                                                                      0.0,
                                                                      15.0,
                                                                      0.0),
                                                          child: Text(
                                                            "Or pick from suggestions below",
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .titleSmall
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter Tight',
                                                                  color: Color(
                                                                      0xFFD66223),
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    ListView.builder(
                                                        // controller: controller,

                                                        physics:
                                                            BouncingScrollPhysics(),
                                                        itemCount:
                                                            allcitylist.value ==
                                                                    null
                                                                ? 0
                                                                : allcitylist
                                                                    .value
                                                                    .length,
                                                      
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          return Padding(
                                                           padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        5.0,
                                                                        0.0,
                                                                        5.0,
                                                                        0.0),
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    blurRadius:
                                                                        0.0,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .alternate,
                                                                    offset:
                                                                        Offset(
                                                                            0.0,
                                                                            1.0),
                                                                  )
                                                                ],
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10.0,
                                                                        10.0,
                                                                        10.0,
                                                                        10.0),
                                                                child:
                                                                    GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    // _model.address2textController4.text=value[index]['structured_formatting']['secondary_text'];

                                                                    List
                                                                        addressdatafromgoogle =
                                                                        [];
                                                                    addressdatafromgoogle.addAll(value[index]['structured_formatting']
                                                                            [
                                                                            'secondary_text']
                                                                        .split(
                                                                            ','));
                                                                    print(
                                                                        "address data $addressdatafromgoogle");
                                                                    _model
                                                                        .statetextController6
                                                                        .text = addressdatafromgoogle.length <
                                                                            2
                                                                        ? addressdatafromgoogle
                                                                            .first
                                                                        : addressdatafromgoogle[
                                                                            addressdatafromgoogle.length -
                                                                                2];
                                                                    _model
                                                                        .citytextController5
                                                                        .text = addressdatafromgoogle.length <
                                                                            3
                                                                        ? value[index]['structured_formatting']
                                                                            [
                                                                            'main_text']
                                                                        : addressdatafromgoogle[
                                                                            addressdatafromgoogle.length -
                                                                                3];
                                                                    _model.dropDownValue =
                                                                        addressdatafromgoogle
                                                                            .last;
                                                                    addressdatafromgoogle.removeRange(
                                                                        addressdatafromgoogle.length <=
                                                                                3
                                                                            ? 0
                                                                            : addressdatafromgoogle.length -
                                                                                3,
                                                                        addressdatafromgoogle
                                                                            .length);
                                                                    _model
                                                                        .address1textController3
                                                                        .text = value[index]['structured_formatting']
                                                                            [
                                                                            'main_text'] +
                                                                        addressdatafromgoogle
                                                                            .join(',');

                                                                    Get.back();
                                                                    this.setState(
                                                                        () {});
                                                                  },
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                              child: Text(
                                                                                '${value[index]['description']}',
                                                                                style: FlutterFlowTheme.of(context).bodyLarge,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                          ),
                          valueListenable: allcitylist,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        );
      },
    );
  }

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool loader = false;
  String selectedTime = "00:00";
  int bookingid = 0;
  String servicename = '';
  Future userbooking(String date, String time, int priestid, List serviceid,
      String notes) async {
    setState(() {
      loader = true;
    });
    print(" date = ${date}T$time:00.00Z,priest=$priestid,serviceid=$serviceid");
    var data = json.encode({
      "address": {
        "addressLine1": _model.address2textController4.text,
        "addressLine2": _model.address1textController3.text,
        "addressType": "Current",
        "cityId": 1,
        "currentLatitude": 0,
        "currentLongitude": 0,
        "description":
            "${_model.citytextController5.text}-${_model.statetextController6.text}-${_model.dropDownValue!}",
        "fax": "string",
        "zip": "string"
      },
      "bookingStatus": "Initiated",
      "bookingDate": "${date}T$time:00",
      "description": notes,
      "priestId": priestid,
      "servicesId": serviceid,
    });
    print("booking object $data");
    Map mapresponse;
    Map mapresponse2;
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString("servicetime", "$date,$time");
    var token = sharedPreferences.getString("token");
    var email = sharedPreferences.getString("email");
    var mobilenumber = sharedPreferences.getString("mobilenumber");

    http.Response response2 = await http.post(
        Uri.parse(
            "https://${AppConstants.ipaddress.ipaddress}/api/bookings/request-booking"),
        headers: {
          "accept": "*/*",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: data);

    if (response2.statusCode == 200) {
      mapresponse2 = json.decode(response2.body);

      Get.offAll(
        SuccessWidget(),arguments: request_received_message
      );
// print('''
//         'key' :'$Razorpaykey'
//         'amount':${ mapresponse2['amount']}, //in paise.
//         'name': 'Payment for Service(s) - $servicename',
//         'order_id':

//             ${mapresponse2['id']}
//             , // Generate order_id using Orders API
//         'description': 'Fine T-Shirt',
//         'timeout': '600', // in seconds
//         'prefill': {
//           'contact': $mobilenumber,
//           'email': $email
//         }
//       ''');
//       razorpay.open({
//         'key': '$Razorpaykey',
//         'amount':

//         mapresponse2['amount'], //in paise.
//         'name': 'Payment for Service(s) - $servicename',
//         'order_id':

//             '${mapresponse2['id']}'
//             , // Generate order_id using Orders API
//         'description': 'Fine T-Shirt',
//         'timeout': 600, // in seconds
//         'prefill': {
//           'contact': '$mobilenumber',
//           'email': '$email'
//         }
//       });
    } else {
      setState(() {
        loader = false;
      });
      mapresponse2 = json.decode(response2.body);
      print('fail');
      Get.defaultDialog(
        title: "Unable book ${mapresponse2['message']}",
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
    }
  }
//     Future updatebookingstatus() async {
//     setState(() {
//       loader = true;
//     });
//     // print(" date = ${date}T$time:00.00Z,priest=$priestid,serviceid=$serviceid");
//     var data = json.encode({
//   "bookingStatus": "Booked",
//   "paymentReference": "string"
// });
//     print("booking object $data");
//     Map mapresponse;
//      Map mapresponse2;
//     final SharedPreferences sharedPreferences =
//         await SharedPreferences.getInstance();

//     var token = sharedPreferences.getString("token");
//     print("https://${AppConstants.ipaddress.ipaddress}/api/bookings/payment/$bookingid");
//     http.Response response = await http.put(
//         Uri.parse("https://${AppConstants.ipaddress.ipaddress}/api/bookings/payment/$bookingid"),
//         headers: {
//           "accept": "*/*",
//           "Content-Type": "application/json",
//           "Authorization": "Bearer $token"
//         },
//         body: data);

//     if (response.statusCode == 200) {
//       mapresponse = json.decode(response.body);

//          Get.offAll(
//       SuccessWidget(),
//     );

//     } else {
//       setState(() {
//         loader = false;
//       });
//       Get.offAll(
//       SuccessWidget(),
//     );

//       print(" data =$data");
//       print('fail');
//       Get.defaultDialog(
//         title: "Unable to update payment status",
//         titleStyle: TextStyle(color: Colors.red),
//         content: Padding(
//           padding: const EdgeInsets.only(left: 10, right: 10),
//           child: Text("Please try after some time",
//               style: TextStyle(color: Colors.black)),
//         ),
//         actions: [
//           MaterialButton(
//             color: Color.fromARGB(255, 255, 123, 0),
//             onPressed: () {
//               Get.back();
//             },
//             child: Text(
//               'ok',
//               style: TextStyle(
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ],
//       );
//       print(response.statusCode);
//       print(response.body);
//     }
//   }

  // void handlePaymentErrorResponse(PaymentFailureResponse response) {
  //   /*
  //   * PaymentFailureResponse contains three values:
  //   * 1. Error Code
  //   * 2. Error Description
  //   * 3. Metadata
  //   * */

  //   showAlertDialog(context, "Payment Failed",
  //       "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  // }

  // void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
  //   /*
  //   * Payment Success Response contains three values:
  //   * 1. Order ID
  //   * 2. Payment ID
  //   * 3. Signature
  //   * */

  // updatebookingstatus();
  //   // showAlertDialog(
  //   //     context, "Payment Successful", "Payment ID: ${response.paymentId}");
  //   // print("object ${response} ${response.paymentId} ");
  // }

  // void handleExternalWalletSelected(ExternalWalletResponse response) {
  //   showAlertDialog(
  //       context, "External Wallet Selected", "${response.walletName}");
  // }

  // void showAlertDialog(BuildContext context, String title, String message) {
  //   // set up the buttons
  //   Widget continueButton = ElevatedButton(
  //     child: const Text("Ok"),
  //     onPressed: () {
  //       Get.back();
  //     },
  //   );
  //   // set up the AlertDialog
  //   AlertDialog alert = AlertDialog(
  //     content: Text(
  //       title,
  //       style: TextStyle(fontSize: 20),
  //     ),
  //     actions: [continueButton],
  //   );
  //   // show the dialog
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }

  // Map<String, Object> getPaymentOptions() {
  //   return {
  //     'key': 'rzp_test_mtBEoRXCieHNgB',
  //     'amount': 99900, //in paise.
  //     'name': 'first order',
  //     'order_id': 'order_Oi2vn1g1m4CujE', // Generate order_id using Orders API
  //     'description': 'Fine T-Shirt',
  //     'timeout': 600, // in seconds
  //     'prefill': {'contact': '8919806771', 'email': 'rongalisrivamsi@gmail.com'}
  //   };
  // }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
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
              Get.back();
            },
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
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 15.0, 10.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formkey,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(50.0),
                                    child: Image.asset(
                                      'assets/images/Mask_Group.png',
                                      width: 70.0,
                                      height: 70.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15.0, 0.0, 0.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          priestandservicedata[1]['priest']
                                              ['user']['userName'],
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Inter',
                                                fontSize: 12.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w300,
                                              ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        priestandservicedata[1]['priest']
                                                        ['user']['address']
                                                    .length ==
                                                0
                                            ? Container()
                                            : Text(
                                                priestandservicedata[1]['priest']
                                                            ['user']['address']
                                                        [0]['city']['name'] +
                                                    ', ' +
                                                    priestandservicedata[1]
                                                                ['priest']['user']
                                                            ['address'][0]['city']
                                                        ['state']['name'] +
                                                    ', ' +
                                                    priestandservicedata[1]
                                                                    ['priest']
                                                                ['user']['address']
                                                            [0]['city']['state']
                                                        ['country']['name'],
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          fontSize: 12.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                        ),
                                              ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Color(0xFFF2F3F4),
                                                borderRadius:
                                                    BorderRadius.circular(24.0),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        15.0, 5.0, 15.0, 5.0),
                                                child: Text(
                                                  'Hindi',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
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
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Color(0xFFF2F3F4),
                                                borderRadius:
                                                    BorderRadius.circular(24.0),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        15.0, 5.0, 15.0, 5.0),
                                                child: Text(
                                                  'telugu',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
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
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 20.0, 0.0, 10.0),
                          child: ListView.builder(
                            itemCount: priestandservicedata[0].length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) =>
                                Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF2F3F4),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10.0, 10.0, 10.0, 10.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Icon(
                                            Icons.check_circle,
                                            color: FlutterFlowTheme.of(context)
                                                .success,
                                            size: 24.0,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    5.0, 0.0, 0.0, 0.0),
                                            child: SizedBox(
                                              width: screensize.width * 0.62,
                                              child: Text(
                                                priestandservicedata[0][index]
                                                    ['name'],
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(24.0),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  15.0, 5.0, 15.0, 5.0),
                                          child: Text(
                                            '${NumberFormat.simpleCurrency(locale: "hi-IN", decimalDigits: 2).format(priestandservicedata[0][index]['defaultPrice'])}',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Inter',
                                                  fontSize: 10.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w300,
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
                        // Padding(
                        //   padding:
                        //       EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                        //   child: Container(
                        //     width: double.infinity,
                        //     decoration: BoxDecoration(
                        //       color: Color(0xFFF2F3F4),
                        //     ),
                        //     child: Padding(
                        //       padding: EdgeInsetsDirectional.fromSTEB(
                        //           10.0, 10.0, 10.0, 10.0),
                        //       child: Row(
                        //         mainAxisSize: MainAxisSize.max,
                        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           Row(
                        //             mainAxisSize: MainAxisSize.max,
                        //             children: [
                        //               Icon(
                        //                 Icons.check_circle,
                        //                 color: FlutterFlowTheme.of(context).success,
                        //                 size: 24.0,
                        //               ),
                        //               Padding(
                        //                 padding: EdgeInsetsDirectional.fromSTEB(
                        //                     5.0, 0.0, 0.0, 0.0),
                        //                 child: Text(
                        //                   'Chandi Homam',
                        //                   style: FlutterFlowTheme.of(context)
                        //                       .bodyMedium
                        //                       .override(
                        //                         fontFamily: 'Inter',
                        //                         fontSize: 16.0,
                        //                         letterSpacing: 0.0,
                        //                         fontWeight: FontWeight.normal,
                        //                       ),
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //           Container(
                        //             decoration: BoxDecoration(
                        //               color: FlutterFlowTheme.of(context)
                        //                   .secondaryBackground,
                        //               borderRadius: BorderRadius.circular(24.0),
                        //             ),
                        //             child: Padding(
                        //               padding: EdgeInsetsDirectional.fromSTEB(
                        //                   15.0, 5.0, 15.0, 5.0),
                        //               child: Text(
                        //                 '800',
                        //                 style: FlutterFlowTheme.of(context)
                        //                     .bodyMedium
                        //                     .override(
                        //                       fontFamily: 'Inter',
                        //                       fontSize: 10.0,
                        //                       letterSpacing: 0.0,
                        //                       fontWeight: FontWeight.w300,
                        //                     ),
                        //               ),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Text(
                          'Date/Time',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Inter',
                                    color: Color(0xFFFD642A),
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 10.0, 0.0, 10.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: SizedBox(
                                  width: 200.0,
                                  child: TextFormField(
                                    controller: _model.datetextController1,
                                    focusNode: _model.textFieldFocusNode1,
                                    autofocus: false,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      labelText: 'Select Date',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'Inter',
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w300,
                                          ),
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'Inter',
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w300,
                                          ),
                                      filled: true,
                                      fillColor: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      suffixIcon: Icon(
                                        Icons.calendar_today_outlined,
                                      ),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          letterSpacing: 0.0,
                                        ),
                                    cursorColor: Colors.black,
                                    onTap: () async {
                                      DateTime? pickeddate =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2050),
                                        builder: (context, child) {
                                          return Theme(
                                            data: Theme.of(context).copyWith(
                                              colorScheme: ColorScheme.light(
                                                primary: Color.fromARGB(
                                                    255,
                                                    214,
                                                    98,
                                                    35), // <-- SEE HERE
                                                onPrimary: Colors
                                                    .white, // <-- SEE HERE
                                                onSurface: Colors
                                                    .black, // <-- SEE HERE
                                              ),
                                              textButtonTheme:
                                                  TextButtonThemeData(
                                                style: TextButton.styleFrom(
                                                  foregroundColor: Colors
                                                      .orange, // button text color
                                                ),
                                              ),
                                            ),
                                            child: child!,
                                          );
                                        },
                                      );
                                      if (pickeddate != null) {
                                        setState(() {
                                          _model.datetextController1.text =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(pickeddate);
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
                                width: 10,
                              ),
                              Expanded(
                                child: SizedBox(
                                  width: 200.0,
                                  child: TextFormField(
                                    controller: _model.timetextController2,
                                    focusNode: _model.textFieldFocusNode2,
                                    autofocus: false,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      labelText: 'Select Time',
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
                                      suffixIcon: Icon(
                                        Icons.access_time,
                                      ),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          letterSpacing: 0.0,
                                        ),
                                    cursorColor: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    onTap: () async {
                                      TimeOfDay? pickedTime =
                                          await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                        builder: (BuildContext context,
                                            Widget? child) {
                                          return MediaQuery(
                                            data: MediaQuery.of(context)
                                                .copyWith(
                                                    alwaysUse24HourFormat:
                                                        false),
                                            child: Theme(
                                              data: ThemeData.light().copyWith(
                                                colorScheme: ColorScheme.light(
                                                  primary: Color.fromARGB(
                                                      255, 214, 98, 35),
                                                  onSurface: Color.fromARGB(
                                                      255, 214, 98, 35),
                                                  onSecondaryContainer:
                                                      Color.fromARGB(
                                                          255, 214, 98, 35),
                                                ),
                                                buttonTheme: ButtonThemeData(
                                                  colorScheme:
                                                      ColorScheme.light(
                                                    primary: Color.fromARGB(
                                                        255, 214, 98, 35),
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

                                        selectedTime = DateFormat('HH:mm')
                                            .format(selectedDateTime);
                                        print("object: $selectedTime");

                                        _model.timetextController2.text =
                                            "${pickedTime.hourOfPeriod.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')} ${pickedTime.period.index == 0 ? 'AM' : 'PM'}";
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
                        Text(
                          'Enter Address',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Inter',
                                    color: Color(0xFFFD642A),
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),

                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 10.0, 0.0, 0.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: TextFormField(
                              controller: _model.address2textController4,
                              focusNode: _model.textFieldFocusNode4,
                              autofocus: false,
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: 'Flat / House No. / Block',
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
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 10.0, 0.0, 0.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: TextFormField(
                              controller: _model.address1textController3,
                              focusNode: _model.textFieldFocusNode3,
                              keyboardType: TextInputType.none,
                              autofocus: false,
                              obscureText: false,
                              onTap: () {
                                citybottomsheet(_model.address1textController3!,
                                    screensize.height * 0.78);
                              },
                              // onChanged: (value) {
                              //   if(value.length>=3){
                              //     fetchSearchPredictions(value);
                              //   }
                              // },

                              decoration: InputDecoration(
                                suffixIcon: Icon(Icons.search),
                                isDense: true,
                                labelText: 'Building / Apartment',
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
                          ),
                        ),

                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 10.0, 0.0, 0.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: TextFormField(
                              controller: _model.citytextController5,
                              focusNode: _model.textFieldFocusNode5,
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
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Required";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 10.0, 0.0, 0.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: TextFormField(
                              controller: _model.statetextController6,
                              focusNode: _model.textFieldFocusNode6,
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
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Required";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 10.0, 0.0, 0.0),
                          child: FlutterFlowDropDown<String>(
                            controller: _model.dropDownValueController ??=
                                FormFieldController<String>(null),
                            options: ['India', 'USA', 'Australia'],
                            onChanged: (val) =>
                                safeSetState(() => _model.dropDownValue = val),
                            width: double.infinity,
                            height: 40.0,
                            textStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Inter',
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w300,
                                ),
                            hintText: _model.dropDownValue ?? 'Select Country',
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
                        ),
                        Text(
                          'Add notes',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Inter',
                                    color: Color(0xFFFD642A),
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: TextFormField(
                            controller: _model.textController7,
                            focusNode: _model.textFieldFocusNode7,
                            autofocus: false,
                            obscureText: false,
                            decoration: InputDecoration(
                              isDense: true,
                              labelText: 'Add notes',
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
                            validator: _model.textController7Validator
                                .asValidator(context),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FFButtonWidget(
                          onPressed: () async {
                            if (formkey.currentState!.validate()) {
                              if (_model.dropDownValue == null) {
                                Get.defaultDialog(
                                  title: "",
                                  titleStyle: TextStyle(color: Colors.red),
                                  content: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Text("Please select country",
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
                              } else {
                                if (loader = true) {
                                  List serviceId = [];
                                  setState(() {
                                    for (int n = 0;
                                        n < priestandservicedata[0].length;
                                        n++) {
                                      servicename = servicename +
                                          "${servicename.isEmpty ? '' : ','}" +
                                          priestandservicedata[0][n]['name'];
                                      print(
                                          "service id ${priestandservicedata[0][n]['id']}");
                                      serviceId.add(
                                          priestandservicedata[0][n]['id']);
                                    }
                                  });

                                  print("Service ids = $serviceId");
                                  if (serviceId.length > 0) {
                                    if (Razorpaykey.isNotEmpty) {
                                      userbooking(
                                          _model.datetextController1.text,
                                          selectedTime,
                                          priestandservicedata[1]['priestId'],
                                          serviceId,
                                          _model.address2textController4.text +
                                              _model.address1textController3
                                                  .text +
                                              _model.citytextController5.text +
                                              _model.statetextController6.text +
                                              _model.dropDownValue.toString());
                                    } else {
                                      setState(() {
                                        loader = false;
                                      });
                                      print("service id $serviceId");
                                      Get.defaultDialog(
                                          title: "",
                                          content: Text(
                                              "Unable make bookings right now please try again later"),
                                          actions: [
                                            MaterialButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: Text("Ok"),
                                            )
                                          ]);
                                    }
                                  } else {
                                    setState(() {
                                      loader = false;
                                    });

                                    Get.defaultDialog(
                                        title: "",
                                        content: Text(
                                            "Unable make bookings right now please try again later"),
                                        actions: [
                                          MaterialButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: Text("Ok"),
                                          )
                                        ]);
                                  }
                                }
                              }
                            }

                            //     Navigator.push(context,
                            // MaterialPageRoute(builder: (context) => SuccessWidget()));
                          },
                          text: 'Continue',
                          options: FFButtonOptions(
                            width: double.infinity,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 25.0, 16.0, 25.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: Color(0xFFFFF6EA),
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Inter Tight',
                                  color: Color(0xFFD66223),
                                  letterSpacing: 0.0,
                                ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: Color(0xFFD66223),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
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
