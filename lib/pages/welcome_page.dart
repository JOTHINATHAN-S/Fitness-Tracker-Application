import 'package:fitness_tracker_app/constants/theme.dart';
import 'package:fitness_tracker_app/main.dart';
//import 'package:fitness_tracker_app/pages/bottomnavar.dart';
import 'package:fitness_tracker_app/pages/loadingpage.dart';
import 'package:fitness_tracker_app/pages/user_details_stful.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isviewed = prefs.getInt('onBoard');
}

class welcomepage extends StatelessWidget {
  const welcomepage({super.key});

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
    final screensize = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: fgreydark,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 200, left: 38),
              child: SvgPicture.asset(
                'assets/detailed_logo(1).svg',
                height: 170,
                width: 170,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                "Sleep, Exercise, Nutrition",
                style: GoogleFonts.josefinSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: fwhite,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 130,
                left: 30,
              ),
              child: Text(
                "GREETINGS !",
                style: GoogleFonts.montserrat(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: fwhite,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text(
                'Welcome to ZEN,',
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: fwhite,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text(
                'want to check your workout progress ?',
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: fwhite,
                ),
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            Center(
              child: GestureDetector(
                onTap: () async {
                  //await _storeOnboardInfo();
                  Get.to(
                    isviewed != 0 ? const userd() : const loadingpage(),
                  );
                },
                child: Container(
                  height: screensize.height * 0.07,
                  width: screensize.width * 0.5,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: fredmid,
                    //borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    // child: Text(
                    //   'Get Started !',
                    //   style: GoogleFonts.montserrat(
                    //     fontSize: 23,
                    //     color: fwhite,
                    //     fontWeight: FontWeight.w800,
                    //   ),
                    // ),
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      size: 30,
                      color: fblack,
                      weight: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
