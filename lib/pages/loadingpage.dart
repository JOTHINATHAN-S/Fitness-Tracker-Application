//import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:fitness_tracker_app/constants/theme.dart';
import 'package:fitness_tracker_app/pages/bottomnavar.dart';
//import 'package:fitness_tracker_app/pages/home_page.dart';
//import 'package:fitness_tracker_app/pages/about.dart';
//import 'package:fitness_tracker_app/pages/user_details_stful.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class loadingpage extends StatefulWidget {
  const loadingpage({super.key});

  @override
  State<loadingpage> createState() => _loadingpageState();
}

class _loadingpageState extends State<loadingpage>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  get splash => null;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: fgreydark,
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 170, left: 20),
              child: Container(
                height: screensize.height * .5,
                width: screensize.width * 0.50,
                decoration: BoxDecoration(
                  //color: fcyan,
                  shape: BoxShape.circle,
                  border: Border.all(width: 2, color: Colors.transparent),
                ),
                child: Lottie.asset('assets/phone_run.json',
                    controller: _controller, onLoaded: (compos) {
                  _controller
                    ..duration = compos.duration
                    ..forward().then(
                      (value) {
                        Get.to(BottomNavBar());
                      },
                    );
                }),
              ),
            ),
          ),
          Text(
            'Setting up your account.....',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: fwhitelite,
            ),
          ),
        ],
      ),
    );
    // return AnimatedSplashScreen(
    //   splash: Column(
    //     children: [LottieBuilder.asset('assets/phone_run.json')],
    //   ),
    //   nextScreen: const aboutpage(),
    //   splashIconSize: 40,
    //   backgroundColor: fgreydark,
    // );
  }
}
