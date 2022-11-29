import 'dart:convert';

import 'package:amazon_new/constants/error_handling.dart';
import 'package:amazon_new/constants/global_variables.dart';
import 'package:amazon_new/constants/utils.dart';
import 'package:amazon_new/models/user_model.dart';
import 'package:amazon_new/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../../models/product_model.dart';

class CartServices {
  Future<void> reduceQuantity(BuildContext context, Product product) async {
    try {
      final userprovider = Provider.of<UserProvider>(context, listen: false);
      print(userprovider.user.token);
      http.Response res = await http.delete(
        Uri.parse('$uri/auth/reduce-quantity/${product.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': userprovider.user.token,
        },
      );
      print('using the reduce quantity');
      print(res.body);
      httpErrorHandling(
          context: context,
          response: res,
          onSuccess: () {
            UserModel user =
                userprovider.user.copyWith(cart: jsonDecode(res.body)['cart']);
            userprovider.setUserFromModel(user);
          });
    } catch (e) {
      print("This is the error from reduce quantity\n");
      print(e);
      showSnackbar(context, e.toString());
    }
  }
}
