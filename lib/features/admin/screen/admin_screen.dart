import 'package:amazon_new/features/admin/screen/post_screen.dart';
import 'package:flutter/material.dart';
import '../../../constants/global_variables.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  int _page = 0;
  double bottomBarwidth = 42;
  double bottombarBorderWidth = 5;

  List<Widget> pages = [
    const PostsScren(),
    const Center(
      child: Text("Analytics page"),
    ),
    const Center(
      child: Text("cart page"),
    ),
  ];

  void updatePages(int page) {
    setState(() {
      _page = page;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  height: 45,
                  width: 120,
                  child: Image.asset('assets/images/amazon_in.png',
                      color: Colors.black),
                ),
              ),
              Container(
                child: const Text(
                  "Admin",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
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
                child: const Icon(Icons.all_inbox_outlined),
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
                child: const Icon(Icons.analytics_outlined),
              ),
              label: ' '),
          // orders
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
                child: const Icon(Icons.home_outlined),
              ),
              label: ' '),
          // cart
        ],
      ),
    );
  }
}
