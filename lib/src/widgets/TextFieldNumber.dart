import 'package:fidelyz/infos.dart';
import 'package:fidelyz/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFieldNumber extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final String? initialText;
  final Function(String?)? onDropDownChanged;
  TextEditingController? controller;
  final String? dropDownValue;
  FocusNode? focusNode;
  Function(String)? onFieldSubmitted;
  final bool makeReadOnly;


  TextFieldNumber({
    Key? key,
    this.onChanged,
    this.initialText,
    this.controller,
    this.makeReadOnly = false,
    this.onDropDownChanged,
    this.dropDownValue,
    this.focusNode,
    this.onFieldSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Container(
            width: 55,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderStyles.norm2,
              color: Colors.white.withOpacity(0.15),
            ),
            child: Center(
              child: Theme(
                data: Theme.of(context)
                    .copyWith(canvasColor: Palette.primaryColor),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    focusColor: Colors.white.withOpacity(0.15),
                    value: dropDownValue,
                    underline: Container(),
                    icon: const SizedBox.shrink(),
                    style: TextStyles().numberDropDownWhite,
                    onChanged: onDropDownChanged,
                    items: Infos()
                        .dropdownItems
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3.0, right: 3),
                          child: Text(
                            value,
                            style: TextStyles().textFieldWhite,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: width - 40 - 50 - 15,
          // height: 50,
          child: TextFormField(
            readOnly: makeReadOnly ,
            controller: controller,
            keyboardType: TextInputType.number,
            onChanged: onChanged,
            style: TextStyles().textFieldWhite,
            cursorColor: Colors.white,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            focusNode: focusNode,
            decoration: InputDecoration(
              isDense: true,
              hintText: initialText ?? "EnterYourPhoneNumber".tr,
              suffixIcon: const Icon(
                Icons.phone,
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
        ),
      ],
    );
  }
}
