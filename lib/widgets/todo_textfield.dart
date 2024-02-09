import 'package:flutter/material.dart';

class TodoTextfield extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final TextInputAction? inputAction;
  final int maxLines;
  const TodoTextfield({
    super.key,
    required this.controller,
    required this.hint,
    this.inputAction,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      textInputAction: inputAction,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.orange,
            ),),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.orange,
            ),),
        hintText: hint,
      ),
    );
  }
}
