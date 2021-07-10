import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:tester_project/model/merchant_element.dart';
import 'dart:convert';
import 'package:tester_project/model/show_element.dart';

import 'config.dart';

class ApiService {

  Future fetchJsonData(String url) async {
    final response = await http.get(Uri.parse(currentTrackUrl));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print("Exception caught: Failed to get data");
    }
  }

  Future<List<ShowElement>> getShowElements() async {
    log("start fetching");
    final res = await http.get(Uri.parse(showUrl));
    if(res.statusCode == 200) {
      List<dynamic> json = jsonDecode(res.body);

      List<ShowElement> showElements =
      json.map((dynamic item) => ShowElement.fromJson(item)).toList();
      showElements.add(ShowElement(name: "", description: "", timeFull: ""));
      log(showElements.toString());
      return showElements;
    }
    else {
      throw ("Can't get showELements");
    }
  }

  Future<List<MerchantElement>> getMerchantElements() async {
    log("start fetching");
    final res = await http.get(Uri.parse(merchantUrl));
    if(res.statusCode == 200) {
      List<dynamic> json = jsonDecode(res.body);

      List<MerchantElement> merchantElements =
      json.map((dynamic item) => MerchantElement.fromJson(item)).toList();
      log(merchantElements.toString());
      return merchantElements;
    }
    else {
      throw ("Can't get merchantELements");
    }
  }
}