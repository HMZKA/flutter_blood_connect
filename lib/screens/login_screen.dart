import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blood_connect/controllers/app_cubit/app_cubit.dart';
import 'package:flutter_blood_connect/controllers/auth_cubit/auth_cubit.dart';
import 'package:flutter_blood_connect/components/components.dart';
import 'package:flutter_blood_connect/constants.dart';
import 'package:flutter_blood_connect/screens/home_screen.dart';
import 'package:flutter_blood_connect/screens/register_screen.dart';
import 'package:flutter_blood_connect/components/text_field.dart';
import 'package:lottie/lottie.dart';

import '../utils/app_cache.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          pushAndRemoveUntil(context, HomeScreen());
          AppCubit().get(context).getProfile();
        }
        if (state is LoginFailureState) {
          scaffoldMessengerKey.currentState?.showSnackBar(snackBar(
              message: "Invalid Credentials",
              backgroundColor: const Color.fromARGB(255, 10, 125, 14)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: myAppBar(actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  pushNavigation(context, RegisterScreen());
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)))),
                child: const Text(
                  "Register",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ]),
          body: Stack(
            children: [
              Lottie.asset("assets/images/blood_animate.json",
                  repeat: false,
                  width: getScreenSize(context).width,
                  fit: BoxFit.cover),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2.4,
                  child: Card(
                    surfaceTintColor: Colors.white,
                    color: Colors.white,
                    elevation: 15,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
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
                                "Login",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                            ),
                            MyTextField().build(context,
                                lable: const Text("Phone Number"),
                                hint: "+9639000000000", validator: (value) {
                              if (value!.isEmpty) {
                                return "This field is required";
                              }
                              return null;
                            }, controller: phoneNumberController),
                            MyTextField().build(context,
                                lable: const Text("Password"),
                                isSecure: true,
                                hint: "P@ssw0rd", validator: (value) {
                              if (value!.isEmpty) {
                                return "This field is required";
                              }
                              return null;
                            }, controller: passwordController),
                            myButton(
                                context: context,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: state is LoginLoadingState
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : const Text(
                                          "Login",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                ),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    AuthCubit().get(context).login(
                                        phone: phoneNumberController.text,
                                        password: passwordController.text);
                                  }
                                }),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Don't have account?"),
                                TextButton(
                                    onPressed: () {
                                      pushNavigation(context, RegisterScreen());
                                    },
                                    child: const Text("Create account"))
                              ],
                            )
                          ],
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
