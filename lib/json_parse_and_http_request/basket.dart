import 'dart:async' show Future;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> _loadJSON(String uriStr) async {
  var client = http.Client();
  Uri uri = Uri.parse(uriStr);
  var responce = await client.get(uri);
  return responce.body;
}

Future<String> loadJSONAccessKey() async {
  String jsonStringAccessKey =
      await _loadJSON('https://vue-study.skillbox.cc/api/users/accessKey');
  String accessKey = _parseJsonAccessKey(jsonStringAccessKey);
  return accessKey;
}

String _parseJsonAccessKey(String jsonString) {
  Map decoded = jsonDecode(jsonString);
  String accessKey = decoded['accessKey'];
  print(accessKey + " accessKey");
  return accessKey;
}

Future<HttpClientRequest?> pushBasket(String accessKey, String Id) async {
  final client = HttpClient();
  final request = await client.postUrl(Uri.parse(
      "https://vue-study.skillbox.cc/api/baskets/products?userAccessKey=$accessKey"));
  request.headers
      .set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
  request.write('{"productId": "$Id","quantity": "1"}');

  final response = await request.close();

  response.transform(utf8.decoder).listen((contents) {
    print(contents);
  });
}
