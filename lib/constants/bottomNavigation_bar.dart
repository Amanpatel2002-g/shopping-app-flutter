// ignore: file_names
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../features/screens/account/screens/account_page.dart';
import '../features/screens/home/screens/home_screen.dart';
import '../providers/user_provider.dart';
import 'global_variables.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);
  static const String routeName = '/';
  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarwidth = 42;
  double bottombarBorderWidth = 5;

  List<Widget> pages = [
    const HomeScreen(),
    const AccountScreen(),
    const Center(
      child: Text("This is shopping cart page"),
    ),
  ];

  void updatePages(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userCartLen = context.watch<UserProvider>().user.cart.length;
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        iconSize: 28,
        onTap: updatePages,
        items: [
          BottomNavigationBarItem(
              icon: Container(
                width: bottomBarwidth,
                // HomePage
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        color: _page == 0
                            ? GlobalVariables.selectedNavBarColor
                            : GlobalVariables.backgroundColor,
                        width: bottombarBorderWidth),
                  ),
                ),
                child: const Icon(Icons.home_outlined),
              ),
              label: ' '),
          // Account or profile
          BottomNavigationBarItem(
              icon: Container(
                width: bottomBarwidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        color: _page == 1
                            ? GlobalVariables.selectedNavBarColor
                            : GlobalVariables.backgroundColor,
                        width: bottombarBorderWidth),
                  ),
                ),
                child: const Icon(Icons.person_outline_outlined),
              ),
              label: ' '),
          // cart
          BottomNavigationBarItem(
              icon: Container(
                width: bottomBarwidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        color: _page == 2
                            ? GlobalVariables.selectedNavBarColor
                            : GlobalVariables.backgroundColor,
                        width: bottombarBorderWidth),
                  ),
                ),
                child: Badge(
                  elevation: 0,
                  badgeContent: Text(userCartLen.toString()),
                  badgeColor: Colors.white,
                  child: const Icon(Icons.shopping_cart_outlined),
                ),
              ),
              label: ' '),
        ],
      ),
    );
  }
}
