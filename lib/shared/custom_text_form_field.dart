import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.controller, required this.validationText});
  final TextEditingController controller;
  final String validationText;
  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return validationText;
                }
                return null;
              },
              controller:  controller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                )
              ),
            ),
    );
  }
}