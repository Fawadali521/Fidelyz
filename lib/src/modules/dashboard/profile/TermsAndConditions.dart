// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../styles.dart';
//
// class TermsAndConditions extends StatelessWidget {
//   const TermsAndConditions({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Palette.primaryColor,
//       appBar: AppBar(
//         backgroundColor: Palette.primaryColor,
//         iconTheme: const IconThemeData(color: Colors.white, size: 20),
//         title: Text('Terms&Conditions'.tr, style: TextStyles.appBarTitle),
//         centerTitle: true,
//       ),
//       body: ListView(
//         padding: const EdgeInsets.symmetric(horizontal: 20)
//             .copyWith(top: 08, bottom: 30),
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
//                 Text(
//                   'Hello,👋'.tr,
//                   style: TextStyles().smallHeadingWhite,
//                 ),
//                 const SizedBox(height: 10),
//                 Text(
//                   'BeforeYouCreateAnAccountPleaseRead'.tr,
//                   style: TextStyles().smallHeadingWhite.copyWith(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.white.withOpacity(0.80),
//                       height: 1.8),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.all(16),
//             margin: const EdgeInsets.only(top: 18),
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
//                     'Terms&Conditions'.tr,
//                     style: TextStyles().smallHeadingWhite.copyWith(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w700,
//                         ),
//                   ),
//                   subtitle: Text(
//                     '${'LastUpdated'.tr} : yesterday'.tr,
//                     style: TextStyles().smallHeadingWhite.copyWith(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w400,
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
//                     "Do you need help understanding specific terms and conditions for a product or service?\n"),
//                 buildTermsAndConditionsText(
//                     "Are you interested in legal aspects of terms and conditions?"),
//                 const SizedBox(height: 50),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: MaterialButton(
//                         onPressed: () {},
//                         elevation: 1,
//                         height: 45,
//                         // color: Colors.white.withOpacity(0.08),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             side: const BorderSide(color: Colors.white)),
//                         child: Text(
//                           'decline'.tr,
//                           style: TextStyles().smallHeadingWhite.copyWith(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 20),
//                     Expanded(
//                       child: MaterialButton(
//                         onPressed: () {},
//                         elevation: 1,
//                         height: 45,
//                         color: const Color(0xffE56D1F),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Text(
//                           'YesAgree'.tr,
//                           style: TextStyles().smallHeadingWhite.copyWith(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16),
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
