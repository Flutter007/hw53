import 'dart:convert';

import 'package:http/http.dart' as http;

Future<dynamic> request(
  String url, {
  String method = 'GET',
  dynamic body,
}) async {
  final uri = Uri.parse(url);
  http.Response response;

  if (method == 'GET') {
    response = await http.get(uri);
  } else if (method == 'POST') {
    response = await http.post(uri, body: json.encode(body));
  } else if (method == 'DELETE') {
    response = await http.delete(uri);
  } else {
    throw Exception('Method not supported');
  }
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Request Error. Url: $url, code: ${response.statusCode}');
  }
}
