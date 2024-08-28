import 'package:bank_loan/core/util/shared/theme.dart';
import 'package:bank_loan/features/home_page/presentation/view/home_page.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';

Widget easySplash() {
  return EasySplashScreen(
    logo: const Image(
      image: AssetImage('assets/images/logo.png'),
    ),
    title: const Text(
      "حاسبة القروض",
      style: TextStyle(
          fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    backgroundColor: defaultColor,
    showLoader: false,
    navigator: Directionality(
        textDirection: TextDirection.rtl, child: const HomePage()),
    durationInSeconds: 3,
  );
}
