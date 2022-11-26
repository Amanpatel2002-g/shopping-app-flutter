import 'package:amazon_new/constants/global_variables.dart';
import 'package:amazon_new/features/screens/home/screens/category_deals_screen.dart';
import 'package:flutter/material.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({Key? key}) : super(key: key);

  void navigateToCategoryDeals(String category, BuildContext context) {
    Navigator.pushNamed(context, CategoryDeals.routeName, arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemExtent: 85,
          itemCount: GlobalVariables.categoryImages.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => navigateToCategoryDeals(
                  GlobalVariables.categoryImages[index]['title']!, context),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        GlobalVariables.categoryImages[index]['image']!,
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ),
                  Text(
                    GlobalVariables.categoryImages[index]['title']!,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w400),
                  )
                ],
              ),
            );
          }),
    );
  }
}
