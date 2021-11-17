import 'package:rest_api_cupertino_paginatoin/dataclass.dart';
import 'package:rest_api_cupertino_paginatoin/json_parse_and_http_request/json_parse_product_categories.dart';

class ProductsCategoriesSingleton {
  static ProductsCategoriesSingleton? _productsCategoriesSingleton;
  List<ProductCategories> _productsCategoriesSingletonList = [];

  List<ProductCategories> getProductList() {
    return _productsCategoriesSingletonList;
  }

  int getProductListLength() {
    return _productsCategoriesSingletonList.length;
  }

  Future<List<ProductCategories>> setProductList() async {
    _productsCategoriesSingletonList = await loadJSON();
    //добавлен, чтобы протестировать пагинацию по скроллу в ListView
    _productsCategoriesSingletonList
        .add(ProductCategories(0, "Все товары", "vse-tovari"));
    return _productsCategoriesSingletonList;
  }

  factory ProductsCategoriesSingleton() {
    _productsCategoriesSingleton ??= ProductsCategoriesSingleton._internal();
    return _productsCategoriesSingleton!;
  }

  ProductsCategoriesSingleton._internal();
}
