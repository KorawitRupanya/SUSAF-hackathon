import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpClient {
  static final client = http.Client();
  static const baseUrl = 'https://susaf-384911.lm.r.appspot.com';

  static Future<http.Response> get({required String endpoint}) {
    var url = Uri.parse(baseUrl + endpoint);
    return client.get(url);
  }

  static Future<http.Response> post(
      {required String endpoint, required Map<String, dynamic> data}) {
    var url = Uri.parse(baseUrl + endpoint);
    return client.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
  }
}
