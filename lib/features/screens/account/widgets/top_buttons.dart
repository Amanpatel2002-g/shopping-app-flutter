import 'package:amazon_new/features/screens/account/widgets/account_button.dart';
import 'package:flutter/material.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(text: "Your orders", ontap: () {}),
            AccountButton(text: "Turn Sellers", ontap: () {}),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            AccountButton(text: "Log out", ontap: () {}),
            AccountButton(text: "Your wish list", ontap: () {}),
          ],
        )
      ],
    );
  }
}
