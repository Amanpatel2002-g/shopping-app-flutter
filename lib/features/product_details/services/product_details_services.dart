import 'dart:convert';

import 'package:amazon_new/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:amazon_new/constants/error_handling.dart';
import 'package:amazon_new/constants/utils.dart';
import 'package:amazon_new/models/product_model.dart';
import 'package:amazon_new/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../constants/global_variables.dart';
import '../../../providers/user_provider.dart';

class ProductDetailsServices {
  void rateProduct({
    required BuildContext context,
    required Product product,
    required double ratings,
  }) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res =
          await http.post(Uri.parse('$uri/auth/products/rate-product'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'token': userprovider.user.token
              },
              body: jsonEncode({
                'id': product.id!,
                'ratings': ratings,
              }));
      httpErrorHandling(
          context: context,
          response: res,
          onSuccess: () {
            showSnackbar(context, 'Product Added Successfully');
            Navigator.pop(context);
          });
      print(res.body);
    } catch (e) {
      showSnackbar(context, e.toString());
      print(e.toString());
    }
  }

  void addToCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    try {
      print(userprovider.user.token);
      http.Response res =
          await http.post(Uri.parse('$uri/auth/add-to-cart'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'token': userprovider.user.token
              },
              body: jsonEncode({
                'id': product.id!,
              }));
      httpErrorHandling(
          context: context,
          response: res,
          onSuccess: () {
            UserModel user =
                userprovider.user.copyWith(cart: jsonDecode(res.body)['cart']);
            userprovider.setUserFromModel(user);
          });
      print(res.body);
    } catch (e) {
      showSnackbar(context, e.toString());
      print(e.toString());
    }
  }
}
