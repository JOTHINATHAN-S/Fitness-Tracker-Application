import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:fitness_tracker_app/constants/theme.dart';
import 'package:fitness_tracker_app/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class scrn extends StatelessWidget {
  const scrn({super.key});

  _storeOnboardInfo() async {
    // ignore: avoid_print
    print("Shared pref called");
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
    // ignore: avoid_print
    print(prefs.getInt('onBoard'));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash: 'assets/Untitled-2.gif',
        splashIconSize: 100000.0,
        centered: true,
        nextScreen: welcomepage(),
        backgroundColor: fblack,
        duration: 4200,
      ),
    );
  }
}
