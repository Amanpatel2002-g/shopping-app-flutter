import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:amazon_new/constants/bottomNavigation_bar.dart';

import '../constants/error_handling.dart';
import '../constants/global_variables.dart';
import '../constants/utils.dart';
import '../models/user_model.dart';
import '../providers/user_provider.dart';

final UserProvider userprovider = UserProvider();

class AuthServices {
  Future<void> signUp(
      {required BuildContext context,
      required String name,
      required String email,
      required String password}) async {
    try {
      UserModel user = UserModel(
          name: name,
          email: email,
          password: password,
          address: '',
          type: '',
          id: '',
          token: '',
          cart: []);
      http.Response response = await http.post(Uri.parse('$uri/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      httpErrorHandling(
          context: context,
          response: response,
          onSuccess: () {
            showSnackbar(context, "Account created successfully");
          });
    } catch (e) {
      // print(e.toString());
      showSnackbar(context, e.toString());
    }
  }

  void saveToken(BuildContext context, http.Response response) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString('x-auth-token', jsonDecode(response.body)['token']);
  }

  Future<void> signIn(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      UserModel user = UserModel(
          name: '',
          email: email,
          password: password,
          address: '',
          type: '',
          id: '',
          token: '',
          cart: []);
      http.Response response = await http.post(Uri.parse("$uri/api/signin"),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      httpErrorHandling(
          context: context,
          response: response,
          onSuccess: () async {
            saveToken(context, response);
            Provider.of<UserProvider>(context, listen: false)
                .setUser(response.body);
            showSnackbar(context, "signed in successfully");
            Navigator.pushNamedAndRemoveUntil(
                context, BottomBar.routeName, (route) => false);
          });
    } catch (e) {
      // print(e.toString());
      showSnackbar(context, e.toString());
    }
  }

  Future<void> getUserData(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      String? token = sharedPreferences.getString('x-auth-token');
      if (token == null) {
        sharedPreferences.setString('x-auth-token', '');
        return;
      }
      http.Response tokenRes = await http
          .post(Uri.parse('$uri/isTokenVerified'), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': token
      });
      bool res = jsonDecode(tokenRes.body);
      if (res == true) {
        http.Response userResponse = await http.get(Uri.parse('$uri/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'token': token
            });
        // ignore: use_build_context_synchronously
        Provider.of<UserProvider>(context, listen: false)
            .setUser(userResponse.body);
        print(userResponse.body);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
