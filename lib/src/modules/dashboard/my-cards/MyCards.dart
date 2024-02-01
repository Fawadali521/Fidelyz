import 'package:fidelyz/src/modules/dashboard/my-cards/LoyalityCard.dart';
import 'package:fidelyz/src/modules/dashboard/store/store.dart';
import 'package:fidelyz/src/widgets/CustomStackedListView.dart';
import 'package:fidelyz/styles.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

class MyCards extends StatefulWidget {
  const MyCards({super.key});

  @override
  State<MyCards> createState() => _MyCardsState();
}

class _MyCardsState extends State<MyCards> {
  List<String> data = [
    'Domino\'s',
    'Pizza Hut',
    'KFC',
    'McDonald\'s',
    // 'Subway',
    // 'Starbucks',
    // 'Taco Bell',
    // 'Dunkin\' Donuts',
    // 'Burger King',
    // 'Papa John\'s',
    // 'Domino\'s',
    // 'Pizza Hut',
    // 'KFC',
    // 'McDonald\'s',
    // 'Subway',
    // 'Starbucks',
    // 'Taco Bell',
    // 'Dunkin\' Donuts',
    // 'Burger King',
    // 'Papa John\'s',
  ];

  final double itemHeight = 200;

  Color getCardColor(int index) {
    final hslColor = HSLColor.fromColor(Palette.primaryColor);

    // Cycle hue values to generate distinct colors, but keep saturation and lightness
    // values in ranges that contrast well with the blueShallow background.
    double hue = (hslColor.hue + (index * 45.0)) % 360.0;
    double lightness = (0.5 + (index % 2) * 0.2) %
        1.0; // alternate between slightly lighter and darker
    double saturation = (hslColor.saturation + 0.2) % 1.0;

    return HSLColor.fromAHSL(1.0, hue, saturation, lightness).toColor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        toolbarHeight: 60,
        elevation: 0,
        backgroundColor: Palette.primaryColor,
        title: Text(
          'MyCards'.tr,
          style: TextStyles.appBarTitle,
        ),
      ),
      backgroundColor: Palette.primaryColor,
      body: CustomStackedListView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(15),
        itemCount: data.length,
        itemExtent: itemHeight,
        widthFactor: 1,
        heightFactor: 0.5,
        onRemove: (index, direction) {
          setState(() {
            data.removeAt(index);
          });
        },
        beforeRemove: (index, direction) async {
          return await showDialog<bool>(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('Delete ${data[index]} ?'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel')),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('Delete'),
                ),
              ],
            ),
          ).then((value) => value == true);
        },
        builder: (context, index) {
          final item = data[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade, child: const Store()));
            },
            child: LoyaltyCard(
              title: item,
              color: getCardColor(index),
              points: '100',
              index: index,
            ),
          );
        },
      ),
    );
  }
}
