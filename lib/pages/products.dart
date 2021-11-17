import 'package:flutter/material.dart';
import 'package:rest_api_cupertino_paginatoin/dataclass.dart';
import 'package:rest_api_cupertino_paginatoin/json_parse_and_http_request/json_parse_products.dart';
import 'package:flutter/cupertino.dart';
import 'package:rest_api_cupertino_paginatoin/json_parse_and_http_request/basket.dart';

class Products extends StatefulWidget {
  int id;
  String title;
  Products(this.id, this.title);

  @override
  _ProductsState createState() => _ProductsState(id, title);
}

class _ProductsState extends State<Products> {
  int id;
  String title;
  var page = 1;
  _ProductsState(this.id, this.title);
  late ScrollController _controller;
  int ProductsListLength = 0;
  List<ProductsAll> ProductsList = [];
  var pages = 0;
  String accessKey = '';
  bool load = true;
  List<int> basketList = [];

  bool inBasket(int idProduct) {
    return basketList.any((element) => element == idProduct);
  }

  void getAccessKey() async {
    accessKey = await loadJSONAccessKey();
  }

  void pushInBasket(String idProduct) async {
    await pushBasket(accessKey, idProduct);
  }

  Future<List<ProductsAll>> getProductList() async {
    var request = await loadJSON(id, page);
    pages = request.pages;
    if (page <= pages && load == true) {
      ProductsList += request.productsAllList;
      ProductsListLength = ProductsList.length;
    }
    load = false;
    return ProductsList;
  }

  double getScreenHeight() {
    var padding = MediaQuery.of(context).padding;
    double height =
        MediaQuery.of(context).size.height - padding.top - kToolbarHeight;
    return height;
  }

  double getScreenWidth() {
    var padding = MediaQuery.of(context).padding;
    double width = MediaQuery.of(context).size.width;
    return width;
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      if (page <= pages) {
        page++;
        load = true;
        getProductList();
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    getAccessKey();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductsAll>>(
        future: getProductList(),
        builder:
            (BuildContext context, AsyncSnapshot<List<ProductsAll>> snapshot) {
          Widget children;
          if (snapshot.hasData) {
            children = Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey.shade200))),
                  padding: EdgeInsets.only(
                      left: 20, right: getScreenWidth() * 0.5 - 130),
                  height: getScreenHeight() * 0.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        Image.asset(
                          "source/image/pngwing.com.png",
                          height: 18,
                          width: 18,
                          color: Color(0xFF414951),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        // Icon(Icons.tune_rounded),
                        Text(
                          "Фильтры",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF414951),
                          ),
                        )
                      ]),
                      Container(
                        width: 130,
                        child: Row(
                          children: [
                            Image.asset(
                              "source/image/sort.png",
                              height: 18,
                              width: 18,
                              color: Color(0xFF414951),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "По популярности",
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF414951),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: getScreenHeight() * 0.9,
                  child: GridView.builder(
                      controller: _controller,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: (0.7),
                        crossAxisCount: 2,
                      ),
                      itemCount: ProductsListLength,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: getScreenHeight() * 0.3 * 0.9 * 0.8,
                                width: getScreenWidth() * 0.5 - 20,
                                child: Image.network(snapshot.data![index].url),
                              ),
                              Container(
                                  height: getScreenHeight() * 0.3 * 0.9 * 0.2,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 10),
                                        child: Text(
                                          snapshot.data![index].price
                                                  .toString() +
                                              ' ₽',
                                          style: TextStyle(
                                            // fontFamily: "Semibold",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFF414951),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            basketList
                                                .add(snapshot.data![index].id);
                                            setState(() {});
                                          },
                                          icon: Icon(
                                              inBasket(snapshot.data![index].id)
                                                  ? Icons.shopping_cart_rounded
                                                  : Icons
                                                      .shopping_cart_outlined))
                                    ],
                                  )),
                              Container(
                                height: getScreenHeight() * 0.3 * 0.9 * 0.2,
                                child: Text(
                                  snapshot.data![index].title,
                                  style: TextStyle(
                                    fontFamily: 'Semibold',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF414951),
                                  ),
                                ),
                              )
                            ],
                          )),
                        );
                      }),
                )
              ],
            );
          } else if (snapshot.hasError) {
            children = SizedBox(
              child: Center(
                  child: Text(
                "ERROR",
                style: TextStyle(color: Colors.grey[900], fontSize: 26),
              )),
            );
          } else {
            children = SizedBox(
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.grey[900],
                ),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              foregroundColor: Color(0xFF414951),
              centerTitle: true,
              backgroundColor: Colors.white,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          Navigator.pop(context);
                        });
                      },
                      icon:
                          Icon(Icons.arrow_back_ios, color: Color(0xFF414951))),
                  Text(title,
                      style: TextStyle(
                          color: Color(0xFF414951),
                          fontSize: 16,
                          fontFamily: "Semibold")),
                  Icon(Icons.search, color: Color(0xFF414951)),
                ],
              ),
            ),
            body: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: children,
            ),
          );
        });
  }
}
