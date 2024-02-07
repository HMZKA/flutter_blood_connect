import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blood_connect/components/components.dart';
import 'package:flutter_blood_connect/components/text_field.dart';
import 'package:flutter_blood_connect/controllers/app_cubit/app_cubit.dart';
import 'package:lottie/lottie.dart';

import '../constants.dart';

class DonationScreen extends StatelessWidget {
  DonationScreen({super.key});
  var formKey = GlobalKey<FormState>();
  var ageController = TextEditingController();
  var weightController = TextEditingController();
  var lastTimeDonateController = TextEditingController();
  var healthStatusController = TextEditingController();
  var bloodTypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is DonateSuccessState) {
          Navigator.of(context).pop();
          scaffoldMessengerKey.currentState?.showSnackBar(snackBar(
              message: "Thanks for your donation",
              backgroundColor: Colors.green));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: myAppBar(),
          body: Stack(
            children: [
              Lottie.asset(
                "assets/images/blood_animate.json",
                repeat: false,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2.4,
                  child: Card(
                    elevation: 15,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SingleChildScrollView(
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Lottie.asset("assets/images/blood_donation.json",
                                  height: getScreenSize(context).height / 4),
                              MyTextField().build(context,
                                  lable: const Text("Age"), validator: (value) {
                                if (value!.isEmpty) {
                                  return "This field is required";
                                } else if (18 > int.parse(value) ||
                                    int.parse(value) > 65) {
                                  return "You can't donate your blood";
                                }
                                return null;
                              }, controller: ageController),
                              MyTextField()
                                  .build(context, lable: const Text("Weight"),
                                      validator: (value) {
                                if (value!.isEmpty) {
                                  return "This field is required";
                                } else if (int.parse(value) < 50) {
                                  return "You can't donate your blood";
                                }
                                return null;
                              }, controller: weightController),
                              MyTextField().build(
                                context,
                                lable: const Text("Last time donate"),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "This field is required";
                                  }
                                  return null;
                                },
                                controller: lastTimeDonateController,
                                onTap: () {
                                  showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime.now())
                                      .then((value) =>
                                          lastTimeDonateController.text =
                                              value != null
                                                  ? "$value".split(" ").first
                                                  : "");
                                },
                              ),
                              dropDownButtonForm(
                                  items: diseasesPreventingBloodDonation
                                      .map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(e),
                                          ))
                                      .toList(),
                                  validator: (value) {
                                    if (value == null) {
                                      return "This field is required";
                                    } else if (value != "Healthy") {
                                      return "You can't donate your blood";
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    healthStatusController.text = value;
                                  },
                                  hint: const Text("Health status")),
                              dropDownButtonForm(
                                  items: bloodType
                                      .map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(e),
                                          ))
                                      .toList(),
                                  validator: (value) {
                                    if (value == null) {
                                      return "This field is required";
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    bloodTypeController.text = value;
                                  },
                                  hint: const Text("Blood Type")),
                              myButton(
                                context: context,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: state is DonateLoadingState
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : const Text(
                                          "Donate",
                                          textAlign: TextAlign.center,
                                        ),
                                ),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    AppCubit().get(context).donate(
                                        age: ageController.text,
                                        weight: weightController.text,
                                        lastTime: lastTimeDonateController.text,
                                        bloodType: bloodTypeController.text);
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
