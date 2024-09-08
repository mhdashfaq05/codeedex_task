import 'package:codeedex_task/services/api_services.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class OtpScreenPage extends StatefulWidget {
  final String email;

  const OtpScreenPage({super.key, required this.email});

  @override
  State<OtpScreenPage> createState() => _OtpScreenPageState();
}

class _OtpScreenPageState extends State<OtpScreenPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController otpController = TextEditingController();
  void submitOtp() {
    if (_formKey.currentState!.validate()) {
      ApiServices()
          .verifyPasswordOtp(context, otpController.text, widget.email);
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
                style:
                    TextStyle(fontWeight: FontWeight.w700, fontSize: w * 0.06),
              )),
              SizedBox(
                height: h * 0.02,
              ),
              Center(
                  child: Text(
                "Code has been send to your email.",
                style: TextStyle(fontSize: w * 0.03),
              )),
              Center(
                  child: Text(
                "Enter the code to verify your account.",
                style: TextStyle(fontSize: w * 0.03),
              )),
              SizedBox(
                height: h * 0.02,
              ),
              TextFormField(
                maxLength: 4,
                controller: otpController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Enter OTP'),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  submitOtp();
                },
                child:  const Text('Verify OTP'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
