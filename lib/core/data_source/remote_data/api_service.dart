import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsapp/core/data_source/remote_data/api_config.dart';

class ApiService {
  ApiService._();

  static final ApiService instance = ApiService._();

  factory ApiService() => instance;

  get(String endpoint) async {
    var url = Uri.parse(
      "${ApiConfig.baseurl}/v2/$endpoint&apiKey=${ApiConfig.apikey}",
    );
    try {
      var response = await http.get(url);
      return jsonDecode(response.body);
    } catch (e) {
      return Exception("Failed to get data : ");
    }
  }
}
