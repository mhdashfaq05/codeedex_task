import 'package:codeedex_task/services/api_services.dart';
import 'package:flutter/material.dart';

import '../main.dart';


class NewPasswordSetPage extends StatefulWidget {
  String email;
  String otp;
   NewPasswordSetPage({super.key,required this.email,required this.otp});

  @override
  State<NewPasswordSetPage> createState() => _NewPasswordSetPageState();
}

class _NewPasswordSetPageState extends State<NewPasswordSetPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final validatePassword =
  RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  String? passwordValidation(String value) {
    if (value.isEmpty) {
      return 'Please enter a password';
    } else if (!validatePassword.hasMatch(value)) {
      return 'Password must be at least 8 characters long, include an uppercase letter, a lowercase letter, a number, and a special character.';
    }
    return null;
  }
  String? confirmPasswordValidation(String value) {
    if (value.isEmpty) {
      return 'Please confirm your password';
    } else if (value != newPasswordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }
  void submitPasswordReset() {
    if (_formKey.currentState!.validate()) {
      ApiServices().resetPassword(
        context,
        newPasswordController.text,
        confirmPasswordController.text,
        widget.email,
        widget.otp

      );
    }
  }
  bool a=true;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key:_formKey,
          child: Column(
            children: [
              Center(
                  child: Text(
                    "Create New Password",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: w * 0.06),
                  )),
              Center(
                  child: Text(
                    "Please enter and confirm your new password.",
                    style: TextStyle( fontSize: w * 0.03),
                  )),
              Center(
                  child: Text(
                    "You will need to login after you reset.",
                    style: TextStyle( fontSize: w * 0.03),
                  )),
              SizedBox(
                width: w * 0.9,
                height: h*0.65,
                child: Column( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    Column(
                      children: [
                        const Row(
                          children: [
                            Text(
                              "New Password",
                              style: TextStyle(fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        TextFormField(
                          obscureText: a,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                              onTap: () {
                                a=!a;
                                setState(() {

                                });

                              },
                              child: Icon(a?Icons.visibility_sharp:Icons.visibility_off_sharp),
                            ),

                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(w * 0.02),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            hintText: ("Enter your password"),
                            label: const Text(""),
                            labelStyle: const TextStyle(color: Colors.grey),
                            border: const OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(w * 0.02)),
                            hintStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          controller: newPasswordController,
                          validator: (value) => passwordValidation(value!),
                          style: const TextStyle(color: Colors.black),

                        ),
                        const Row(
                          children: [
                            Text(
                              "Must contain 8 char.",
                              style: TextStyle(fontWeight: FontWeight.w400,color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),

                    Column(
                      children: [
                        const Row(
                          children: [
                            Text(
                              "Confirm Password",
                              style: TextStyle(fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        TextFormField(
                          obscureText: a,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                              onTap: () {
                                a=!a;
                                setState(() {

                                });

                              },
                              child: Icon(a?Icons.visibility_sharp:Icons.visibility_off_sharp),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(w * 0.02),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            hintText: ("Confirm your password"),
                            label: const Text(""),
                            labelStyle: const TextStyle(color: Colors.grey),
                            border: const OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(w * 0.02)),
                            hintStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          controller: confirmPasswordController,
                          validator: (value) => confirmPasswordValidation(value!),
                          style: const TextStyle(color: Colors.black),

                        ),
                      ],
                    ),

                    SizedBox(
                      height: h*0.05,
                    ),
                    GestureDetector(
                      onTap: () {
                        submitPasswordReset();
                        },
                      child: Container(
                        width: w*0.75,
                        height: h*0.05,
                        decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(w*0.05)
                        ),

                        child: const Center(
                          child: Text("Reset Password",style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
