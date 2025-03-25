import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import '../../shared.dart';

class Servicedetailsdata with ChangeNotifier {
  String serviceid = "";
  String servicename = "";
  String Serviceprice = "";
  var servicetime;
  String priestimage =
      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";
  List groceriesList = [];

  get _serivicename => servicename;
  servicegrocerydetails(int serviceID) async {
    var mapresponse;
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    var token = sharedPreferences.getString("token");
    http.Response response = await http.get(
      Uri.parse(
          "https://${AppConstants.ipaddress.ipaddress}/api/service-grocery/$serviceID/service-id"),
      headers: {
        "accept": "*/*",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );

    if (response.statusCode == 200) {
      groceriesList = json.decode(response.body);

      print('groceriesList $groceriesList');
    } else {
      // Get.defaultDialog(title: "", content: Text("${response.body}"));
      print(response.statusCode);
      print(response.body);
    }
    notifyListeners();
  }
}
