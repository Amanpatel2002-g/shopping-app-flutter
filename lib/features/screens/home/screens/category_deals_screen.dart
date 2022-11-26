// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amazon_new/constants/loader.dart';
import 'package:amazon_new/features/product_details/screens/product_detail_screen.dart';
import 'package:amazon_new/features/screens/home/services/home_services.dart';
import 'package:amazon_new/models/product_model.dart';
import 'package:flutter/material.dart';

import '../../../../constants/global_variables.dart';

class CategoryDeals extends StatefulWidget {
  static const String routeName = "/CategoryDeals";
  final String category;
  const CategoryDeals({
    Key? key,
    required this.category,
  }) : super(key: key);
  @override
  State<CategoryDeals> createState() => _CategoryDealsState();
}

class _CategoryDealsState extends State<CategoryDeals> {
  List<Product>? productList;
  final HomeServcies homeServcies = HomeServcies();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCategoryProducts();
  }



  void fetchCategoryProducts() async {
    productList = await homeServcies.fetchCateogoryProducts(
        contextreal: context, cateogory: widget.category);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Text(
            widget.category,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: productList == null
          ? const Loader()
          : Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'keep Shopping for ${widget.category}',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 170,
                  child: productList!.isEmpty?Container():GridView.builder(
                      itemCount: productList!.length,
                      scrollDirection: Axis.horizontal,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              childAspectRatio: 1.4,
                              mainAxisSpacing: 10),
                      itemBuilder: ((context, index) {
                        final product = productList![index];
                        return GestureDetector(
                          onTap:() {
                            Navigator.pushNamed(context, ProductDetailsScreen.routeName, arguments: product);
                          }, 
                          child: Column(
                            children: [
                              SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Image.network(product.images[0]),
                                ),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                padding: const EdgeInsets.only(
                                    left: 0, top: 5, right: 15),
                                child: Text(
                                  product.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                        );
                      })),
                ),
              ],
            ),
    );
  }
}
