import 'dart:async';

import 'package:fitness_tracker_app/constants/theme.dart';
import 'package:fitness_tracker_app/database/fitness_goaldb.dart';
import 'package:fitness_tracker_app/pages/about.dart';
import 'package:fitness_tracker_app/pages/editgoal_page.dart';
import 'package:fitness_tracker_app/pages/seven_days_progress_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:sensors_plus/sensors_plus.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  //late bool _isloading;
  int steps = 0;
  double calories = 0;
  double kilometers = 0;
  dynamic goalSteps = 10; // Set your daily goal steps here
  int points = 0;
  int points1 = 10;
  int points2 = 20;
  int points3 = 30;
  int points4 = 40;
  int points5 = 50;
  List<double> accelerationValues = List.filled(4, 0.0);
  List<double> previousValues = List.filled(4, 0.0);
  bool isWalking = false;

  final readdata = Get.put(fitnessgoal());

  //empty list
  List<Map<String, dynamic>> mtlist = [];

  Future<void> retrivegoal() async {
    final outputdata = await readdata.retrieve_datagoal();
    setState(() {
      mtlist = outputdata;
      goalSteps = mtlist[0]['goal'];
      print(goalSteps.toString());
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retrivegoal();
    // Start listening to accelerometer events
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        accelerationValues[0] = event.x;
        accelerationValues[1] = event.y;
        accelerationValues[2] = event.z;
        detectWalking();
        previousValues = List.from(accelerationValues); // Store previous values
      });
    });
  }

  void detectWalking() {
    final double threshold =
        15.0; // Threshold for significant change in acceleration

    double deltaX = (accelerationValues[0] - previousValues[0]).abs();
    double deltaY = (accelerationValues[1] - previousValues[1]).abs();
    double deltaZ = (accelerationValues[2] - previousValues[2]).abs();

    if (deltaX > threshold || deltaY > threshold || deltaZ > threshold) {
      // Detected a significant change, likely a step
      if (!isWalking) {
        setState(() {
          steps++;
          isWalking = true;
          calories = calculateCalories(steps);
          kilometers = calculateKilometers(steps);
          // points = calculatepoints(steps);
          print(points);
        });
      }
    } else {
      isWalking = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.sizeOf(context);
    //double displayWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: fgreydark,
        body: Padding(
          padding: const EdgeInsets.only(top: 70),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 90,
                  ),
                  child: SizedBox(
                    width: 210,
                    height: 210,
                    child: CircularProgressIndicator(
                      strokeCap: StrokeCap.round,
                      strokeWidth: 8,
                      value: 0,
                      backgroundColor: fredmid.withOpacity(0.1),
                      valueColor: AlwaysStoppedAnimation<Color>(fredmid),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 75),
                    child: Text(
                      '$points',
                      style: GoogleFonts.montserrat(
                        fontSize: 50,
                        color: fredmid,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 28,
                    left: 107,
                  ),
                  child: SizedBox(
                    width: 175,
                    height: 175,
                    child: CircularProgressIndicator(
                      strokeWidth: 8,
                      value:
                          steps.toDouble() / double.parse(goalSteps.toString()),
                      backgroundColor: fcyan.withOpacity(0.1),
                      valueColor: AlwaysStoppedAnimation<Color>(fcyan),
                      strokeCap: StrokeCap.round,
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 120),
                    child: Text(
                      '$steps',
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        color: fcyan,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 270, left: 100),
                      child: Row(
                        children: [
                          Icon(
                            TeenyIcons.heart_small,
                            size: 30,
                            color: fredmid,
                          ),
                          Text(
                            'points',
                            style: GoogleFonts.montserrat(
                              fontSize: 13,
                              color: fwhite,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 270, left: 45),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: SvgPicture.asset(
                              'assets/shoe.svg',
                              height: 30,
                              width: 30,
                              //color: fcyan,
                            ),
                          ),
                          Text(
                            'Steps',
                            style: GoogleFonts.montserrat(
                              fontSize: 13,
                              color: fwhite,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 320, left: 98),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 46),
                            child: Center(
                              child: Text(
                                '${calories.toStringAsFixed(1)}',
                                style: GoogleFonts.montserrat(
                                  fontSize: 25,
                                  color: fredmid,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 55),
                            child: Text(
                              '${kilometers.toStringAsFixed(1)}',
                              style: GoogleFonts.montserrat(
                                fontSize: 25,
                                color: fredmid,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 146),
                      child: Row(
                        children: [
                          Text(
                            'cal',
                            style: GoogleFonts.montserrat(
                              fontSize: 15,
                              color: fwhite.withOpacity(0.6),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 65),
                            child: Text(
                              'km',
                              style: GoogleFonts.montserrat(
                                fontSize: 15,
                                color: fwhite.withOpacity(0.6),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 30, left: 30, right: 30),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(aboutpage());
                        },
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => ProgressPage());
                          },
                          child: Container(
                            height: screensize.height * 0.2,
                            width: screensize.width * 0.95,
                            decoration: BoxDecoration(
                              color: fgrey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 30, left: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Your progress !',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 18,
                                      color: fcyan,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'last 7 days',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          color: fwhitelite,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 190, top: 23),
                                        child: Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          size: 20,
                                          color: fwhite,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 70,
                                    ),
                                    child: Text(
                                      'Track your weekly progress and examine your limts !',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 15,
                                        color: fwhite,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 30, left: 50, right: 50),
                      child: Text(
                        'Surpass your limts and savour the feel of being FIT',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                            fontSize: 15,
                            color: fwhitelite,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 30, right: 30),
                      child: Container(
                        height: screensize.height * 0.2,
                        width: screensize.width * 0.95,
                        decoration: BoxDecoration(
                          color: fgrey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, left: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Double your points ',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 18,
                                      color: fredmid,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  LottieBuilder.asset(
                                    'assets/heart_ani.json',
                                    height: 80,
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 70,
                                  top: 20,
                                ),
                                child: Text(
                                  'Double your points by achieving and surpassing your goals.',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 15,
                                    color: fwhite,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 30, right: 30),
                      child: Container(
                        height: screensize.height * 0.2,
                        width: screensize.width * 0.95,
                        decoration: BoxDecoration(
                          color: fgrey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30, left: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 27),
                                    child: Text(
                                      'Burn your Calories !',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 18,
                                        color: forange,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: LottieBuilder.asset(
                                            'assets/fire_ani.json'),
                                      )),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 70,
                                  top: 20,
                                ),
                                child: Text(
                                  'Sweating out the calories, one workout at a time.',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 15,
                                    color: fwhite,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 30, right: 30),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(goaledit());
                        },
                        child: Container(
                          height: screensize.height * 0.2,
                          width: screensize.width * 0.95,
                          decoration: BoxDecoration(
                            color: fgrey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, left: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Change your goals ! ',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 18,
                                        color: fcyan,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: LottieBuilder.asset(
                                          'assets/goal_ani.json',
                                          height: 100,
                                        )),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    right: 70,
                                    top: 0,
                                  ),
                                  child: Text(
                                    'Click here to change your goals. If needed !',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      color: fwhite,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 250),
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 20,
                                    color: fwhite,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  double calculateCalories(int steps) {
    // Assuming a formula to calculate calories based on steps

    return steps / 100; // Adjust as per your calculation
  }

  double calculateKilometers(int steps) {
    // Assuming a formula to convert steps to kilometers
    return steps * 0.000700; // Adjust as per your calculation
  }
}
