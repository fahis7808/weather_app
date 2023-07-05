import 'dart:convert';

import 'package:http/http.dart' as http;


class ApiCalling{


  static Future <Map<String, dynamic>> fetchData(
      String path
      ) async {
    var url = Uri.parse(path);
    var response = await http.get(
      url,
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }


}