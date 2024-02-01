import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import '../../../../styles.dart';
import 'ViewDeals.dart';

class SavedDeals extends StatelessWidget {
  const SavedDeals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.primaryColor,
      appBar: AppBar(
        backgroundColor: Palette.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white, size: 20),
        title: Text('SavedDeals'.tr, style: TextStyles.appBarTitle),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemCount: 5,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20)
            .copyWith(top: 5, bottom: 45),
        scrollDirection: Axis.vertical,
        separatorBuilder: (context, child) => const SizedBox(height: 12),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade, child: const ViewDeals()));
            },
            child: Container(
              width: Get.width,
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white.withOpacity(0.08),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 102,
                        margin: const EdgeInsets.symmetric(horizontal: 10)
                            .copyWith(top: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: const DecorationImage(
                            image: AssetImage("assets/image/pizza.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        width: Get.width,
                        height: 102,
                        margin: const EdgeInsets.symmetric(horizontal: 10)
                            .copyWith(top: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.black.withOpacity(0.8),
                              Colors.transparent,
                              Colors.black.withOpacity(0.8),
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12).copyWith(bottom: 8),
                    child: Text(
                      "Get 50% off on all orders above \$100",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0).copyWith(bottom: 10),
                    child: Text(
                      "Offers exclusive to our store",
                      style: TextStyle(
                        color: Color(0xff6FE44E),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
