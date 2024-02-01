// import 'package:fidelyz/src/widgets/SubmitButton.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../../styles.dart';
//
// class ContactUs extends StatelessWidget {
//   const ContactUs({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Palette.primaryColor,
//       appBar: AppBar(
//         backgroundColor: Palette.primaryColor,
//         iconTheme: const IconThemeData(color: Colors.white, size: 20),
//         title: Text('ContactUs'.tr, style: TextStyles.appBarTitle),
//         centerTitle: true,
//       ),
//       body: ListView(
//         padding: const EdgeInsets.symmetric(horizontal: 20)
//             .copyWith(top: 08, bottom: 30),
//         children: [
//           Text(
//             "Name".tr,
//             style: TextStyles()
//                 .smallHeadingWhite
//                 .copyWith(fontWeight: FontWeight.w500),
//           ),
//           const SizedBox(height: 08),
//           TextField(
//             style: TextStyles().textFieldWhite,
//             decoration: buildTextFieldInputDecoration('EnterYourName'.tr),
//           ),
//           const SizedBox(height: 10),
//           Text(
//             "Email".tr,
//             style: TextStyles()
//                 .smallHeadingWhite
//                 .copyWith(fontWeight: FontWeight.w500),
//           ),
//           const SizedBox(height: 08),
//           TextField(
//             style: TextStyles().textFieldWhite,
//             decoration: buildTextFieldInputDecoration('EnterYourEmail'.tr),
//           ),
//           const SizedBox(height: 10),
//           Text(
//             "Message".tr,
//             style: TextStyles()
//                 .smallHeadingWhite
//                 .copyWith(fontWeight: FontWeight.w500),
//           ),
//           const SizedBox(height: 08),
//           TextField(
//             maxLines: 4,
//             style: TextStyles().textFieldWhite,
//             decoration: buildTextFieldInputDecoration('TypeYourMessage'.tr),
//           ),
//           const SizedBox(height: 20),
//           SubmitButton(
//               onTap: () {},
//               color: const Color(0xffE56D1F),
//               borderRadius: 12,
//               title: 'Send'),
//           const SizedBox(height: 20),
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12),
//               color: Palette.whiteColor.withOpacity(0.08),
//               border: Border.all(
//                 color: Palette.whiteColor.withOpacity(0.12),
//               ),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'FAQs'.tr,
//                   style: TextStyles().smallHeadingWhite,
//                 ),
//                 const SizedBox(height: 18),
//                 Text(
//                   'Q3'.tr,
//                   style: TextStyles().smallHeadingWhite.copyWith(fontSize: 14),
//                 ),
//                 const SizedBox(height: 10),
//                 Text(
//                   'Lorem Ipsum is simply dummy text of the printing and typesetting industry. '
//                   'Lorem Ipsum has been the industry\'s standard dummy text ',
//                   style: TextStyles().smallHeadingWhite.copyWith(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w400,
//                       color: Colors.white60),
//                   textAlign: TextAlign.justify,
//                 ),
//                 const SizedBox(height: 18),
//                 Text(
//                   'Q2'.tr,
//                   style: TextStyles().smallHeadingWhite.copyWith(fontSize: 14),
//                 ),
//                 const SizedBox(height: 10),
//                 Text(
//                   'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
//                   style: TextStyles().smallHeadingWhite.copyWith(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w400,
//                       color: Colors.white60),
//                   textAlign: TextAlign.justify,
//                 ),
//                 const SizedBox(height: 18),
//                 Text(
//                   'Q3'.tr,
//                   style: TextStyles().smallHeadingWhite.copyWith(fontSize: 14),
//                 ),
//                 const SizedBox(height: 10),
//                 Text(
//                   'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
//                   style: TextStyles().smallHeadingWhite.copyWith(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w400,
//                       color: Colors.white60),
//                   textAlign: TextAlign.justify,
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   InputDecoration buildTextFieldInputDecoration(String hint) {
//     return InputDecoration(
//       isDense: true,
//       hintText: hint,
//       hintStyle: TextStyles.textFieldHintWhite,
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: const BorderSide(
//           width: 0,
//           style: BorderStyle.none,
//         ),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: const BorderSide(
//           width: 0,
//           style: BorderStyle.none,
//         ),
//       ),
//       filled: true,
//       fillColor: Colors.white.withOpacity(0.15),
//       contentPadding:
//           const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12),
//     );
//   }
// }
