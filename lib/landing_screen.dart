import 'package:codeedex_task/login_screen.dart';
import 'package:codeedex_task/register_screen.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class LandingScreenPage extends StatefulWidget {
  const LandingScreenPage({super.key});

  @override
  State<LandingScreenPage> createState() => _LandingScreenPageState();
}

class _LandingScreenPageState extends State<LandingScreenPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column( mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: h*0.2,
              width: w*0.75,
             // color: Colors.blue,
              child: Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, DialogRoute(context: context, builder: (context) => RegisterScreenPage(),));
                    },
                    child: Container(
                      width: w*0.33,
                      height: h*0.063,
                      decoration: BoxDecoration(
                          //color: Colors.blue,
                          borderRadius: BorderRadius.circular(w*0.05),
                        border: Border.all(width: 2)
                      ),
                      child:  Center(child: Text("Register",style: TextStyle(fontSize: w*0.04),)),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, DialogRoute(context: context, builder: (context) => LoginScreenPage(),));
                    },
                    child: Container(
                      width: w*0.33,
                      height: h*0.063,
                      decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(w*0.05),
                          //border: Border.all(width: 2)
                      ),
                      child: Center(child: Text("Login",style: TextStyle(fontSize: w*0.04),)),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
