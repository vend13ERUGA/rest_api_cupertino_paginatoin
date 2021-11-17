class ProductCategories {
  final int id;
  final String title;
  final String slug;
  ProductCategories(this.id, this.title, this.slug);
}

class ProductCategoriesList {
  final List<ProductCategories> productCategoriesList;
  ProductCategoriesList(this.productCategoriesList);
}

class ProductsAll {
  final int id;
  final String title;
  final String slug;
  final int price;
  final String url;
  ProductsAll(this.id, this.title, this.slug, this.price, this.url);
}

class ProductsAllList {
  final List<ProductsAll> productsAllList;
  int pages;
  ProductsAllList(this.productsAllList, this.pages);
}
