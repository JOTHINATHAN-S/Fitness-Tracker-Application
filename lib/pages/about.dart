import 'package:fitness_tracker_app/constants/theme.dart';
import 'package:fitness_tracker_app/database/fitness_height_weight.dart';
import 'package:fitness_tracker_app/pages/goals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class aboutpage extends StatefulWidget {
  const aboutpage({super.key});

  @override
  State<aboutpage> createState() => _aboutpageState();
}

class _aboutpageState extends State<aboutpage> {
  bool isbuttonenable = false;

  var heightcontroll = TextEditingController();
  var weightcontroll = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    heightcontroll.addListener(_validateform);
    weightcontroll.addListener(_validateform);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    heightcontroll.dispose();
    weightcontroll.dispose();
    super.dispose();
  }

  //validation

  void _validateform() {
    setState(() {
      isbuttonenable =
          heightcontroll.text.isNotEmpty && weightcontroll.text.isNotEmpty;
    });
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

    final fitnessDB_hw = Get.put(
      fitnesshw(),
    );
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 130,
        backgroundColor: fgreydark,
        leading: IconButton(
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
      backgroundColor: fgreydark,
      body: Column(
        children: [
          Icon(
            TeenyIcons.heart,
            size: 50,
            color: fcyan,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                'About you !',
                style: GoogleFonts.montserrat(
                  fontSize: 33,
                  color: fredmid,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 30, left: 70, right: 70),
              child: Text(
                textAlign: TextAlign.center,
                'This information let us to estimate calories, distance and the intensity of your activity',
                style: GoogleFonts.montserrat(
                    fontSize: 15, color: fwhite.withOpacity(0.7)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Container(
              height: screensize.height * 0.050,
              width: screensize.width * 0.70,
              decoration: BoxDecoration(
                color: fgrey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: heightcontroll, //controller
                cursorColor: fredmid,
                style: GoogleFonts.montserrat(
                  fontSize: 15,
                  color: fwhite,
                ),
                decoration: InputDecoration(
                  hintText: 'Enter your height(cm)',
                  prefixIcon: Icon(
                    Icons.architecture_rounded,
                    size: 20,
                    color: fwhitelite,
                  ),
                  hintStyle: GoogleFonts.montserrat(
                    fontSize: 15,
                    color: fwhitelite,
                  ),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Container(
              height: screensize.height * 0.050,
              width: screensize.width * 0.70,
              decoration: BoxDecoration(
                color: fgrey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: weightcontroll, //controller
                cursorColor: fredmid,
                style: GoogleFonts.montserrat(
                  fontSize: 15,
                  color: fwhite,
                ),
                decoration: InputDecoration(
                  hintText: 'Enter your weight(kg)',
                  prefixIcon: Icon(
                    Icons.monitor_weight_rounded,
                    size: 20,
                    color: fwhitelite,
                  ),
                  hintStyle: GoogleFonts.montserrat(
                    fontSize: 15,
                    color: fwhitelite,
                  ),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 70, left: 110),
            child: Center(
              child: Row(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const goalpage(),
                        ),
                      );
                    },
                    child: Text(
                      'Skip',
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        color: fwhite,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: isbuttonenable
                              ? () async {
                                  Map<String, dynamic> data = {
                                    'height': heightcontroll.text,
                                    'weight': weightcontroll.text,
                                  };
                                  //insert data from frontend - backend
                                  await fitnessDB_hw.insertdatahw(data);
                                  await _storeOnboardInfo();
                                  Get.to(() => goalpage());
                                }
                              : () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      backgroundColor:
                                          const Color.fromARGB(255, 34, 34, 34),
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
                                        'Please fill all the required fields or tap "Skip" to continue!',
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
                              color:
                                  isbuttonenable ? fredmid : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                'NEXT',
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
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
