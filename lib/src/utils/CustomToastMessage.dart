import 'package:fidelyz/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomToastMessage extends StatelessWidget {
  CustomToastMessage({
    Key? key,
    required this.fToast,
    required this.message,
    required this.title,
  }) : super(key: key);

  final FToast fToast;
  final String message;
  String title;

  @override
  Widget build(BuildContext context) {
    return (title.toLowerCase() == 'success')
        ? AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            padding: const EdgeInsets.all(08),
            curve: Curves.bounceInOut,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Palette.green,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 14,
                  backgroundColor: Palette.whiteColor,
                  child: Icon(
                    CupertinoIcons.check_mark_circled_solid,
                    color: Palette.green,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                Text(message, style: TextStyles.smallDecWhite),
              ],
            ),
          )
        : AnimatedContainer(
            height: 75,
            duration: const Duration(milliseconds: 500),
            curve: Curves.bounceInOut,
            padding: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: Palette.primaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 75,
                  width: 14,
                  decoration: const BoxDecoration(
                    color: Palette.redGradiant2,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12)),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.only(left: 12, bottom: 12.0),
                    title: Text(title, style: TextStyles.rewardCardTitle),
                    subtitle: Text(message, style: TextStyles.smallDecWhite),
                    leading: CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.white,
                      child: Icon(
                        title.toLowerCase() == 'network error'
                            ? CupertinoIcons.wifi_slash
                            : Icons.error,
                        color: Palette.redGradiant2,
                        size: title.toLowerCase() == 'network error' ? 22 : 28,
                      ),
                    ),
                    trailing: InkWell(
                      onTap: () {
                        fToast.removeCustomToast();
                      },
                      child: const Icon(
                        Icons.clear,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
