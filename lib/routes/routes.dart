import 'package:amazon_new/constants/bottomNavigation_bar.dart';
import 'package:amazon_new/features/admin/screen/add_product_screen.dart';
import 'package:amazon_new/features/product_details/screens/product_detail_screen.dart';
import 'package:amazon_new/features/screens/home/screens/category_deals_screen.dart';
import 'package:amazon_new/models/product_model.dart';
// import 'package:amazon_new/features/screens/search_screen/search_screen.dart';
import 'package:flutter/material.dart';

import '../features/screens/auth/auth_screen.dart';
import '../features/screens/home/screens/home_screen.dart';
import '../features/screens/search/screens/search_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case CategoryDeals.routeName:
      String category = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => CategoryDeals(category: category));
    case ProductDetailsScreen.routeName:
    final Product product = routeSettings.arguments as Product;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => ProductDetailsScreen(product: product));
    case SearchScreen.routeName:
      String searchQuerry = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => SearchScreen(searchQuerry: searchQuerry));
    case AuthScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AuthScreen());
    case BottomBar.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const BottomBar());
    case AddProductPage.routename:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AddProductPage());
    case HomeScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const HomeScreen());
    default:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text("Screen doesn't exist"),
                ),
              ));
  }
}
