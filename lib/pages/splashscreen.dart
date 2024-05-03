import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nomnom/pages/onboard.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash>{
  @override
  void initState() {
    super.initState();
    // Add a delay before navigating to the Onboard screen
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Onboard()), // Navigate to Onboard screen
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD61C38),
      body: SafeArea(
        child: Center(
          child: Image.asset(
            "assets/logo.png",
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width / 1.7,
            height: MediaQuery.of(context).size.height / 2.6,
          ),
        ),
      ),
    );
  }
}
