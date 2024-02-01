import 'package:fidelyz/infos.dart';
import 'package:fidelyz/src/modules/dashboard/rewards/rewardTile.dart';
import 'package:fidelyz/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Rewards extends StatefulWidget {
  const Rewards({super.key});

  @override
  State<Rewards> createState() => _RewardsState();
}

class _RewardsState extends State<Rewards> with TickerProviderStateMixin {
  int selectedPageIndex = 0;
  List<int> merchantIndex = [];
  bool isSearching = false;

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(6.0, 0.0),
      end: Offset.zero,
    ).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 60,
        scrolledUnderElevation: 0,
        backgroundColor: Palette.primaryColor,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () {
                HapticFeedback.lightImpact();
                setState(() {
                  isSearching = !isSearching;
                  if (isSearching) {
                    _animationController.forward();
                  } else {
                    _animationController.reverse();
                  }
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: isSearching
                    ? const Icon(
                        Icons.clear,
                        color: Colors.white,
                      )
                    : Image.asset('assets/icons/search.png'),
              ),
            ),
          ),
        ],
        title: isSearching
            ? SlideTransition(
                position: _slideAnimation,
                child: buildSearchField(),
              )
            : Text(
                'Rewards'.tr,
                style: TextStyles.appBarTitle
                    .copyWith(fontWeight: FontWeight.w400),
              ),
      ),
      backgroundColor: Palette.primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 5),
              child: SizedBox(
                width: width,
                height: 88,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: Infos().shops.length,
                  itemBuilder: (context, index) {
                    return merchantFilterItem(index);
                  },
                ),
              ),
            ),

            /// page content/ body of page
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(top: 0),
                children: const [
                  RewardTile(
                      color: Palette.secondaryColor,
                      imageSrc: 'assets/image/burger.png'),
                  RewardTile(
                      color: Palette.green, imageSrc: 'assets/image/img.png'),
                  RewardTile(
                      color: Color(0xffF15025),
                      imageSrc: 'assets/image/img_1.png'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Merchant filter items
  Widget merchantFilterItem(int index) {
    return Padding(
      padding: EdgeInsets.only(left: (index == 0) ? 10 : 0, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: () {
              setState(
                () {
                  if (merchantIndex.contains(index)) {
                    merchantIndex.remove(index);
                  } else {
                    merchantIndex.add(index);
                  }
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Center(
                child: CircleAvatar(
                  radius: 22,
                  backgroundColor: merchantIndex.contains(index)
                      ? Palette.secondaryColor
                      : Colors.transparent,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(Infos().shopsLogos[index]),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 7),
            child: SizedBox(
              width: 60,
              child: Center(
                child: FittedBox(
                  child: Text(
                    Infos().shops[index],
                    style: TextStyles.actionSmallWhiteMiniBond
                        .copyWith(fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ),

          /// button indicator line
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              width: 70,
              height: 2,
              color: merchantIndex.contains(index)
                  // selectedMerchantIndex == index
                  ? Palette.secondaryColor
                  : Colors.transparent,
            ),
          )
        ],
      ),
    );
  }

  /// top search field
  Widget buildSearchField() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: isSearching ? Get.width - 60 : 0.0,
      height: 45,
      child: TextField(
        style: TextStyles.smallDecWhite,
        cursorColor: Colors.white,
        decoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyles.smallDecWhite,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide:
                    BorderSide(color: Palette.whiteColor.withOpacity(0.04))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide:
                    BorderSide(color: Palette.whiteColor.withOpacity(0.04))),
            filled: true,
            fillColor: Palette.whiteColor.withOpacity(0.08),
            prefixIcon: Image.asset('assets/icons/search.png'),
            contentPadding: const EdgeInsets.symmetric(vertical: 12)),
        onChanged: (value) {
          // Handle search logic
        },
      ),
    );
  }
}
