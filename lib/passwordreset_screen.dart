import 'package:codeedex_task/main.dart';
import 'package:codeedex_task/passwordotp_screen.dart';
import 'package:codeedex_task/services/api_services.dart';
import 'package:flutter/material.dart';

class PasswordResetScreen extends StatefulWidget {

  const PasswordResetScreen({super.key});

  @override
  _PasswordResetScreenState createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  void handlePasswordReset() async {
    if (_formKey.currentState!.validate()) {

           ApiServices().requestPasswordReset(emailController.text);
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OtpScreenPage(email:emailController.text ,),));

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: h * 0.05,
              ),
              Text(
                'Enter your valid email to reset your password',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: h * 0.1),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              GestureDetector(

                onTap: () {
                  handlePasswordReset();
                },
                child: Text(
                  'Request Password Reset',
                  style: TextStyle(
                     // decoration: TextDecoration.underline,
                      decorationThickness: 2,
                      decorationColor: Colors.teal,
                      color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
