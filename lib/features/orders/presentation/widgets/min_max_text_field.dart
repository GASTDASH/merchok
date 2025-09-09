import 'package:flutter/material.dart';

class MinMaxTextField extends StatelessWidget {
  const MinMaxTextField({super.key, this.controller, this.onChanged});

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: TextField(
        controller: controller,

        onChanged: onChanged,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
