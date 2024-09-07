import 'package:codeedex_task/login_screen.dart';
import 'package:codeedex_task/newpasswordset_screen.dart';
import 'package:codeedex_task/services/api_services.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class OtpScreenPage extends StatefulWidget {
  const OtpScreenPage({super.key});

  @override
  State<OtpScreenPage> createState() => _OtpScreenPageState();
}

class _OtpScreenPageState extends State<OtpScreenPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController otpController = TextEditingController();
  String? validateOtp(String value) {
    if (value.isEmpty) {
      return 'Please enter the OTP';
    }
    if (value.length != 4) {
      return 'OTP should be 6 digits';
    }
    return null;
  }
  void submitOtp()  {
    if (_formKey.currentState!.validate()) {
  ApiServices().verifyOtp(context,otpController.text);
   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreenPage(),));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
         key: _formKey,
          child: Column(
            children: [
              Center(
                  child: Text(
                    "Verify Account",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: w * 0.06),
                  )),
              SizedBox(height: h*0.02,),
              Center(
                  child: Text(
                    "Code has been send to johndoe@gmail.com.",
                    style: TextStyle( fontSize: w * 0.03),
                  )),
              Center(
                  child: Text(
                    "Enter the code to verify your account.",
                    style: TextStyle( fontSize: w * 0.03),
                  )),
              SizedBox(height: h*0.02,),
              TextFormField(
                 maxLength: 6,
                controller: otpController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Enter OTP'),
                  validator: (value) => validateOtp(value!)
              ),
              SizedBox(height: 20),


              GestureDetector(
                onTap: () {
                  submitOtp();
                },

                child: Text('Verify OTP'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
