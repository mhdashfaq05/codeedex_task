import 'package:codeedex_task/home_screen.dart';
import 'package:codeedex_task/passwordreset_screen.dart';
import 'package:codeedex_task/services/api_services.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class LoginScreenPage extends StatefulWidget {
  const LoginScreenPage({super.key});

  @override
  State<LoginScreenPage> createState() => _LoginScreenPageState();
}

class _LoginScreenPageState extends State<LoginScreenPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final validatePassword =
  RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  final validateEmail = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  String? passwordValidation(String value) {
    if (value.isEmpty) {
      return 'Please enter your password';
    } else if (!validatePassword.hasMatch(value)) {
      return 'Password must contain at least 8 characters, including:\n- One uppercase letter\n- One lowercase letter\n- One number\n- One special character';
    }
    return null;
  }
  String? emailValidation(String value) {
    if (value.isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: Center(child: Text("Login Screen")),
          ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Center(
                  child: Text(
                "Login",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: w * 0.06),
              )),
              Container(
                width: w * 0.9,
                height: h*0.5,
                child: Column( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "E-mail",
                              style: TextStyle(fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          validator: (value) => emailValidation(value!),
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(w * 0.02),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                           hintText: ("Enter your email"),
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
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Password",
                              style: TextStyle(fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: passwordController,
                          validator: (value) => passwordValidation(value!),
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
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
                        ),
                      ],
                    ),
                    Row( mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => PasswordResetScreen(),));
                            },
                            child: Text("Forgot Password?",style: TextStyle(color: Colors.blue,decoration: TextDecoration.underline,decorationColor: Colors.blue),)),
                      ],
                    ),

                    GestureDetector(
                      onTap: () {
                        ApiServices().loginUser(emailController.text, passwordController.text,context);
                      },
                      child: Container(
                        width: w*0.75,
                        height: h*0.05,
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(w*0.05)
                        ),

                        child: Center(
                          child: Text("Login",style: TextStyle(color: Colors.white),),
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
