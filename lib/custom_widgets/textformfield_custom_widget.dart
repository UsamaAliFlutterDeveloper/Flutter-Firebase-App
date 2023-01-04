import 'package:flutter/material.dart';

class TextFormFieldCustomWidget extends StatefulWidget {
  final String hint;
  final Icon iconss;

  final TextEditingController customController;

  const TextFormFieldCustomWidget({
    super.key,
    required this.hint,
    required this.iconss,
    required this.customController,
  });

  @override
  State<TextFormFieldCustomWidget> createState() =>
      _TextFormFieldCustomWidgetState();
}

class _TextFormFieldCustomWidgetState extends State<TextFormFieldCustomWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.customController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }

        return null;
      },
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: widget.hint,
        prefixIcon: widget.iconss,
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: const BorderSide(color: Colors.grey)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: const BorderSide(color: Colors.grey)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        fillColor: Colors.white,
        filled: true,
      ),
    );
  }
}
