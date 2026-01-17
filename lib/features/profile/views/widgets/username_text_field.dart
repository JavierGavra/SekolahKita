import 'package:flutter/material.dart';
import 'package:sekolah_kita/core/utils/valdator/input_validator.dart';

class UsernameTextField extends StatelessWidget {
  final TextEditingController controller;

  const UsernameTextField({super.key, required this.controller});

  InputBorder _border(Color color) => OutlineInputBorder(
    borderSide: BorderSide(color: color),
    borderRadius: BorderRadius.circular(10),
  );

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return TextFormField(
      controller: controller,
      textInputAction: TextInputAction.next,
      enableSuggestions: true,
      keyboardType: TextInputType.text,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => InputValidator().emptyValidator(value),
      decoration: InputDecoration(
        errorMaxLines: 1,
        helperText: ' ',
        floatingLabelBehavior: FloatingLabelBehavior.never,
        label: Text(
          "Nama kamu...",
          style: TextStyle(
            color: color.onSurfaceVariant.withValues(alpha: 0.5),
          ),
        ),
        border: _border(color.primary),
        enabledBorder: _border(color.primary),
        focusedBorder: _border(color.primary),
        errorBorder: _border(color.error),
      ),
    );
  }
}
