import 'package:amazon_new/features/product_details/services/product_details_services.dart';
import 'package:amazon_new/features/screens/cart/services/cart_service.dart';
import 'package:amazon_new/models/product_model.dart';
import 'package:amazon_new/providers/user_provider.dart';
import 'package:amazon_new/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatefulWidget {
  final int index;
  const CartProduct({Key? key, required this.index}) : super(key: key);

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  ProductDetailsServices productDetailsServices = ProductDetailsServices();
  CartServices cartServices = CartServices();
  void addtoquantity(BuildContext context, Product prod) {
    productDetailsServices.addToCart(context: context, product: prod);
  }

  void reduceQuantity(BuildContext context, Product prod) {
    cartServices.reduceQuantity(context, prod);
  }

  @override
  Widget build(BuildContext context) {
    final productCart = context.watch<UserProvider>().user.cart[widget.index];
    final product = Product.fromMap(productCart['product']);
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Image.network(
                product.images[0],
                fit: BoxFit.fitHeight,
                height: 135,
                width: 135,
              ),
              Column(
                children: [
                  Container(
                    width: 235,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      product.name,
                      style: const TextStyle(fontSize: 16),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      '\$${product.price}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10),
                    child: const Text(
                      'Eligible for free shipping',
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10),
                    child: const Text(
                      'In Stock',
                      maxLines: 2,
                      style: TextStyle(color: Colors.teal),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          // width: 120,
          child: Row(
            children: [
              Container(
                height: 40,
                width: 35,
                decoration: BoxDecoration(
                  // border: Border(left: BorderSide(color: Colors.grey)),
                  borderRadius: BorderRadius.circular(3),
                  color: const Color.fromARGB(255, 203, 203, 191),
                ),
                child: IconButton(
                  iconSize: 19,
                  icon: const Icon(Icons.add),
                  onPressed: () => addtoquantity(context, product),
                ),
              ),
              DecoratedBox(
                decoration: const BoxDecoration(
                  border: Border.symmetric(
                      horizontal: BorderSide(
                          color: Colors.black12,
                          width: 5,
                          style: BorderStyle.solid)),
                ),
                child: Container(
                  height: 40,
                  width: 35,
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  child: Center(
                    child: Text(
                      context
                          .watch<UserProvider>()
                          .user
                          .cart[widget.index]['quantity']
                          .toString(),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
              Container(
                height: 40,
                width: 35,
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                  // border: Border(left: BorderSide(color: Colors.grey)),
                  borderRadius: BorderRadius.circular(3),
                  color: const Color.fromARGB(255, 203, 203, 191),
                ),
                child: IconButton(
                  iconSize: 19,
                  icon: const Icon(Icons.remove),
                  onPressed: () => reduceQuantity(context, product),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
