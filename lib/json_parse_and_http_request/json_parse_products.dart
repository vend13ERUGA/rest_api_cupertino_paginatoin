import 'dart:async' show Future;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rest_api_cupertino_paginatoin/dataclass.dart';

Future<String> _loadJSON(int categoryId, int page) async {
  var client = http.Client();
  Uri uri = Uri.parse(
      'https://vue-study.skillbox.cc/api/products?categoryId=$categoryId&page=$page&limit=8');
  var responce = await client.get(uri);
  return responce.body;
}

Future<ProductsAllList> loadJSON(int categoryId, int page) async {
  String jsonString = await _loadJSON(categoryId, page);
  ProductsAllList productAllList = _parseJson(jsonString);
  return productAllList;
}

ProductsAllList _parseJson(String jsonString) {
  Map decoded = jsonDecode(jsonString);
  List<ProductsAll> items = [];
  dynamic pages = 0;
  for (var item in decoded['items']) {
    items.add(ProductsAll(item['id'], item['title'], item['slug'],
        item['price'], item['image']['file']['url']));
  }
  pages = decoded['pagination']['pages'];

  return ProductsAllList(items, pages);
}
