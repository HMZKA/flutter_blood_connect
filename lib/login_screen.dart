import 'package:flutter/material.dart';
import 'package:flutter_blood_connect/components.dart';
import 'package:flutter_blood_connect/register_screen.dart';
import 'package:flutter_blood_connect/text_field.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(actions: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton(
            onPressed: () {
              pushNavigation(context, RegisterScreen());
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red)),
            child: const Text("Register"),
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
                            hint: "P@ssw0rd", validator: (value) {
                          if (value!.isEmpty) {
                            return "This field is required";
                          }
                          return null;
                        }, controller: passwordController),
                        myButton(
                            context: context,
                            child: const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                "Login",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {}
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
  }
}
