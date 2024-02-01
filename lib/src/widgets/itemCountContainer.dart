import 'package:flutter/material.dart';

import '../../../../../styles.dart';

/// NOTE : Keyboard Type : 0 for only number , 1 for text
class ItemCountContainer extends StatefulWidget {
  TextEditingController? textController;
  final String hint;
  bool? isEnable;
  int? keyBoardType;
  int? maxLines;
  String? discount;
  IconData? suffixIcon;
  VoidCallback? onTap;
  Color? borderClr;
  Widget? prefixIcon;
  Function(String)? onChanged;
  VoidCallback? onSuffixTap;
  ItemCountContainer(
      {super.key,
      required this.hint,
      this.discount,
      this.borderClr,
      this.maxLines,
      this.suffixIcon,
      this.onTap,
      this.isEnable = true,
      this.textController,
      this.keyBoardType,
      this.prefixIcon,
      this.onChanged,
      this.onSuffixTap});

  @override
  State<ItemCountContainer> createState() => _ItemCountContainerState();
}

class _ItemCountContainerState extends State<ItemCountContainer> {
  @override
  Widget build(BuildContext context) {
    widget.maxLines ??= 1;
    widget.discount ??= '';
    widget.suffixIcon ??= null;
    widget.borderClr ??= Palette.whiteColorWithOpacity;
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: 56,
      // margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white.withOpacity(0.06),
      ),
      child: Center(
        child: TextFormField(
          maxLines: widget.maxLines,
          controller: widget.textController,
          onChanged: widget.onChanged,
          // (value) {
          // setState(() {
          //   if (widget.textController != null) {
          //     widget.textController!.text = value;
          //   }
          //   if (widget.onTap != null) widget.onTap!();
          // });
          // },
          onTap: () {
            setState(() {
              if (widget.onTap != null) widget.onTap!();
            });
          },
          enabled: widget.isEnable,
          style: TextStyles.inputTextStyle,
          keyboardType: widget.keyBoardType == 0
              ? TextInputType.number
              : TextInputType.text,
          decoration: InputDecoration(
            hintText: "${widget.hint} ${widget.discount}",
            hintStyle: TextStyles().textFieldHintWhite1,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: const EdgeInsets.only(left: 16, top: 15),
            suffixIcon: GestureDetector(
              onTap: widget.onSuffixTap,
              child: SizedBox(
                height: height,
                child: Icon(
                  widget.suffixIcon,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            prefixIcon: widget.suffixIcon != null
                ? SizedBox(
                    height: height,
                    child: widget.prefixIcon,
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
