import 'dart:io';


import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../styles.dart';
import '../../../services/ToastMsg.dart';
import '../../../widgets/SubmitButton.dart';
import '../../../widgets/itemCountContainer.dart';



class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  bool enableSuggestions = false;
  int selectedIndex = 0;
  TextEditingController ticketController = TextEditingController();

  String selectedReason = '';

  XFile? selectedFile = XFile('');
  Future<void> pickCoverImage() async {
    try {
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      setState(() {
        selectedImages.add(image);
        // selectedFile = image;
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error picking image: $e");
      }

      // Check the error message
      if (e.toString().contains("invalid_image")) {
        ToastMsg().sendErrorMsg(
            "There was an issue with the selected image. Please try a different image.");
      } else {
        ToastMsg().sendErrorMsg("Error picking image: $e");
      }
    }
  }

  List<XFile> selectedImages = [];

  int index = 0;

  void addUploadButton() {
    // selectedImages.add()
  }

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Palette.primaryColor,
      appBar: AppBar(
        backgroundColor: Palette.primaryColor,
        centerTitle: true,
        title: Text(
          'EditProfile'.tr,
          style: TextStyles.appBarTitle,
        ),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: Get.width,
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            index = 0;
                          });
                        },
                        child: buildTopButtonContainer(
                          isSelect: index == 0,
                          assetName: 'ticket1.png',
                          buttonName: 'Create ticket',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            index = 1;
                          });
                        },
                        child: buildTopButtonContainer(
                          isSelect: index == 1,
                          assetName: 'ticket2.png',
                          buttonName: 'View ticket',
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Visibility(
                visible: index == 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(top: 16, bottom: 8),
                        child:
                            Text('Reason', style: TextStyles.inputTextStyle)),
                    selectedReason.isNotEmpty
                        ? Stack(
                            children: [
                              Container(
                                height: 55,
                                width: Get.width,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white.withOpacity(0.08),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Palette.secondaryColor,
                                  ),
                                  child: const Text('Enter reason',
                                      style: TextStyles.inputTextStyle),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedReason = '';
                                      ticketController.clear();
                                    });
                                  },
                                  child: const CircleAvatar(
                                    radius: 10,
                                    child: Icon(
                                      Icons.cancel,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        : buildTextFieldContainer(
                            textController: ticketController,
                            hint: 'Enter reason',
                            onChanged: (value) {
                              setState(
                                () {
                                  enableSuggestions = true;
                                },
                              );
                            },
                            onSubmit: (value) {
                              setState(() {
                                selectedReason = 'Enter reason';
                                enableSuggestions = false;
                              });
                            }),
                    Visibility(
                      visible: enableSuggestions,
                      child: Container(
                        height: 240,
                        margin: const EdgeInsets.symmetric(vertical: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white.withOpacity(0.06),
                        ),
                        child: ListView.builder(
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                  // ticketController.text = 'Enter reason';
                                  enableSuggestions = false;
                                  selectedReason = 'Enter reason';
                                });
                              },
                              child: Card(
                                elevation: 0,
                                color: selectedIndex == index
                                    ? Palette.secondaryColor
                                    : Palette.whiteColor.withOpacity(0.08),
                                child:  const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 12),
                                  child: Text('Enter reason',
                                      style: TextStyles.inputTextStyle),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const Padding(
                        padding: EdgeInsets.only(top: 16, bottom: 8),
                        child: Text('Upload Image',
                            style: TextStyles.inputTextStyle)),
                    SizedBox(
                      width: Get.width,
                      child: GridView.builder(
                        itemCount: selectedImages.length + 1,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12),
                        itemBuilder: (context, index) {
                          if (index < selectedImages.length) {
                            return Container(
                              height: 73,
                              width: 73,
                              alignment: Alignment.topRight,
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                      image: FileImage(
                                          File(selectedImages[index].path)),
                                      fit: BoxFit.fill)),
                              child: GestureDetector(
                                onTap: () {
                                  selectedImages.remove(selectedImages[index]);
                                  setState(() {});
                                },
                                child: const Icon(
                                  Icons.cancel,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            );
                          } else {
                            return GestureDetector(
                              onTap: () {
                                pickCoverImage();
                              },
                              child: DottedBorder(
                                color: Colors.green,
                                strokeWidth: 1,
                                strokeCap: StrokeCap.round,
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(16),
                                dashPattern: const [5, 5],
                                child: SizedBox(
                                  height: 70,
                                  width: 70,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Image.asset(
                                      'assets/profile/gallary.png',
                                      width: 40,
                                      height: 40,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    const Padding(
                        padding: EdgeInsets.only(top: 16, bottom: 8),
                        child:
                            Text('Message', style: TextStyles.inputTextStyle)),
                    SizedBox(
                      height: 120,
                      child: ItemCountContainer(
                        hint: 'Type your message...',
                        maxLines: 3,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: SubmitButton(
                        color: Palette.green,
                        onTap: () {},
                     title: 'Send',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildTopButtonContainer(
      {required bool isSelect,
      required String assetName,
      required String buttonName}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color:
            isSelect ? const Color(0xff32CC3A) : Colors.white.withOpacity(0.08),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor:
                isSelect ? Colors.white : Colors.white.withOpacity(0.08),
            child: Image.asset(
              'assets/profile/$assetName',
              width: 16,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              buttonName,
              style: TextStyles.contactUsTaps,
            ),
          )
        ],
      ),
    );
  }

  Container buildTextFieldContainer({
    int maxLines = 1,
    TextEditingController? textController,
    required String hint,
    Function(String)? onChanged,
    Function(String)? onSubmit,
  }) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white.withOpacity(0.06),
      ),
      child: Center(
        child: TextFormField(
          maxLines: maxLines,
          controller: textController,
          onChanged: onChanged,
          onFieldSubmitted: onSubmit,
          // onTap:
          style: TextStyles.inputTextStyle,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyles().textFieldHintWhite1,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          ),
        ),
      ),
    );
  }
}
