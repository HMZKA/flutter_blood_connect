import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blood_connect/controllers/app_cubit/app_cubit.dart';
import 'package:flutter_blood_connect/controllers/auth_cubit/auth_cubit.dart';
import 'package:flutter_blood_connect/components/components.dart';
import 'package:flutter_blood_connect/components/text_field.dart';
import 'package:flutter_blood_connect/constants.dart';
import 'package:flutter_blood_connect/screens/home_screen.dart';
import 'package:lottie/lottie.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var identityNumberController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          pushAndRemoveUntil(context, HomeScreen());
          AppCubit().get(context).getProfile();
        }
        if (state is RegisterFailureState) {
          scaffoldMessengerKey.currentState?.showSnackBar(snackBar(
              message: "Account Already exist",
              backgroundColor: const Color.fromARGB(255, 10, 125, 14)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: myAppBar(),
          body: Stack(
            children: [
              Image.asset(
                "assets/images/bg.png",
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2.4,
                  child: Card(
                    surfaceTintColor: Colors.white,
                    elevation: 15,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SingleChildScrollView(
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Lottie.asset("assets/images/blood_donate.json",
                                  height: getScreenSize(context).height / 4),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 20.0),
                                child: Text(
                                  "Create your account",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: MyTextField().build(context,
                                          lable: const Text("First Name"),
                                          controller: firstNameController,
                                          validator: (value) {
                                    if (value!.isEmpty) {
                                      return "This field is required";
                                    }
                                    return null;
                                  })),
                                  Expanded(
                                      child: MyTextField().build(context,
                                          controller: lastNameController,
                                          lable: const Text("Last Name"),
                                          validator: (value) {
                                    if (value!.isEmpty) {
                                      return "This field is required";
                                    }
                                    return null;
                                  }))
                                ],
                              ),
                              MyTextField().build(context,
                                  lable: const Text("Identity Number"),
                                  hint: "101010101010", validator: (value) {
                                if (value!.isEmpty) {
                                  return "This field is required";
                                }
                                return null;
                              }, controller: identityNumberController),
                              MyTextField().build(context,
                                  lable: const Text("Phone Number"),
                                  hint: "+9639000000000", validator: (value) {
                                if (value!.isEmpty) {
                                  return "This field is required";
                                }
                                return null;
                              }, controller: phoneNumberController),
                              MyTextField().build(
                                context,
                                lable: const Text("Password"),
                                hint: "P@ssw0rd",
                                controller: passwordController,
                                isSecure: true,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "This field is required";
                                  }
                                  return null;
                                },
                              ),
                              myButton(
                                  context: context,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: state is RegisterLoadingState
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : const Text(
                                            "Register",
                                            textAlign: TextAlign.center,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                  ),
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      AuthCubit().get(context).register(
                                          firstName: firstNameController.text,
                                          lastName: lastNameController.text,
                                          phone: phoneNumberController.text,
                                          identityNumber:
                                              identityNumberController.text,
                                          password: passwordController.text);
                                    }
                                  }),
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
