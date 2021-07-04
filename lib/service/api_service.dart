import 'dart:developer';

import 'package:http/http.dart' as http;
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
    log(res.body);
    if(res.statusCode == 200) {
      List<dynamic> json = jsonDecode(res.body);

      List<ShowElement> showElements =
      json.map((dynamic item) => ShowElement.fromJson(item)).toList();
      log(showElements.toString());
      for (ShowElement e in showElements) {
        log(e.name);
      }
      return showElements;
    }
    else {
      throw ("Can't get showELements");
    }
  }
}