import 'package:amazon_new/features/screens/home/widgets/address_box.dart';
import 'package:amazon_new/features/screens/home/widgets/carousel_image.dart';
import 'package:amazon_new/features/screens/home/widgets/deal_of_day.dart';
import 'package:amazon_new/features/screens/home/widgets/top_categories.dart';
// import 'package:amazon_new/features/screens/search_screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants/global_variables.dart';
import '../../../../providers/user_provider.dart';
import '';
import '../../search/screens/search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = "/home";

  void NavigateToSearch(BuildContext context, String searchQuery) {
    Navigator.pushNamed(context, SearchScreen.routeName,
        arguments: searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                    height: 42,
                    margin: const EdgeInsets.only(left: 15),
                    child: Material(
                      borderRadius: BorderRadius.circular(7),
                      elevation: 1,
                      child: TextFormField(
                        onFieldSubmitted: (value) =>
                            NavigateToSearch(context, value),
                        decoration: InputDecoration(
                            prefixIcon: InkWell(
                              onTap: () {},
                              child: const Padding(
                                padding: EdgeInsets.only(left: 6),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                  size: 23,
                                ),
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.only(top: 10),
                            border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(7),
                                ),
                                borderSide: BorderSide.none),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(7),
                              ),
                              borderSide: BorderSide(
                                color: Colors.black38,
                                width: 1,
                              ),
                            ),
                            hintText: "Search Amazon.in",
                            hintStyle: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 17)),
                      ),
                    )),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: const Icon(Icons.mic, color: Colors.black, size: 25),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            AddressBox(),
            SizedBox(height: 10),
            TopCategories(),
            // SizedBox(height: 5),
            CarouselImage(),
            DealOfDay(),
          ],
        ),
      ),
    );
  }
}
