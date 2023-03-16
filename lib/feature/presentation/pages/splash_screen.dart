import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vacancies/common/horizontal_gradient_style.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 4), (() {
      Navigator.of(context).pushReplacementNamed('/homePage');
    }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const HorizontalGradientStyle(
      widget: Image(image: AssetImage('images/chair_vacant.gif')),
    );
  }
}
