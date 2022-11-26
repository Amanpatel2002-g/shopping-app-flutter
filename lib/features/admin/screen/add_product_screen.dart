import 'dart:io';

import 'package:amazon_new/constants/utils.dart';
import 'package:amazon_new/features/admin/services/admin_service.dart';
import 'package:amazon_new/widgets/auth_widgets/custom_button.dart';
import 'package:amazon_new/widgets/auth_widgets/text_input_filed.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';
import '../../../widgets/auth_widgets/text_input_filed.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);
  static const String routename = "/add-product";
  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController _productTextEditingController =
      TextEditingController();
  final TextEditingController _descriptionTextEditingController =
      TextEditingController();
  final TextEditingController _priceTextEditingController =
      TextEditingController();
  final TextEditingController _quantityTextEditingController =
      TextEditingController();
  List<File> images = [];
  final AdminServices adminServices = AdminServices();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _priceTextEditingController.dispose();
    _descriptionTextEditingController.dispose();
    _quantityTextEditingController.dispose();
    _productTextEditingController.dispose();
  }

  void sellProducts(BuildContext context, String name, String description,
      double price, double quantity, String category, List<File> images) {
    adminServices.sellProduct(
        context: context,
        name: name,
        description: description,
        price: price,
        quantity: quantity,
        category: category,
        images: images);
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  String category = "Mobiles";
  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
            title: const Text(
              'Add Product',
              style: TextStyle(color: Colors.black),
            )),
      ),
      body: SingleChildScrollView(
          child: Form(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(children: [
            const SizedBox(
              height: 20,
            ),
            // images.isNotEmpty
            images.isNotEmpty
                ? CarouselSlider(
                    items: images.map((i) {
                      return Builder(
                        builder: (BuildContext context) => Image.file(
                          i,
                          fit: BoxFit.cover,
                        ),
                      );
                    }).toList(),
                    options: CarouselOptions(
                      viewportFraction: 1,
                      height: 200,
                    ))
                : GestureDetector(
                    onTap: selectImages,
                    child: DottedBorder(
                      radius: const Radius.circular(10),
                      borderType: BorderType.RRect,
                      dashPattern: const [10, 4],
                      strokeCap: StrokeCap.round,
                      child: Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.folder_open_outlined),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Select Product Images',
                              style: TextStyle(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
            const SizedBox(
              height: 30,
            ),
            TextInputField(
                textEditingController: _productTextEditingController,
                hinttext: "Product Name"),
            const SizedBox(
              height: 10,
            ),
            TextInputField(
              textEditingController: _descriptionTextEditingController,
              hinttext: "Product Description",
              maxLines: 7,
            ),
            const SizedBox(
              height: 10,
            ),
            TextInputField(
                textEditingController: _priceTextEditingController,
                hinttext: "Price"),
            const SizedBox(
              height: 10,
            ),
            TextInputField(
                textEditingController: _quantityTextEditingController,
                hinttext: "Quantity"),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              child: DropdownButton(
                value: category,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: productCategories.map((String item) {
                  return DropdownMenuItem(value: item, child: Text(item));
                }).toList(),
                onChanged: (String? Value) {
                  setState(() {
                    category = Value!;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomButton(
                text: "Sell",
                ontap: () => sellProducts(
                    context,
                    _productTextEditingController.text,
                    _descriptionTextEditingController.text,
                    double.parse(_priceTextEditingController.text),
                    double.parse(_quantityTextEditingController.text),
                    category,
                    images))
          ]),
        ),
      )),
    );
  }
}
