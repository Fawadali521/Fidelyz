import 'package:fidelyz/styles.dart';
import 'package:flutter/material.dart';

class TextFields extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final String hint;
  final String? initialText;
  TextEditingController? controller;
  Function(String)? onFieldSubmitted;
  FocusNode? focusNode;

  TextFields({
    Key? key,
    this.onChanged,
    required this.hint,
    this.controller,
    this.initialText,
    this.onFieldSubmitted,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width - 40,
      // height: 50,
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        focusNode: focusNode,
        style: TextStyles().textFieldWhite,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          isDense: true,
          hintText: initialText ?? hint,
          prefixIcon: const Icon(
            Icons.person,
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
          fillColor: Colors.white.withOpacity(0.15),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 14.0, horizontal: 12),
        ),
        onFieldSubmitted: onFieldSubmitted,
      ),
    );
  }
}
