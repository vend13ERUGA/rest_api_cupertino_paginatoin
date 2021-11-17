import 'package:flutter/material.dart';
import 'package:rest_api_cupertino_paginatoin/product_categories.dart';
import 'package:rest_api_cupertino_paginatoin/pages/products.dart';
import 'package:flutter/cupertino.dart';

class Catalog extends StatefulWidget {
  Catalog({Key? key}) : super(key: key);

  @override
  _CatalogState createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          foregroundColor: Color(0xFF414951),
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text("Test For Creonit")),
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: ProductsCategoriesSingleton().getProductListLength(),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                child: Container(
                  padding: EdgeInsets.only(right: 22.5, left: 16, top: 28),
                  height: 52,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ProductsCategoriesSingleton()
                            .getProductList()[index]
                            .title,
                        style: TextStyle(
                          fontFamily: "Semibold",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Icon(
                        Icons.navigate_next,
                        color: Color(0xFF8A8884),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  setState(() {
                    Navigator.of(context, rootNavigator: false)
                        .push(MaterialPageRoute(
                            builder: (context) => Products(
                                  ProductsCategoriesSingleton()
                                      .getProductList()[index]
                                      .id,
                                  ProductsCategoriesSingleton()
                                      .getProductList()[index]
                                      .title,
                                )))
                        .then((_) {
                      setState(() {});
                    });
                  });
                },
              );
            }),
      ),
    );
  }
}

class CustomMaterialPageRoute extends MaterialPageRoute {
  @protected
  bool get hasScopedWillPopCallback {
    return false;
  }

  CustomMaterialPageRoute({
    @required WidgetBuilder? builder,
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(
          builder: builder!,
          settings: settings,
          maintainState: maintainState,
          fullscreenDialog: fullscreenDialog,
        );
}
