import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turbbbites_flutter_app/core/api/controllers/auth_controller.dart';
import 'package:turbbbites_flutter_app/core/controllers/cart_controller.dart';
import 'package:turbbbites_flutter_app/views/home/home_dishes_body.dart';
import 'package:turbbbites_flutter_app/views/home/home_location_body.dart';
import 'package:turbbbites_flutter_app/views/user/user_body.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  CartController cartController = CartController.controller;
  AuthApiController authController = AuthApiController.controller;
  int _activeTab = 0;

  @override
  void initState() {
    _initializeUserSession();
    super.initState();
  }

  void _initializeUserSession() async {
    await authController.getSharedPreferences();
    await authController.validateSession();
  }

  void _toggleTab(int index) {
    setState(() {
      _activeTab = index;
    });
  }

  void _onPressed() {
    Get.toNamed('/cart');
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Column(
      children: [
        HomeLocationBody(),
        Expanded(
          child: HomeDishesBody(),
        ),
      ],
    );
    if(_activeTab == 1) {
      content = UserBody();
    }


    return Scaffold(
      appBar: AppBar(),
      body: content,
      floatingActionButton: FloatingActionButton(
        onPressed: _onPressed,
        child: Obx(() => cartController.listCount > 0 ? Badge.count(count: cartController.listCount , child: const Icon(Icons.shopping_basket_outlined), ) : const Icon(Icons.shopping_basket_outlined)),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _activeTab,
        onTap: _toggleTab,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Menu",
            activeIcon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            label: "User",
            activeIcon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
