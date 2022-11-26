import 'dart:convert';
import 'package:amazon_new/constants/error_handling.dart';
import 'package:amazon_new/constants/utils.dart';
import 'package:amazon_new/models/product_model.dart';
import 'package:amazon_new/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../../constants/global_variables.dart';

class SearchServcies {
  Future<List<Product>> fetchSearchedProducts(
      {required BuildContext context, required String searchQuery}) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
          Uri.parse('$uri/auth/products/search/$searchQuery'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': userprovider.user.token
          });
      httpErrorHandling(
          context: context,
          response: res,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              // ignore: unnecessary_null_comparison
              productList
                  .add(Product.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
    return productList;
  }
}
