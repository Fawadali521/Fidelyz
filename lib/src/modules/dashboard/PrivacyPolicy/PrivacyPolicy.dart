import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../styles.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

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
        title: const Text('Privacy Policy', style: TextStyles.appBarTitle),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20)
            .copyWith(top: 12, bottom: 40),
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
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Image.asset(
                    'assets/logo/icon-only.png',
                    height: 40,
                    width: 40,
                    fit: BoxFit.fill,
                  ),
                  title: Text(
                    'Privacy Policy',
                    style: TextStyles().smallHeadingWhite.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  subtitle: Text(
                    'Please read the Privacy policy fidelyz app',
                    style: TextStyles().smallHeadingWhite.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0, top: 4),
                  child: Text(
                    'Introduction',
                    style: TextStyles().smallHeadingWhite.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                buildTermsAndConditionsText(
                    "I'm happy to help answer questions or provide information on a wide range of topics, but I need a bit more specific guidance from you. \"Terms & conditions\" can refer to a variety of things, such as terms and conditions for a website, software, service, or a legal document."),
              ],
            ),
          ),
          const SizedBox(height: 16),
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0, top: 4),
                  child: Text(
                    'Fidelyz policy',
                    style: TextStyles().smallHeadingWhite.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                buildTermsAndConditionsText(
                    "Lorem Ipsum does not knowingly collect personally identifiable information (PII) from persons under the age of 13. If you are under the age of 13, please do not provide us with information of any kind whatsoever. If you have reason to believe that we may have accidentally received information from a child under the age of 13, please contact us immediately at legal@wasai.co. If we become aware that we have inadvertently received Personal Information from a person under the age of 13, we will delete such information from our records."),
              ],
            ),
          ),
          const SafeArea(child: SizedBox(height: 16)),
        ],
      ),
    );
  }

  Text buildTermsAndConditionsText(String text) {
    return Text(
      text.tr,
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
