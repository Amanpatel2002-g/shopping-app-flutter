import 'dart:convert';
import 'dart:io';
import 'package:amazon_new/constants/error_handling.dart';
import 'package:amazon_new/constants/utils.dart';
import 'package:amazon_new/models/product_model.dart';
import 'package:amazon_new/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../constants/global_variables.dart';
import '../../../providers/user_provider.dart';
import '../../../services/auth_service.dart';

// all of the imports statements are here.

class AdminServices {
  // GlobalVariables globalVariables =
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('dlbvsohjy', 'ztfh6085');
      List<String> imagesUrls = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name));
        imagesUrls.add(res.secureUrl);
      }
      Product product = Product(
          name: name,
          description: description,
          quantity: quantity,
          images: imagesUrls,
          category: category,
          price: price);
      http.Response res = await http.post(Uri.parse('$uri/admin/add-product'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': userprovider.user.token
          },
          body: product.toJson());
      httpErrorHandling(
          context: context,
          response: res,
          onSuccess: () {
            showSnackbar(context, 'Product Added Successfully');
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackbar(context, e.toString());
      print(e.toString());
    }
  }

  Future<List<Product>> fetchAllProduct(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/admin/get-products'), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': userProvider.user.token
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

  void deleteProduct(
      {required BuildContext context,
      required Product product,
      required VoidCallback onSuccess}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res =
          await http.post(Uri.parse('$uri/admin/delete-product'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.token
              },
              body: jsonEncode({'id': product.id}));

      httpErrorHandling(context: context, response: res, onSuccess: onSuccess);
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }
}
