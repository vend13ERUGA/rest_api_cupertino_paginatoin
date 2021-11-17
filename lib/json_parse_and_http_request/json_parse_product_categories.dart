import 'dart:async' show Future;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rest_api_cupertino_paginatoin/dataclass.dart';

Future<String> _loadJSON() async {
  var client = http.Client();
  Uri uri = Uri.parse('https://vue-study.skillbox.cc/api/productCategories');
  var responce = await client.get(uri);
  return responce.body;
}

Future<List<ProductCategories>> loadJSON() async {
  String jsonString = await _loadJSON();
  ProductCategoriesList productsJson = _parseJson(jsonString);

  return productsJson.productCategoriesList;
}

ProductCategoriesList _parseJson(String jsonString) {
  Map decoded = jsonDecode(jsonString);
  List<ProductCategories> items = [];
  for (var item in decoded['items']) {
    items.add(ProductCategories(item['id'], item['title'], item['slug']));
  }
  return ProductCategoriesList(items);
}
