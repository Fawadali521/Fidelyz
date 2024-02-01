import 'package:fidelyz/main.dart';
import 'package:fidelyz/src/utils/CustomToastMessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  /// show toast message
  static void showToastMessage({
    required String message,
    String? title = 'Error',
  }) {
    FToast toast = FToast();
    toast.init(navigatorKey.currentContext!);
    toast.showToast(
      child: CustomToastMessage(
        fToast: toast,
        message: message,
        title: title!,
      ),
      gravity: ToastGravity.TOP,
      positionedToastBuilder: (context, offset) {
        return Positioned(
          right: 20,
          left: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom > 150
              ? MediaQuery.of(context).viewInsets.bottom
              : 100,
          child: offset,
        );
      },
    );
  }

  /// change Fields Focus node
  static void changeFieldFocusNode({
    required BuildContext context,
    required FocusNode current,
    required FocusNode nextFocus,
  }) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
