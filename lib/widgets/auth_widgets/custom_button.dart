// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String text;
  final VoidCallback ontap;
  final Color? color;
  CustomButton({
    Key? key,
    required this.text,
    required this.ontap,
    this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: ontap,
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          surfaceTintColor: const Color.fromARGB(255, 164, 107, 15),
          primary: color),
      child: Text(
        text,
        style: TextStyle(color: color == null ? Colors.white : Colors.black),
      ),
    );
  }
}
