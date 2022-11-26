// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amazon_new/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Stars extends StatelessWidget {
  const Stars({
    Key? key,
    required this.ratings,
  }) : super(key: key);
  final double ratings;
  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      direction: Axis.horizontal,
      itemCount: 5,
      rating: ratings,
      itemSize: 15,
      itemBuilder: (context, index) => const Icon(
        Icons.star,
        color: GlobalVariables.secondaryColor,
      ),
    );
  }
}
