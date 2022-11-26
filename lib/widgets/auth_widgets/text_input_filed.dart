// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  TextEditingController textEditingController;
  String hinttext;
  final int maxLines;
  TextInputField({
    Key? key,
    required this.textEditingController,
    required this.hinttext,
    this.maxLines = 1
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hinttext,
        hintStyle: const TextStyle(color: Colors.black),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter your $hinttext';
        }
        return null;
      },
      maxLines: maxLines,
    );
  }
}
