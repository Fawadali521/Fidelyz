import 'package:fidelyz/infos.dart';
import 'package:fidelyz/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'CategoryItems.dart';

class SearchCategory extends StatelessWidget {
  final Set<int> selectedCategories;
  final ScrollController scrollController;
  const SearchCategory({
    super.key,
    required this.selectedCategories,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double padding = 10;
    return Container(
      width: width,
      height: height * 0.85,
      decoration: const BoxDecoration(
        color: Palette.primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: ListView.builder(
        controller: scrollController,
        itemCount: 1,
        padding: const EdgeInsets.only(top: 16, bottom: 30),
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          return Column(
            children: [
              /// Top Line container
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 30,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: 70,
                            height: 6,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 08, left: 20, right: 20, top: 05),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Available Store".tr,
                    style:
                        TextStyles.categoryTextStyle(color: Palette.whiteColor),
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.36,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.all(padding),
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: padding,
                      mainAxisSpacing: 0,
                      childAspectRatio: ((width - (padding * 13)) / 3) /
                          ((width - (padding * 1)) / 3),
                    ),
                    itemCount: Infos().category.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CategoryItems(
                        selectedCategories: selectedCategories,
                        title: Infos().category[index]['title'],
                        icon: Infos().category[index]['selectedIcon'],
                        index: index,
                      );
                    },
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
