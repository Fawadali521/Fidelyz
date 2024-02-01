
import 'package:flutter/material.dart';

import '../../../../styles.dart';

class FAQs extends StatelessWidget {
  const FAQs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Palette.primaryColor,
      appBar: AppBar(
        backgroundColor: Palette.primaryColor,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 22,
          ),
        ),
        title: const Text('FAQs', style: TextStyles.appBarTitle),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0)
            .copyWith(top: 12, bottom: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Palette.whiteColor.withOpacity(0.08),
                  border: Border.all(
                      color: Palette.whiteColor.withOpacity(0.12), width: 1),
                ),
                child: Theme(
                  data: ThemeData(
                    applyElevationOverlayColor: false,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    dividerColor:
                        Colors.transparent, // Set divider color to transparent
                  ),
                  child: ExpansionTile(
                    iconColor: Colors.white,
                    collapsedIconColor: Colors.white,
                    // initiallyExpanded: true,
                    tilePadding: EdgeInsets.zero,
                    backgroundColor: Colors.transparent,
                    childrenPadding: EdgeInsets.zero,
                    title: Text(
                      'How does the fidelyz app feature work in the app?',
                      style: TextStyles().smallHeadingWhite.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                          ),
                    ),
                    children: <Widget>[
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ',
                          style: TextStyles().smallHeadingWhite.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white70,
                              ),
                          // textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                width: width,
                margin: const EdgeInsets.only(top: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Palette.whiteColor.withOpacity(0.08),
                  border: Border.all(
                      color: Palette.whiteColor.withOpacity(0.12), width: 1),
                ),
                child: Theme(
                  data: ThemeData(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    dividerColor:
                        Colors.transparent, // Set divider color to transparent
                  ),
                  child: ExpansionTile(
                    iconColor: Colors.white,
                    collapsedIconColor: Colors.white,
                    tilePadding: EdgeInsets.zero,
                    childrenPadding: EdgeInsets.zero,
                    title: Text(
                      'What do subscription plans o"er?',
                      style: TextStyles().smallHeadingWhite.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                          ),
                    ),
                    children: <Widget>[
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ',
                          style: TextStyles().smallHeadingWhite.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white70,
                              ),
                          // textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(top: 12),
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Palette.whiteColor.withOpacity(0.08),
                  border: Border.all(
                      color: Palette.whiteColor.withOpacity(0.12), width: 1),
                ),
                child: Theme(
                  data: ThemeData(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    dividerColor:
                        Colors.transparent, // Set divider color to transparent
                  ),
                  child: ExpansionTile(
                    iconColor: Colors.white,
                    collapsedIconColor: Colors.white,
                    tilePadding: EdgeInsets.zero,
                    childrenPadding: EdgeInsets.zero,
                    title: Text(
                      'How is user privacy handled?',
                      style: TextStyles().smallHeadingWhite.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                          ),
                    ),
                    children: <Widget>[
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ',
                          style: TextStyles().smallHeadingWhite.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white70,
                              ),
                          // textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SafeArea(child: SizedBox(height: 14)),
            ],
          ),
        ),
      ),
    );
  }
}
