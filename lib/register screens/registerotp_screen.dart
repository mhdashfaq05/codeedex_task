import 'package:codeedex_task/services/api_services.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class RegisterOtpScreenPage extends StatefulWidget {
  final String email; // Make this field final

  const RegisterOtpScreenPage(
      {super.key, required this.email}); // Use const constructor

  @override
  State<RegisterOtpScreenPage> createState() => _RegisterOtpScreenPageState();
}

class _RegisterOtpScreenPageState extends State<RegisterOtpScreenPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController otpController = TextEditingController();

  String? validateOtp(String value) {
    if (value.isEmpty) {
      return 'Please enter the OTP';
    }
    if (value.length != 4) {
      return 'OTP should be 4 digits';
    }
    return null;
  }

  void submitOtp(String email) {
    if (_formKey.currentState!.validate()) {
      ApiServices().verifyOtp(context, widget.email, otpController.text);
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
              Center(
                child: Text(
                  "Verify Account",
                  style: TextStyle(
                      fontWeight: FontWeight.w700, fontSize: w * 0.06),
                ),
              ),
              SizedBox(height: h * 0.02),
              Center(
                child: Text(
                  "Code has been sent to ${widget.email}",
                  style: TextStyle(fontSize: w * 0.03),
                ),
              ),
              Center(
                child: Text(
                  "Enter the code to verify your account.",
                  style: TextStyle(fontSize: w * 0.03),
                ),
              ),
              SizedBox(height: h * 0.02),
              TextFormField(
                maxLength: 4,
                controller: otpController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Enter OTP'),
                validator: (value) => validateOtp(value!),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  submitOtp(widget.email);
                },
                child: const Text('Verify OTP'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
