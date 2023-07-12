import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_blood_connect/text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

import 'components.dart';
import 'constants.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';

class RequestBloodDialog extends StatefulWidget {
  RequestBloodDialog({super.key});

  @override
  State<RequestBloodDialog> createState() => _RequestBloodDialogState();
}

class _RequestBloodDialogState extends State<RequestBloodDialog> {
  var imagePathController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  XFile? imagePicked;
  bool isValidate = true;
  pickImage() async {
    imagePicked = await ImagePicker()
        .pickImage(source: ImageSource.gallery)
        .then((value) {
      setState(() {
        imagePathController.text = value!.name;
      });
      print(value?.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: getScreenSize(context).width / 2.7,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset("assets/images/request_blood.json",
                  height: getScreenSize(context).height / 3.5),
              dropDownButtonForm(
                  items: bloodType
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (value) {},
                  hint: const Text("Blood Type"),
                  validator: (value) {
                    if (value == null) {
                      return "This field is required";
                    }
                    return null;
                  }),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15.0),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          imagePathController.text.isEmpty
                              ? "A copy of hospital's request"
                              : imagePathController.text,
                          textAlign: TextAlign.center,
                        ),
                        TextButton(
                            onPressed: () {
                              pickImage();
                            },
                            child: const Text("Choose photo"))
                      ],
                    ),
                    isValidate
                        ? const SizedBox()
                        : const Text(
                            "Please select a photo",
                            style: TextStyle(color: Colors.red),
                          )
                  ],
                ),
              ),
              myButton(
                context: context,
                child: const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    "Request my blood",
                    textAlign: TextAlign.center,
                  ),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    if (imagePathController.text.isEmpty) {
                      setState(() {
                        isValidate = false;
                      });
                    } else {
                      setState(() {
                        isValidate = true;
                      });
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
