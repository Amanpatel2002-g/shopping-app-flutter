import 'dart:math';

import 'package:amazon_new/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants/global_variables.dart';
import '../../../../widgets/auth_widgets/custom_button.dart';
import '../../../../widgets/auth_widgets/text_input_filed.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  TextEditingController _flatTextEditingController = TextEditingController();
  TextEditingController _areaTextEditingController = TextEditingController();
  TextEditingController _pincodeTextEditingControlle = TextEditingController();
  TextEditingController _cityTextEditingControlle = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _flatTextEditingController.dispose();
    _areaTextEditingController.dispose();
    _pincodeTextEditingControlle.dispose();
    _cityTextEditingControlle.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String address = "123 Fake Street New York";
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration:
              const BoxDecoration(gradient: GlobalVariables.appBarGradient),
        ),
      ),
      body: SingleChildScrollView(
          child: Form(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(children: [
            const SizedBox(
              height: 30,
            ),
            if (address.isNotEmpty)
              Container(
                width: double.infinity,
                height: 40,
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.only(left: 10),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    border: Border.all(color: Color.fromARGB(31, 6, 5, 5))),
                child: Text(
                  address,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 19),
                ),
              ),
            Container(
              height: 40,
              width: double.infinity,
              alignment: Alignment.center,
              child: const Text(
                "OR",
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextInputField(
                textEditingController: _flatTextEditingController,
                hinttext: "Flat, HouseNo"),
            const SizedBox(
              height: 10,
            ),
            TextInputField(
              textEditingController: _areaTextEditingController,
              hinttext: "Area, Street",
            ),
            const SizedBox(
              height: 10,
            ),
            TextInputField(
                textEditingController: _pincodeTextEditingControlle,
                hinttext: "pincode"),
            const SizedBox(
              height: 10,
            ),
            TextInputField(
                textEditingController: _cityTextEditingControlle,
                hinttext: "Town/City"),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
          ]),
        ),
      )),
    );
  }
}
