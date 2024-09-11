import 'package:fitness_tracker_app/constants/theme.dart';
//import 'package:fitness_tracker_app/database/fitness_SQFlite.dart';
import 'package:fitness_tracker_app/database/fitness_height_weight.dart';
//import 'package:fitness_tracker_app/pages/account_page.dart';
import 'package:fitness_tracker_app/pages/bottomnavar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:intl_phone_field/intl_phone_field.dart';

class editscrnhw extends StatefulWidget {
  const editscrnhw({super.key});

  @override
  State<editscrnhw> createState() => _editscrnhwState();
}

class _editscrnhwState extends State<editscrnhw> {
  bool isbuttonenabled = false;

  var heightcontroll = TextEditingController();
  var weightcontroll = TextEditingController();
  int userId = 1;

  @override
  void initState() {
    // TODO: implement initState

    //adding the listener
    super.initState();
    heightcontroll.addListener(_validateform);
    weightcontroll.addListener(_validateform);
    _fetchUserData();
    // Fetch existing user data and populate the fields
  }

  final FitnesshwDB = Get.put(
    fitnesshw(),
  );

  void _validateform() {
    if (mounted) {
      setState(() {
        isbuttonenabled =
            heightcontroll.text.isNotEmpty && weightcontroll.text.isNotEmpty;
      });
    }
  }

  void _fetchUserData() async {
    try {
      var userData = await FitnesshwDB.getUserById(userId);
      setState(() {
        heightcontroll.text = userData['height'].toString();
        weightcontroll.text = userData['weight'].toString();
      });
    } catch (e) {
      // Handle error
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose

    heightcontroll.dispose();
    weightcontroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: fgreydark,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 100,
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
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      color: fwhite,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: isbuttonenabled
                      ? () async {
                          print('Save button tapped');

                          Map<String, dynamic> data = {
                            'height': heightcontroll.text,
                            'weight': weightcontroll.text,
                          };
                          // Update data from frontend to backend
                          print('Updating data...');
                          await FitnesshwDB.update_datahw(userId, data);
                          print('Navigation to next page...');
                          Get.to(BottomNavBar());
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
                                'Please fill all the required fields to Continue !',
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
                        color: isbuttonenabled ? fredmid : Colors.transparent,
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
            const SizedBox(
              height: 40,
            ),
            Center(
              child: Container(
                  height: screensize.height * 0.07,
                  width: screensize.width * 0.5,
                  decoration: BoxDecoration(
                      //color: fcyan,
                      ),
                  child: SvgPicture.asset(
                    'assets/change.svg',
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                'Change Height and Weight',
                style: GoogleFonts.montserrat(
                  fontSize: 25,
                  color: fwhite,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              textAlign: TextAlign.center,
              'Change if you have increased or decreased in Height or Weight',
              style: GoogleFonts.montserrat(
                fontSize: 15,
                color: fwhite.withOpacity(0.6),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                textAlign: TextAlign.center,
                '(This may affect your BMI)',
                style: GoogleFonts.montserrat(
                  fontSize: 15,
                  color: fcyan.withOpacity(0.7),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: Column(children: [
                //user name text field

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
                const SizedBox(
                  height: 50,
                ),

                const SizedBox(
                  height: 50,
                ),

                const SizedBox(
                  height: 100,
                ),
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}
