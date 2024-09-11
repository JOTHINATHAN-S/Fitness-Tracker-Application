import 'package:fitness_tracker_app/constants/theme.dart';
import 'package:fitness_tracker_app/database/fitness_goaldb.dart';
import 'package:fitness_tracker_app/pages/bottomnavar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class goaledit extends StatefulWidget {
  const goaledit({super.key});

  @override
  State<goaledit> createState() => _goaleditState();
}

class _goaleditState extends State<goaledit> {
  final fitnessregoal = Get.put(fitnessgoal());
  // radio widget
  int selected = 0; //radio box variable
  List<Map<String, dynamic>> fitgoal = [];

  //condition button default value
  bool isbuttonenable = false;
  int userId = 1;

  void _validateform() {
    isbuttonenable = selected != 0;
  }

  void _fetchUserData() async {
    try {
      var userData = await fitnessregoal.getUserById(userId);
      setState(() {
        selected =
            goalMap.keys.firstWhere((k) => goalMap[k] == userData['goal']);
      });
    } catch (e) {
      // Handle error
    }
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

  Future<void> retrievedata() async {
    final outputdata = await fitnessregoal.retrieve_datagoal();
    if (mounted) {
      setState(() {
        fitgoal = outputdata;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retrievedata();
    _fetchUserData();
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

  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: fgreydark,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              Row(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BottomNavBar(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          color: fwhite,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: isbuttonenable
                        ? () async {
                            print('Save button tapped');
                            String? selectedGoal = goalMap[selected];
                            Map<String, dynamic> data = {
                              'goal': selectedGoal, //store the gender
                            };
                            // // Update data from frontend to backend
                            // print('Updating data...');
                            // await FitnessDB.update_data(userId, data);
                            // print('Navigation to next page...');
                            // Get.to(accpage());
                            await fitnessregoal.update_datagoal(userId, data);
                            Get.to(() => BottomNavBar());
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
                                  'Select a Goal to continue',
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
                    child: Padding(
                      padding: const EdgeInsets.only(left: 200),
                      child: Container(
                        height: screensize.height * 0.045,
                        width: screensize.width * 0.20,
                        decoration: BoxDecoration(
                          color: isbuttonenable ? fredmid : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'SAVE',
                              style: GoogleFonts.montserrat(
                                fontSize: 17,
                                color: fwhite,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Stack(
                //alignment: Alignment.topLeft,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50, right: 120),
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
                    padding: const EdgeInsets.only(top: 123, left: 145),
                    child: Text(
                      textAlign: TextAlign.center,
                      'Current',
                      style: GoogleFonts.montserrat(
                        fontSize: 30,
                        color: fcyan,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 152, left: 145),
                    child: Text(
                      'GOAL !',
                      style: GoogleFonts.montserrat(
                        fontSize: 45,
                        color: fredmid,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  textAlign: TextAlign.center,
                  fitgoal[0]['goal'].toString(),
                  style: GoogleFonts.montserrat(
                    fontSize: 48,
                    color: fcyan,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Column(
                    children: [
                      Text(
                        'Want to change your Goal ?',
                        style: GoogleFonts.montserrat(
                          fontSize: 30,
                          color: fwhite,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Select to change your previous goal',
                        style: GoogleFonts.montserrat(
                          fontSize: 15,
                          color: fwhite,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 70, left: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 58),
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
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
