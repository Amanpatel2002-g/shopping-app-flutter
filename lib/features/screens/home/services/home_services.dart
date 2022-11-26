import 'dart:convert';
import 'dart:developer';
import 'package:amazon_new/constants/error_handling.dart';
import 'package:amazon_new/constants/utils.dart';
import 'package:amazon_new/models/product_model.dart';
import 'package:amazon_new/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../../constants/global_variables.dart';

class HomeServcies {
  Future<List<Product>> fetchCateogoryProducts(
      {required BuildContext contextreal, required String cateogory}) async {
    final userProvider = Provider.of<UserProvider>(contextreal, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
          Uri.parse('$uri/auth/products?category=$cateogory'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': userProvider.user.token
          });
      print(jsonDecode(res.body));
      httpErrorHandling(
          context: contextreal,
          response: res,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              // ignore: unnecessary_null_comparison
              productList
                  .add(Product.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e) {
      print(e.toString());
      showSnackbar(contextreal, e.toString());
    }
    return productList;
  }
}
