import 'package:codeedex_task/home%20screen/screen/home_screen.dart';
import 'package:codeedex_task/login%20screen/screen/login_screen.dart';
import 'package:codeedex_task/forget%20password/newpasswordset_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ApiServices {
  String baseUrl = 'https://prethewram.pythonanywhere.com/api/';

  ///Login Users
  Future<void> loginUser(
      String email, String password, BuildContext context)
  async {
    final String loginUrl = '${baseUrl}login/';

    try {
      final response = await http.post(
        Uri.parse(loginUrl),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 403) {
        Map responseData = jsonDecode(response.body);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(responseData['detail'])));
      }

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreenPage()),
              (Route<dynamic> route) => false,
        );


        String token = responseData['token'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token);
        print('Login successful. Token: $token');
      } else {
        final responseData = jsonDecode(response.body);
        print('Login failed: ${responseData['error'] ?? 'Unknown error'}');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  ///Register
  Future<Map<String, dynamic>> registerUser(String name, String email, String password) async {
    final String registerUrl = '${baseUrl}register/';

    try {
      final response = await http.post(
        Uri.parse(registerUrl),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          "confirm_password": password
        }),
      );
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        print('Registration successful: ${responseData['message']}');
        return responseData;
      } else {
        final responseData = jsonDecode(response.body);
        print('Registration failed: ${responseData['message']}');
        return responseData;
      }
    } catch (e) {
      print('An error occurred: $e');
      return {'message': 'An error occurred', 'status': false};
    }
  }

  ///Otp Verification
  Future<void> verifyOtp(BuildContext context, String email, String otpCode) async {
    final String baseUrl = 'https://prethewram.pythonanywhere.com/api/';
    final String endpoint = 'verify-otp/';
    final String url = '$baseUrl$endpoint';


    Map<String, dynamic> requestBody = {
      'email': email,
      'otp': otpCode,
    };

    try {

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );


      if (response.statusCode == 200) {

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('OTP verified successfully.'),
        ));
         print(requestBody);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreenPage()),
        );
      } else {
        var responseBody = jsonDecode(response.body);
        var errorMessage = responseBody['message'] ?? 'OTP verification failed';

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorMessage),
        ));
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An error occurred. Please try again later.'),
      ));
      print('Error: $error');
    }
  }



  Future<bool> requestPasswordReset(String email) async {
    final String apiUrl =
        "https://prethewram.pythonanywhere.com/api/password-reset/";

    try {

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
        }),
      );

      print(response.body);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['success'] == true) {
          return true;
        } else {

          print('Error: ${responseData['message']}');
          return false;
        }
      } else {

        print(
            'Failed to send password reset request. Status code: ${response.statusCode}');
        return false;
      }
    } catch (error) {

      print('Error sending password reset request: $error');
      return false;
    }
  }

  Future<void> verifyPasswordOtp(
      BuildContext context, String otpCode, String email) async {
    final String baseUrl = 'https://prethewram.pythonanywhere.com/api/';
    final String endpoint = 'password-otp/';
    final String url = '$baseUrl$endpoint';


    Map<String, dynamic> requestBody = {'otp': otpCode, 'email': email};

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('OTP verified successfully.'),
        ));


        print(response.body);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => NewPasswordSetPage(
              email: email,
              otp: otpCode,
            ),
          ),
        );

      } else {
        var errorMessage =
            jsonDecode(response.body)['message'] ?? 'OTP verification failed';
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorMessage),
        ));
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An error occurred. Please try again later.'),
      ));
      print('Error: $error');
    }
  }

  Future<void> resetPassword(BuildContext context, String newPassword,
      String confirmPassword, String email, String otp) async {
    final String baseUrl = 'https://prethewram.pythonanywhere.com/api/';
    final String endpoint = 'change-password/';
    final String url = '$baseUrl$endpoint';

    if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Passwords do not match.'),
      ));
      return;
    }

    Map<String, dynamic> requestBody = {
      'new_password': newPassword,
      'confirm_new_password': confirmPassword,
      'email': email,
      'otp': otp,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );
      print(response.body);

      if (response.statusCode == 200) {
        // Password reset was successful
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Password changed successfully. Please log in with your new password.'),
        ));

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreenPage(),
            ));
      } else {
        var errorMessage =
            jsonDecode(response.body)['message'] ?? 'Password reset failed';
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorMessage),
        ));
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An error occurred. Please try again later.'),
      ));
      print('Error: $error');
    }
  }

  Future<List<dynamic>> fetchProducts(BuildContext context) async {
    final String baseUrl = 'https://prethewram.pythonanywhere.com/api/';
    final String endpoint = 'parts_categories/';
    final String url = '$baseUrl$endpoint';

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token =
        prefs.getString('token');

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Authentication token not found. Please log in again.')),
      );
      return [];
    }

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to fetch products: ${response.statusCode}'),
        ));
        return [];
      }
    } catch (error) {

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error fetching products.'),
      ));
      return [];
    }
  }
}
