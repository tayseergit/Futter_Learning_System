import 'dart:async';

import 'package:learning_project/Constant/images.dart';
import 'package:learning_project/Constant/public_constant.dart';
import 'package:learning_project/Helper/cach_helper.dart';
import 'package:learning_project/Module/Auth/View/Login.dart';
import 'package:learning_project/Module/Onboarding/View/onboarding_page.dart';
import 'package:learning_project/Module/home_page/View/home_page.dart';
 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning_project/Utils/App_color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Zoom out animation: from scale 1.5 to 1.0 (or 0.0 if you want it to disappear)
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(_controller); // Dummy to keep the old reference if needed

    _controller.forward();

    // CacheHelper.removeAllData();
    Timer(const Duration(seconds: 2), () {
      if (CacheHelper.getData(key: "onboard") == null) {
        pushAndRemoveUntiTo(context: context, toPage: OnboardingPage());
      } else if (CacheHelper.getData(key: "token") == null) {
        pushAndRemoveUntiTo(context: context, toPage: LoginPage());
      } else {
        pushAndRemoveUntiTo(context: context, toPage: const HomePage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Center(
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.2, end: 1.5).animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeOut),
          ),
          child: Image.asset(Images.offersBack, width: 200.w),
        ),
      ),
    );
  }
}
