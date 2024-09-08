import 'package:codeedex_task/login%20screen/screen/login_screen.dart';
import 'package:codeedex_task/register%20screens/registerotp_screen.dart';
import 'package:codeedex_task/services/api_services.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class RegisterScreenPage extends StatefulWidget {
  const RegisterScreenPage({super.key});

  @override
  State<RegisterScreenPage> createState() => _RegisterScreenPageState();
}

class _RegisterScreenPageState extends State<RegisterScreenPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final validatePassword =
  RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  final validateEmail = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
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
    } else if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }
  void submitForm() async {
    if (_formKey.currentState!.validate()) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registering...'), duration: Duration(seconds: 2)),
      );


      final response = await ApiServices().registerUser(
        nameController.text,
        emailController.text,
        passwordController.text,
      );

      if (response['message'] == "Email already registered") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email already registered, please login')),
        );
      } else if (response['status'] == true) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RegisterOtpScreenPage(email: emailController.text),
          ),
        );
      } else {
        // Show any other error messages
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['message'] ?? 'Registration failed')),
        );
      }
    }
  }
  bool a=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key:_formKey,
          child: Column(
            children: [
              Center(
                  child: Text(
                    "Register",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: w * 0.06),
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
                              "Full Name",
                              style: TextStyle(fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: nameController,

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
                        const Row(
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
                         validator: (value) {
                           if (validateEmail.hasMatch(value!)){
                             return null;

                           }
                           else{
                             return "Enter a valid Email";
                           }
                         },
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
                        const Row(
                          children: [
                            Text(
                              "Password",
                              style: TextStyle(fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        TextFormField(
                          obscureText: a,
                          keyboardType: TextInputType.emailAddress,decoration:InputDecoration(
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
                          controller: passwordController,
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
                        submitForm();

                      },
                      child: Container(
                        width: w*0.75,
                        height: h*0.05,
                        decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(w*0.05)
                        ),

                        child: const Center(
                          child: Text("Create Account",style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreenPage(),));
                  },
                  child: const Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have a account? "),
                      Text("Login here",style: TextStyle(color: Colors.blue),),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
