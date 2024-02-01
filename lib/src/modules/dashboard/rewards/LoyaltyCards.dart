import 'package:fidelyz/src/modules/dashboard/store/RedeemOffer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../styles.dart';

class LoyaltyOptions extends StatefulWidget {
  final String points;
  final String title;
  final String imagePath;
  final bool available;
  final VoidCallback? onLockOfferTap;

  const LoyaltyOptions({
    super.key,
    required this.points,
    required this.title,
    required this.imagePath,
    required this.available,
    this.onLockOfferTap,
  });

  @override
  State<LoyaltyOptions> createState() => _LoyaltyOptionsState();
}

class _LoyaltyOptionsState extends State<LoyaltyOptions> {
  bool isSwiped = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 136,
      child: ListView.builder(
        itemCount: 10,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Stack(
              children: [
                /// image Container
                Container(
                  width: 136,
                  height: 130,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Palette.whiteColor.withOpacity(0.08)),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 132,
                            height: 90,
                            margin: const EdgeInsets.all(05),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: AssetImage(widget.imagePath),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          if (widget.available)
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) => const RedeemOffer());
                              },
                              child: Container(
                                width: 132,
                                height: 90,
                                margin: const EdgeInsets.all(05),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.black.withOpacity(0.8),
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.4),
                                      Colors.black.withOpacity(0.8),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          if (!widget.available)
                            Container(
                              width: 132,
                              height: 90,
                              margin: const EdgeInsets.all(05),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: RadialGradient(
                                  colors: [
                                    Colors.black.withOpacity(0.8),
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.4),
                                    Colors.black.withOpacity(0.8),
                                  ],
                                  tileMode: TileMode.clamp,
                                  center: Alignment.center,
                                  focalRadius: 10,
                                ),
                              ),
                            ),

                          /// lock on the image
                          if (!widget.available)
                            InkWell(
                              borderRadius: BorderRadius.circular(15),
                              onTap: widget.onLockOfferTap,
                              child: Container(
                                width: 132,
                                height: 90,
                                margin: const EdgeInsets.all(05),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black.withOpacity(0.4),
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.7),
                                      width: 1),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.lock_outline_rounded,
                                    color: Colors.white.withOpacity(0.7),
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),

                      /// text on image
                      FittedBox(
                        fit: BoxFit.contain,
                        child: SizedBox(
                          width: 128,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5.0, right: 5),
                            child: Text(
                              widget.title,
                              style: TextStyles.rewardCardOffer.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ), // Your TextStyle here
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
