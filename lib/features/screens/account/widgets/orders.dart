import 'package:amazon_new/constants/global_variables.dart';
import 'package:amazon_new/features/screens/account/widgets/single_product.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List list = [
    'https://images.unsplash.com/photo-1484589065579-248aad0d8b13?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8bmFzYXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1484589065579-248aad0d8b13?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8bmFzYXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1484589065579-248aad0d8b13?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8bmFzYXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1484589065579-248aad0d8b13?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8bmFzYXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              child: const Text(
                " your orders",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 15),
              child: Text(
                " your orders",
                style: TextStyle(color: GlobalVariables.selectedNavBarColor),
              ),
            ),
            // ? Display orders
          ],
        ),
        Container(
          height: 170,
          padding: const EdgeInsets.only(left: 10, top: 20, right: 0),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: list.length,
              itemBuilder: ((context, index) {
                return SingleProduct(image: list[index]);
              })),
        )
      ],
    );
  }
}
