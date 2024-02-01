// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../../styles.dart';
//
// class PrivacyPolicy extends StatelessWidget {
//   const PrivacyPolicy({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Palette.primaryColor,
//       appBar: AppBar(
//         backgroundColor: Palette.primaryColor,
//         iconTheme: const IconThemeData(color: Colors.white, size: 20),
//         title: Text('PrivacyPolicy'.tr.replaceAll('.', ''),
//             style: TextStyles.appBarTitle),
//         centerTitle: true,
//       ),
//       body: ListView(
//         padding: const EdgeInsets.symmetric(horizontal: 20)
//             .copyWith(top: 12, bottom: 30),
//         children: [
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12),
//               color: Palette.whiteColor.withOpacity(0.08),
//               border: Border.all(
//                   color: Palette.whiteColor.withOpacity(0.12), width: 1),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 ListTile(
//                   contentPadding: EdgeInsets.zero,
//                   leading: Image.asset(
//                     'assets/logo/icon-200.png',
//                     height: 40,
//                     width: 40,
//                     fit: BoxFit.fill,
//                   ),
//                   title: Text(
//                     'PrivacyPolicy'.tr.replaceAll('.', ''),
//                     style: TextStyles().smallHeadingWhite.copyWith(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w700,
//                         ),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 buildTermsAndConditionsText(
//                     "BI'm happy to help answer questions or provide information on"
//                     " a wide range of topics, but I need a bit more specific guidance from you."
//                     " \"Terms & conditions\" can refer to a variety of things, such as terms "
//                     "and conditions for a website, software, service, or a legal document.\n"),
//                 buildTermsAndConditionsText(
//                     "If you could provide more details or specify the context, I would be better able to assist you. For example:\n"),
//                 buildTermsAndConditionsText(
//                     "Are you looking for information on creating terms and conditions for a website or service?\n"),
//                 buildTermsAndConditionsText(
//                     "Do you need help understanding specific terms and conditions for a product or service?"),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   Text buildTermsAndConditionsText(String text) {
//     return Text(
//       text.tr,
//       style: TextStyles().smallHeadingWhite.copyWith(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: Colors.white70,
//             height: 1.6,
//           ),
//       textAlign: TextAlign.justify,
//     );
//   }
// }
