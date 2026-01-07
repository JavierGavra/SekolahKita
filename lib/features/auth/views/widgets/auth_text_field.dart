import 'package:flutter/material.dart';
import 'package:sekolah_kita/core/utils/valdator/input_validator.dart';

class AuthTextField extends StatefulWidget {
  final bool isPassword;
  final String label;
  final IconData prefixIcon;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const AuthTextField({
    super.key,
    required this.label,
    required this.prefixIcon,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
  }) : isPassword = false;

  const AuthTextField.password({
    super.key,
    required this.label,
    required this.controller,
    this.validator,
  }) : prefixIcon = Icons.lock_outline_rounded,
       isPassword = true,
       keyboardType = TextInputType.visiblePassword;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool _isVisible = false;

  InputBorder _border(Color color) => OutlineInputBorder(
    borderSide: BorderSide(color: color),
    borderRadius: BorderRadius.circular(10),
  );

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return TextFormField(
      controller: widget.controller,
      textInputAction: TextInputAction.next,
      obscureText: widget.isPassword && !_isVisible,
      enableSuggestions: !widget.isPassword,
      keyboardType: widget.keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator:
          widget.validator ?? (value) => InputValidator().emptyValidator(value),
      decoration: InputDecoration(
        errorMaxLines: 1,
        helperText: ' ',
        floatingLabelBehavior: FloatingLabelBehavior.never,
        label: Text(
          widget.label,
          style: TextStyle(
            color: color.onSurfaceVariant.withValues(alpha: 0.5),
          ),
        ),
        border: _border(color.primary),
        enabledBorder: _border(color.primary),
        focusedBorder: _border(color.primary),
        errorBorder: _border(color.error),
        prefixIcon: Icon(widget.prefixIcon),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () => setState(() => _isVisible = !_isVisible),
                icon: Icon(
                  _isVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
              )
            : null,
      ),
    );
  }
}
