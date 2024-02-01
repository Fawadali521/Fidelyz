import 'package:fidelyz/infos.dart';
import 'package:fidelyz/src/controllers/search/CatergoryController.dart';
import 'package:fidelyz/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ShopListItem.dart';

class ShopList extends StatefulWidget {
  final ScrollController scrollSheetController;
  final Set<int> selectedCategories;
  const ShopList({
    super.key,
    required this.scrollSheetController,
    required this.selectedCategories,
  });

  @override
  State<ShopList> createState() => _ShopListState();
}

class _ShopListState extends State<ShopList> {
  final categoryController = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
        width: width,
        height: height * 0.85,
        decoration: const BoxDecoration(
          color: Palette.primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: ListView.builder(
          controller: widget.scrollSheetController,
          padding: const EdgeInsets.only(top: 16, bottom: 30),
          physics: const ClampingScrollPhysics(),
          itemCount: 1,
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
                                color: Colors.white.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(50),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                /// All Categories list
                Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: SizedBox(
                    height: 40,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: Infos().category.length,
                      itemBuilder: (BuildContext context, int index) {
                        var category = Infos().category[index];
                        return Padding(
                          padding: EdgeInsets.only(
                              left: (index == 0) ? 15 : 0, right: 10),
                          child: InkWell(
                            onTap: () {
                              if (widget.selectedCategories.contains(index)) {
                                widget.selectedCategories.remove(index);
                                categoryController.category.value = '';
                                categoryController.isFiltering(false);
                                categoryController.filteredSellers.clear();
                              } else {
                                widget.selectedCategories.add(index);
                                categoryController.category.value =
                                    category['title'].toString().toUpperCase();
                                categoryController.isFiltering(true);
                                categoryController.searchSellers();
                              }
                              setState(
                                  () {}); // Refresh the widget to reflect the changes.
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Palette.whiteColor.withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(50),
                                  border:
                                      widget.selectedCategories.contains(index)
                                          ? Border.all(
                                              color: Palette.secondaryColor,
                                              width: 1.6)
                                          : null),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    Infos().category[index]['selectedIcon'],
                                    height: 20,
                                    width: 20,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    Infos().category[index]['title'] ??
                                        "McDonald's",
                                    style: TextStyles.categoryTextStyle(
                                        color: Palette.whiteColor),
                                    // : TextStyles.categoryTextStyle(),
                                    overflow: TextOverflow.visible,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                /// Venues / Restaurants details
                Obx(
                  () => SizedBox(
                    child: categoryController.isLoading.value
                        ? SizedBox(
                            height: Get.height * 0.7,
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Palette.secondaryColor,
                                strokeWidth: 3,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: categoryController.isFiltering.value
                                ? categoryController.filteredSellers.length
                                : categoryController.sellers.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              var seller = categoryController.sellers[index];
                              return ShopListItem(
                                expires: 'Expires in 9 days',
                                logo: 'assets/shops/5.jpeg',
                                offer: '40% off on all items',
                                shopName: seller.businessname,
                              );
                            },
                          ),
                  ),
                ),
                Visibility(
                  visible: categoryController.isFiltering.value
                      ? categoryController.filteredSellers.isEmpty
                      : categoryController.sellers.isEmpty,
                  child: SizedBox(
                    height: Get.height * 0.7,
                    child: Center(
                      child: Text(
                        'No seller found!',
                        style:
                            TextStyles.rewardCardTitle.copyWith(fontSize: 14),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: categoryController.isFiltering.value
                      ? categoryController.filteredSellers.isNotEmpty
                      : categoryController.sellers.isNotEmpty,
                  child: InkWell(
                    onTap: () {
                      categoryController.page.value++;
                      categoryController.performPagination();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 6),
                      child: Obx(
                        () => categoryController.loadMore.value
                            ? Center(
                                child: Transform.scale(
                                  scale: 0.5,
                                  child: const CircularProgressIndicator(
                                    color: Palette.secondaryColor,
                                    strokeWidth: 3,
                                  ),
                                ),
                              )
                            : Text(
                                'Load more',
                                style: TextStyles.rewardCardTitle
                                    .copyWith(fontSize: 14),
                              ),
                      ),
                    ),
                  ),
                )
                // ...List.generate(
                //   Infos().shopLocations.length,
                //   (index) => ShopListItem(
                //     expires: Infos().shopLocations[index]['expires'],
                //     logo: Infos().shopLocations[index]['logo'],
                //     offer: Infos().shopLocations[index]['offer'],
                //     shopName: Infos().shopLocations[index]['shop-name'],
                //   ),
                // )
              ],
            );
          },
        )

        // ListView (
        //   shrinkWrap: true,
        //   controller: widget.scrollSheetController,
        //   padding: const EdgeInsets.only(top: 12, bottom: 80),
        //   physics: const ClampingScrollPhysics(),
        //   children: [
        //     /// Top Line container
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       mainAxisSize: MainAxisSize.max,
        //       children: [
        //         SizedBox(
        //           height: 30,
        //           child: Padding(
        //             padding: const EdgeInsets.only(bottom: 16),
        //             child: Row(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               mainAxisSize: MainAxisSize.max,
        //               children: [
        //                 Container(
        //                   width: 70,
        //                   height: 6,
        //                   decoration: BoxDecoration(
        //                     color: Colors.white.withOpacity(0.8),
        //                     borderRadius: BorderRadius.circular(50),
        //                   ),
        //                 )
        //               ],
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //
        //     /// All Categories list
        //     Padding(
        //       padding: const EdgeInsets.only(bottom: 20),
        //       child: SizedBox(
        //         height: 40,
        //         child: ListView.builder(
        //           shrinkWrap: true,
        //           scrollDirection: Axis.horizontal,
        //           itemCount: Infos().category.length,
        //           itemBuilder: (BuildContext context, int index) {
        //             return Padding(
        //               padding: EdgeInsets.only(
        //                   left: (index == 0) ? 15 : 0, right: 10),
        //               child: InkWell(
        //                 onTap: () {
        //                   if (widget.selectedCategories.contains(index)) {
        //                     widget.selectedCategories.remove(index);
        //                   } else {
        //                     widget.selectedCategories.add(index);
        //                   }
        //                   setState(
        //                       () {}); // Refresh the widget to reflect the changes.
        //                 },
        //                 child: Container(
        //                   padding: const EdgeInsets.only(left: 16, right: 16),
        //                   alignment: Alignment.center,
        //                   decoration: BoxDecoration(
        //                     color: Palette.whiteColor.withOpacity(0.08),
        //                     borderRadius: BorderRadius.circular(50),
        //                   ),
        //                   child: Row(
        //                     mainAxisAlignment: MainAxisAlignment.center,
        //                     crossAxisAlignment: CrossAxisAlignment.center,
        //                     children: [
        //                       Image.asset(
        //                         widget.selectedCategories.contains(index)
        //                             ? Infos().category[index]['selectedIcon']
        //                             : Infos().category[index]['disableIcon'],
        //                         height: 20,
        //                         width: 20,
        //                       ),
        //                       const SizedBox(width: 12),
        //                       Text(
        //                         Infos().category[index]['title'] ??
        //                             "McDonald's",
        //                         style:
        //                             widget.selectedCategories.contains(index)
        //                                 ? TextStyles.categoryTextStyle(
        //                                     color: Palette.whiteColor)
        //                                 : TextStyles.categoryTextStyle(),
        //                         overflow: TextOverflow.visible,
        //                       ),
        //                     ],
        //                   ),
        //                 ),
        //               ),
        //             );
        //           },
        //         ),
        //       ),
        //     ),
        //
        //     /// Venues / Restaurants details
        //     ...List.generate(
        //       Infos().shopLocations.length,
        //       (index) => ShopListItem(
        //         expires: Infos().shopLocations[index]['expires'],
        //         logo: Infos().shopLocations[index]['logo'],
        //         offer: Infos().shopLocations[index]['offer'],
        //         shopName: Infos().shopLocations[index]['shop-name'],
        //       ),
        //     )
        //   ],
        // ),
        );
  }
}
