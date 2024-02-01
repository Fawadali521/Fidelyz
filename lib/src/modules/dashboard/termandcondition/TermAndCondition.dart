import 'package:flutter/material.dart';
import '../../../../styles.dart';


class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({super.key});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  @override
  Widget build(BuildContext context) {
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
        title: const Text('Terms & Conditions', style: TextStyles.appBarTitle),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20)
            .copyWith(top: 08, bottom: 60),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Palette.whiteColor.withOpacity(0.08),
              border: Border.all(
                  color: Palette.whiteColor.withOpacity(0.12), width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello,👋',
                  style: TextStyles().smallHeadingWhite,
                ),
                const SizedBox(height: 10),
                Text(
                  "Before you create an account, please read and accept terms and conditions.",
                  style: TextStyles().smallHeadingWhite.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.80),
                      height: 1.8),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(top: 18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Palette.whiteColor.withOpacity(0.08),
              border: Border.all(
                  color: Palette.whiteColor.withOpacity(0.12), width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Image.asset(
                    'assets/logo/icon-only.png',
                    height: 40,
                    width: 40,
                    fit: BoxFit.fill,
                  ),
                  title: Text(
                    'Terms & Conditions',
                    style: TextStyles().smallHeadingWhite.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  subtitle: Text(
                    'Last updated : yesterday',
                    style: TextStyles().smallHeadingWhite.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                buildTermsAndConditionsText(
                    "BI'm happy to help answer questions or provide information on"
                        " a wide range of topics, but I need a bit more specific guidance from you."
                        " \"Terms & conditions\" can refer to a variety of things, such as terms "
                        "and conditions for a website, software, service, or a legal document.\n"),
                buildTermsAndConditionsText(
                    "If you could provide more details or specify the context, I would be better able to assist you. For example:\n"),
                buildTermsAndConditionsText(
                    "Are you looking for information on creating terms and conditions for a website or service?\n"),
                buildTermsAndConditionsText(
                    "Do you need help understanding specific terms and conditions for a product or service?\n"),
                buildTermsAndConditionsText(
                    "Are you interested in legal aspects of terms and conditions?"),
                const SizedBox(height: 20),
              ],
            ),
          )
        ],
      ),
    );
  }

  Text buildTermsAndConditionsText(String text) {
    return Text(
      text,
      style: TextStyles().smallHeadingWhite.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.white70,
        height: 1.6,
      ),
      // textAlign: TextAlign.justify,
    );
  }
}
