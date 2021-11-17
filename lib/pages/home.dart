import 'package:flutter/material.dart';
import 'package:rest_api_cupertino_paginatoin/pages/catalog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  final CupertinoTabController _tabController = CupertinoTabController();
  final GlobalKey<NavigatorState> firstTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> secondTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> thirdTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> fourthTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> fifthTabNavKey = GlobalKey<NavigatorState>();

  List<Widget> tabs = [
    Plug('Главное'),
    Catalog(),
    Plug('Избранное'),
    Plug('Корзина'),
    Plug('Профиль'),
  ];
  GlobalKey<NavigatorState> getKey(int index) {
    if (index == 0) {
      return firstTabNavKey;
    } else if (index == 1) {
      return secondTabNavKey;
    } else if (index == 2) {
      return thirdTabNavKey;
    } else if (index == 3) {
      return fourthTabNavKey;
    } else {
      return fifthTabNavKey;
    }
  }

  GlobalKey<NavigatorState> currentNavigatorKey() {
    if (_tabController.index == 0) {
      return firstTabNavKey;
    } else if (_tabController.index == 1) {
      return secondTabNavKey;
    } else if (_tabController.index == 2) {
      return thirdTabNavKey;
    } else if (_tabController.index == 3) {
      return fourthTabNavKey;
    } else {
      return fifthTabNavKey;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: CupertinoTabScaffold(
        controller: _tabController,
        tabBar: CupertinoTabBar(
          activeColor: Color(0xFF414951),
          inactiveColor: Color(0xFF8A8884).withOpacity(0.54),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: 'Главное'),
            BottomNavigationBarItem(
                icon: Icon(Icons.grid_view_outlined), label: 'Каталог'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border), label: 'Избранное'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined), label: 'Корзина'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline), label: 'Профиль'),
          ],
        ),
        tabBuilder: (BuildContext context, int index) {
          return CupertinoTabView(
            navigatorKey: getKey(index),
            builder: (BuildContext context) {
              return tabs[index];
            },
          );
        },
      ),
      onWillPop: () async {
        return !await currentNavigatorKey().currentState!.maybePop();
      },
    );
  }
}

class Plug extends StatelessWidget {
  String page;
  Plug(this.page);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: true,
          foregroundColor: Color(0xFF414951),
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text("Test For Creonit")),
      body: Center(
          child: Text(
        "Экран $page в разработке",
        style: TextStyle(
          fontSize: 16,
          color: Color(0xFF414951),
          decoration: TextDecoration.none,
        ),
      )),
    );
  }
}
