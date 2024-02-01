import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../styles.dart';

class TextFieldMaps extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final String hint;
  final FocusNode? focusNode;
  const TextFieldMaps(
      {super.key, this.onChanged, required this.hint,this.controller,this.focusNode});

  @override
  State<TextFieldMaps> createState() => _TextFieldMapsState();
}

class _TextFieldMapsState extends State<TextFieldMaps> {
  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    return TextField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      onChanged: widget.onChanged,
      style: TextStyles().textField.copyWith(color: Colors.white.withOpacity(0.6)),
      cursorColor: Colors.white.withOpacity(0.6),
      decoration: InputDecoration(
        isDense: true,
        hintText: widget.hint,
        hintStyle: TextStyles().smallHeadingLightGray,
        border: InputBorder.none,
        prefixIcon: Image.asset(
          'assets/icons/search.png',
          color: Colors.white.withOpacity(0.6),
        ),
      ),
    );
  }
}