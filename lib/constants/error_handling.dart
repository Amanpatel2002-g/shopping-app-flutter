import 'dart:convert';

import 'package:amazon_new/constants/utils.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;

void httpErrorHandling(
    {required BuildContext context,
    required http.Response response,
    required VoidCallback onSuccess}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      
      showSnackbar(context, jsonDecode(response.body)["msg"]);
      break;
    case 500:
      // print(jsonDecode(response.body));
      showSnackbar(context, jsonDecode(response.body)["err"]);
      break;
    default:
      print(response.body);
      showSnackbar(context, response.body);
  }
}
