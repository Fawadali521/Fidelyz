import 'package:flutter/material.dart';

import '../../styles.dart';

class PasswordField extends StatelessWidget {
  final String hint;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final VoidCallback onObscureTextChange;
  TextEditingController? controller;
  FocusNode? focusNode;
  Function(String)? onSubmit;

  PasswordField(
      {super.key,
        required this.hint,
        this.onChanged,
        this.controller,
        this.obscureText = true,
        required this.onObscureTextChange,
        this.focusNode,
        this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      controller: controller,
      autofocus: false,
      obscureText: obscureText ? true : false,
      focusNode: focusNode,
      style: TextStyles().textFieldWhite,
      cursorColor: Colors.white,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        isDense: true,
        hintText: hint,
        prefixIcon: const Icon(
          Icons.lock,
          color: Palette.secondaryColor,
        ),
        hintStyle: TextStyles.textFieldHintWhite,
        border: const OutlineInputBorder(
          borderRadius: BorderStyles.norm2,
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.08),
        suffixIcon: GestureDetector(
          onTap: onObscureTextChange,
          child: Icon(
            obscureText ? Icons.remove_red_eye : Icons.remove_red_eye_outlined,
            color: obscureText ? Palette.secondaryColor : Colors.white,
            size: 20,
          ),
        ),
        contentPadding:
        const EdgeInsets.symmetric(vertical: 14.0, horizontal: 12),
      ),
      onFieldSubmitted: onSubmit,
    );
  }
}
