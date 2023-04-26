import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpClient {
  static final client = http.Client();
  static const baseUrl = 'http://127.0.0.1:8001';

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

Future<void> dummyCall() async {
  final response = await http.post(
    Uri.parse('http://127.0.0.1:8001/promptGPT'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'prompt':
          'Consider the feature recording daily meals. Value means the worth, or usefulness of something, principles or standards; judgement of what is important in life. How can the product or service create or destroy monetary value ? For whom ? Give a precise answer in one or two sentences.',
    }),
  );
  print(response.body);
}
