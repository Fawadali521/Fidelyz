import 'package:fidelyz/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFieldEmail extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final String? initialText;
  TextEditingController? controller;
  Function(String)? onFieldSubmitted;
  FocusNode? focusNode;
  final bool makeReadOnly;

  TextFieldEmail({
    Key? key,
    this.onChanged,
    this.initialText,
    this.makeReadOnly = false,
    this.controller,
    this.onFieldSubmitted,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SizedBox(
      width: width - 40,
      // height: 50,
      child: TextFormField(
        readOnly: makeReadOnly,
        controller: controller,
        onChanged: onChanged,
        style: TextStyles().textFieldWhite,
        cursorColor: Colors.white,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        focusNode: focusNode,
        decoration: InputDecoration(
          isDense: true,
          hintText: initialText ?? "EnterYourEmail".tr,
          suffixIcon: const Icon(
            Icons.mail,
            color: Palette.secondaryColor,
          ),
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
