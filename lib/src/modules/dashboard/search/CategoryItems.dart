import 'package:fidelyz/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CategoryItems extends StatefulWidget {
  final Set<int> selectedCategories;
  final String? title;
  final String? icon;
  final int index;
  const CategoryItems({
    super.key,
    required this.selectedCategories,
    this.title,
    this.icon,
    required this.index,
  });

  @override
  State<CategoryItems> createState() => _CategoryItemsState();
}

class _CategoryItemsState extends State<CategoryItems> {
  @override
  Widget build(BuildContext context) {
    bool isSelected = widget.selectedCategories.contains(widget.index); //
    return InkWell(
      onTap: () {
        HapticFeedback.lightImpact();
        if (isSelected) {
          widget.selectedCategories.remove(widget.index);
        } else {
          widget.selectedCategories.add(widget.index);
        }
        setState(() {});
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              color:Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.grey)
            ),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Center(
                child: ClipRRect(
                  borderRadius:
                  BorderRadius.circular(
                      50),
                  child: Image.asset(
                    widget.icon!,
                    fit: BoxFit.cover,
                    height: 45,
                    width: 45,
                  ),
                ),
              ),
            ),
          ),
          // Container(
          //   width: 53,
          //   height: 53,
          //   decoration: BoxDecoration(
          //     color: Palette.whiteColor.withOpacity(0.08),
          //     shape: BoxShape.circle,
          //     border: Border.all(
          //       color: isSelected
          //           ? Palette.secondaryColor
          //           : Colors.white.withOpacity(0.19),
          //       width: isSelected ? 1.5 : 1,
          //     ),
          //   ),
          //   child: Image.asset(
          //     widget.icon!,
          //     height: 20,
          //     width: 20,
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              widget.title ?? "McDonald's",
              style: TextStyles.smallDecWhite.copyWith(fontSize: 10),
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
