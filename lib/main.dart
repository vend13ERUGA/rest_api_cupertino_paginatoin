import 'package:flutter/material.dart';
import 'package:rest_api_cupertino_paginatoin/pages/home.dart';
import 'package:rest_api_cupertino_paginatoin/product_categories.dart';

void main() async {
  await ProductsCategoriesSingleton().setProductList();
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Home(),
    },
  ));
}
