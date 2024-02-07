import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blood_connect/components/text_field.dart';
import 'package:flutter_blood_connect/controllers/app_cubit/app_cubit.dart';

import 'package:lottie/lottie.dart';

import 'components.dart';
import '../constants.dart';

class RequestBloodDialog extends StatefulWidget {
  RequestBloodDialog({super.key});

  @override
  State<RequestBloodDialog> createState() => _RequestBloodDialogState();
}

class _RequestBloodDialogState extends State<RequestBloodDialog> {
  var imagePathController = TextEditingController();
  var bloodTypeController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  bool isValidate = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit().get(context);
        return Dialog(
          child: state is OrderSuccessState
              ? Padding(
                  padding: const EdgeInsets.all(12),
                  child: Lottie.asset(
                    "assets/images/done.json",
                    onLoaded: (p0) {
                      Timer.periodic(p0.duration, (timer) {
                        Navigator.of(context).pop();
                      });
                    },
                  ),
                )
              : SizedBox(
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
                            onChanged: (value) {
                              bloodTypeController.text = value;
                            },
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    cubit.imagePicked == null
                                        ? "A copy of hospital's request"
                                        : cubit.imagePicked!,
                                    textAlign: TextAlign.center,
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        cubit.pickImage();
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
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: state is OrderLoadingState
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : const Text(
                                    "Request my blood",
                                    textAlign: TextAlign.center,
                                  ),
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              if (cubit.imagePicked == null) {
                                setState(() {
                                  isValidate = false;
                                });
                              } else {
                                // setState(() {
                                //   isValidate = true;
                                // });
                                print(isValidate);

                                AppCubit().get(context).order(
                                    bloodType: bloodTypeController.text,
                                    image: cubit.imageBytes!);
                              }
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
