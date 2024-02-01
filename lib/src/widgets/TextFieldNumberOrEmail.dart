import 'package:fidelyz/infos.dart';
import 'package:fidelyz/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFieldNumberOrEmail extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  TextEditingController? controller;
  String? phoneCode;
  bool isNumber;
  Function(String?)? onPhoneCodeChange;
  FocusNode? focusNode;
  Function(String)? onFieldSubmitted;

  TextFieldNumberOrEmail(
      {super.key,
      this.onChanged,
      this.controller,
      this.phoneCode = '+241',
      this.isNumber = false,
      required this.onPhoneCodeChange,
      this.focusNode,
      this.onFieldSubmitted});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // if (isNumber)
        //   Padding(
        //     padding: const EdgeInsets.only(right: 10.0),
        //     child: Container(
        //       width: 55,
        //       height: 50,
        //       decoration: BoxDecoration(
        //         borderRadius: BorderStyles.norm2,
        //         color: Colors.white.withOpacity(0.15),
        //       ),
        //       child: Center(
        //         child: Theme(
        //           data: Theme.of(context)
        //               .copyWith(canvasColor: Palette.primaryColor),
        //           child: DropdownButtonHideUnderline(
        //             child: DropdownButton<String>(
        //               focusColor: Colors.white.withOpacity(0.15),
        //               value: phoneCode,
        //               underline: Container(),
        //               icon: const SizedBox.shrink(),
        //               style: TextStyles().numberDropDownWhite,
        //               onChanged: onPhoneCodeChange,
        //               items: Infos()
        //                   .dropdownItems
        //                   .map<DropdownMenuItem<String>>((String value) {
        //                 return DropdownMenuItem<String>(
        //                   value: value,
        //                   child: Padding(
        //                     padding: const EdgeInsets.only(top: 3.0, right: 3),
        //                     child: Text(
        //                       value,
        //                       style: TextStyles().textFieldWhite,
        //                       textAlign: TextAlign.center,
        //                     ),
        //                   ),
        //                 );
        //               }).toList(),
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        SizedBox(
          width:  width - 40,
          child: TextFormField(
            autofocus: false,
            onChanged: onChanged,
            controller: controller,
            focusNode: focusNode,
            style: TextStyles().textFieldWhite,
            // cursorColor: Palette.primaryColor,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            cursorColor: Colors.white,
            decoration: InputDecoration(
              isDense: true,
              hintText: isNumber
                  ? 'EnterYourPhoneNumber'.tr
                  : 'EnterYourNumberOrEmail'.tr,
              suffixIcon: isNumber
                  ? const Icon(
                      Icons.phone,
                      color: Palette.secondaryColor,
                    )
                  : (controller!.text.isNotEmpty && isNumber == false)
                      ? const Icon(
                          Icons.mail,
                          color: Palette.secondaryColor,
                        )
                      : null,
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
              // fillColor: Palette.primaryColor.withOpacity(0.05),
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
