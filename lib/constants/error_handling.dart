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
      print("This is from http ErrorHandling case:400 \n");
      print("The message is\n");
      print(jsonDecode(response.body)["msg"]);

      showSnackbar(context, jsonDecode(response.body)["message"]);
      break;
    case 500:
      // print(jsonDecode(response.body));
      print("This is from http ErrorHandling case:500\n");

      showSnackbar(context, jsonDecode(response.body)["err"]);
      break;
    default:
      print("This is from http ErrorHandling case:default\n");
      print(response.body);
      showSnackbar(context, response.body);
  }
}
