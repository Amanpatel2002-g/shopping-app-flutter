import 'package:amazon_new/constants/loader.dart';
import 'package:amazon_new/features/product_details/screens/product_detail_screen.dart';
import 'package:amazon_new/features/screens/home/services/home_services.dart';
import 'package:amazon_new/models/product_model.dart';
import 'package:flutter/material.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({Key? key}) : super(key: key);

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  Product? product;
  @override
  HomeServcies homeServcies = HomeServcies();
  void fetchDealOfDay(BuildContext context) async {
    product = await homeServcies.fetchDealOfTheDay(contextreal: context);
    setState(() {});
  }

  void NavigateToProductScreen(BuildContext context) {
    Navigator.pushNamed(context, ProductDetailsScreen.routeName,
        arguments: product);
  }

  @override
  void initState() {
    super.initState();
    fetchDealOfDay(context);
  }

  Widget build(BuildContext context) {
    return product == null
        ? const Loader()
        : GestureDetector(
            onTap: () => NavigateToProductScreen(context),
            child: Container(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(left: 10, top: 15),
                    child: const Text(
                      "DealOfDay",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Image.network(
                    product!.images[0],
                    height: 235,
                    fit: BoxFit.fitHeight,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 15),
                    alignment: Alignment.topLeft,
                    child: const Text(
                      "\$100",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(left: 15, top: 5, right: 40),
                    child: const Text(
                      'rivaan',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: product!.images
                          .map((e) => Image.network(e,
                              fit: BoxFit.fitWidth, width: 100, height: 100))
                          .toList(),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15)
                        .copyWith(left: 15),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'See all deals',
                      style: TextStyle(
                        color: Colors.cyan[800],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
