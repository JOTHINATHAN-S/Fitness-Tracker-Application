import 'dart:async';

import 'package:fitness_tracker_app/database/fitness_goaldb.dart';
import 'package:fitness_tracker_app/pages/loadingpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:fitness_tracker_app/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class goalpage extends StatefulWidget {
  const goalpage({super.key});

  @override
  State<goalpage> createState() => _goalpageState();
}

class _goalpageState extends State<goalpage> {
  // radio widget
  int selected = 0; //radio box variable

  //condition button default value
  bool isbuttonenable = false;

  void _validateform() {
    isbuttonenable = selected != 0;
  }

  // Map to link index to goal string values
  final Map<int, String> goalMap = {
    1: '5000',
    2: '10000',
    3: '15000',
    4: '20000',
    5: '25000',
  };

  //Map to link index to points string values
  final Map<int, String> pointMap = {
    1: '10',
    2: '20',
    3: '30',
    4: '40',
    5: '50',
  };

  // Function to save the selected goal and points to the database

  Future<void> savegoaltodb(
      int selectedgoalindex, int selectedpointindex) async {
    final fitnessdbgoal = Get.put(fitnessgoal());
    String? selectedgoal = goalMap[selectedgoalindex];
    String? selectedpoint = pointMap[selectedpointindex];
    print(selectedgoal);
    print(selectedpoint);
    if (selectedgoal != null && selectedpoint != null) {
      Map<String, dynamic> data = {
        'goal': selectedgoal,
        'point': selectedpoint,
      };

      // Insert data from frontend to backend
      await fitnessdbgoal.insertdatagoal(data);
    }
  }

  Widget customRadio(String text, int index, String text1) {
    //radio box widget
    return OutlinedButton(
      //radio box widget
      onPressed: () {
        setState(() {
          selected = index;
        });
        _validateform();
      },

      // child: Text(
      //   text,
      //   style: GoogleFonts.montserrat(
      //     color: (selected == index) ? fredmid : fwhitelite,
      //   ),
      // ),
      style: OutlinedButton.styleFrom(
        fixedSize: Size(250, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        side: BorderSide(
          color: (selected == index) ? fredmid : fwhitelite,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.flag,
            color: (selected == index) ? fredmid : fwhitelite,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: GoogleFonts.montserrat(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: (selected == index) ? fredmid : fwhitelite,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              '/',
              style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: (selected == index) ? fwhite : fwhitelite,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Icon(
              Icons.favorite,
              color: (selected == index) ? fcyan : fwhitelite,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              text1,
              style: GoogleFonts.montserrat(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: (selected == index) ? fcyan : fwhitelite,
              ),
            ),
          )
        ],
      ),
    );
  }

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

    // final fitnessDB_goal = Get.put(
    //   fitnessgoal(),
    // );
    return Scaffold(
      backgroundColor: fgreydark,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 70),
              child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  size: 20,
                  color: fwhite,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 150),
              child: Container(
                height: screensize.height * .2,
                width: screensize.width * 0.6,
                decoration: BoxDecoration(
                  //color: fcyan,
                  shape: BoxShape.circle,
                  border: Border.all(width: 2, color: Colors.transparent),
                ),
                child: Lottie.asset(
                  'assets/man_flag.json',
                  repeat: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 250, left: 145),
              child: Text(
                'GOAL !',
                style: GoogleFonts.montserrat(
                  fontSize: 45,
                  color: fredmid,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 350),
                child: Column(
                  children: [
                    Text(
                      'Choose your goal!',
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        color: fwhite,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: Text(
                        textAlign: TextAlign.center,
                        'Set your goal to get motivated every time ! and you get points according to the goals',
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          color: fwhite.withOpacity(0.7),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      '(You can also change your goals after signing)',
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                        color: fwhitelite.withOpacity(0.7),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40, left: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 68),
                                child: customRadio('5000', 1, '10'),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: customRadio('10,000', 2, '20'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: customRadio('15,000', 3, '30'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: customRadio('20,000', 4, '40'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: customRadio('25,000', 5, '50'),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 134, top: 80, bottom: 100),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: isbuttonenable
                                ? () async {
                                    // Map<String, dynamic> data = {
                                    //   'height': heightcontroll.text,
                                    //   'weight': weightcontroll.text,
                                    // };
                                    // //insert data from frontend - backend
                                    // await fitnessDB_hw.insertdatahw(data);

                                    await savegoaltodb(selected, selected);
                                    await _storeOnboardInfo();
                                    Get.to(() => loadingpage());
                                  }
                                : () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        backgroundColor: const Color.fromARGB(
                                            255, 34, 34, 34),
                                        title: Text(
                                          'Sorry!',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                        content: Text(
                                          textAlign: TextAlign.center,
                                          'Please select a goal to Continue !',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: fwhite,
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              'OK!',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: fwhite,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                            child: Container(
                              height: screensize.height * 0.060,
                              width: screensize.width * 0.30,
                              decoration: BoxDecoration(
                                color: isbuttonenable
                                    ? fredmid
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  'FINISH',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 20,
                                    color: fwhite,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
