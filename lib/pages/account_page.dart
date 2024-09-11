// import 'dart:io';

import 'package:fitness_tracker_app/constants/theme.dart';
import 'package:fitness_tracker_app/database/fitness_SQFlite.dart';
import 'package:fitness_tracker_app/database/fitness_goaldb.dart';
import 'package:fitness_tracker_app/database/fitness_height_weight.dart';
import 'package:fitness_tracker_app/edit_hw.dart';
import 'package:fitness_tracker_app/pages/editpage.dart';
//import 'package:fitness_tracker_app/pages/user_details_stful.dart';
//import 'package:fitness_tracker_app/pages/welcome_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class accpage extends StatefulWidget {
  const accpage({super.key});

  @override
  State<accpage> createState() => _accpageState();
}

class _accpageState extends State<accpage> {
  final fitnessredata = Get.put(fitnessDBSQFlite());
  final fitnesshwdata = Get.put(fitnesshw());
  final fitnessgoaldata = Get.put(fitnessgoal());

  //creating a empty list to append data

  List<Map<String, dynamic>> fitnessList = [];
  List<Map<String, dynamic>> fitnessmeasurement = [];
  List<Map<String, dynamic>> fitnessgoals = [];
  // File? _selectedImage;

  //fetching data frm backend
  Future<void> retrievedata() async {
    final outputdata = await fitnessredata.retrieve_data();
    final outdatahw = await fitnesshwdata.retrieve_datahw();
    final outdatagoal = await fitnessgoaldata.retrieve_datagoal();
    if (mounted) {
      setState(() {
        fitnessList = outputdata;
        fitnessmeasurement = outdatahw;
        fitnessgoals = outdatagoal;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retrievedata();
  }

  // void _deleteAccount() async {
  //   bool? confirmed = await showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       backgroundColor: const Color.fromARGB(255, 34, 34, 34),
  //       title: Text(
  //         'Confirm Delete',
  //         style: GoogleFonts.montserrat(
  //           fontSize: 25,
  //           fontWeight: FontWeight.w600,
  //           color: Colors.redAccent,
  //         ),
  //       ),
  //       content: Text(
  //         'Are you sure you want to delete your account?',
  //         style: GoogleFonts.montserrat(
  //           fontSize: 20,
  //           fontWeight: FontWeight.w600,
  //           color: fwhite,
  //         ),
  //       ),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Get.back(),
  //           child: Text(
  //             'Cancel',
  //             style: GoogleFonts.montserrat(
  //               fontSize: 15,
  //               fontWeight: FontWeight.w600,
  //               color: fwhite,
  //             ),
  //           ),
  //         ),
  //         TextButton(
  //           onPressed: () => Navigator.of(context).pop(true),
  //           // async {
  //           //   await fitnesshwdata.delete_datahw();
  //           //   await fitnessredata.delete_data();
  //           //   await fitnessgoaldata.delete_datagoal();
  //           //   setState(() {
  //           //     fitnessList.clear();
  //           //     fitnessmeasurement.clear();
  //           //     fitnessgoals.clear();
  //           //   });
  //           //   Navigator.of(context).pushReplacement(
  //           //     MaterialPageRoute(builder: (_) => userd()),
  //           //   );
  //           //   Get.to(welcomepage());
  //           // },
  //           child: Text(
  //             'Delete',
  //             style: GoogleFonts.montserrat(
  //               fontSize: 15,
  //               fontWeight: FontWeight.w600,
  //               color: Colors.red,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );

  //   if (confirmed == true) {
  //     await fitnesshwdata.delete_datahw();
  //     await fitnessredata.delete_data();
  //     await fitnessgoaldata.delete_datagoal();
  //     // setState(() {
  //     //   fitnessList.clear();
  //     //   fitnessmeasurement.clear();
  //     //   fitnessgoals.clear();
  //     //   Get.offAll(() => welcomepage());
  //     // });
  //     // Replace with your home page or login page
  //     Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(builder: (context) => welcomepage()),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.sizeOf(context);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: fgreydark,
        body: fitnessList.isEmpty
            ? Center(
                child: CircularProgressIndicator(
                  color: fcyan,
                ),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 70,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 300),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(editscrn());
                        },
                        child: Container(
                          // color: fgreydark,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            children: [
                              Text(
                                'Edit  ',
                                style: GoogleFonts.montserrat(
                                    color: fwhite,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400),
                              ),
                              Icon(
                                Icons.edit,
                                size: 20,
                                color: fwhite,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Container(
                          height: screensize.height * 0.1,
                          width: screensize.width * 1,
                          child: SvgPicture.asset(
                              'assets/exercise-gym-svgrepo-com (1).svg')),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: Text(
                        fitnessList[0]['user_name'].toString(),
                        style:
                            GoogleFonts.montserrat(fontSize: 40, color: fwhite),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Text(
                        'Your Details',
                        style: GoogleFonts.montserrat(
                            color: fwhite.withOpacity(0.5)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        height: screensize.height * 0.60,
                        width: screensize.width * 0.95,
                        decoration: BoxDecoration(
                            color: fgrey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20)),

                        //AGE

                        child: Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 60,
                              ),
                              Text(
                                'Age',
                                style: GoogleFonts.montserrat(
                                  fontSize: 15,
                                  color: fwhite.withOpacity(0.6),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.date_range_rounded,
                                      size: 20,
                                      color: fwhite,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      fitnessList[0]['age'].toString(),
                                      style: GoogleFonts.montserrat(
                                        fontSize: 20,
                                        color: fwhite,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(
                                height: 20,
                              ),
                              //phone number
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Phone number',
                                    style: GoogleFonts.montserrat(
                                        color: fwhite.withOpacity(0.6),
                                        fontSize: 15),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.phone_enabled_rounded,
                                          size: 20,
                                          color: fwhite,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          fitnessList[0]['phone_number']
                                              .toString(),
                                          style: GoogleFonts.montserrat(
                                            fontSize: 20,
                                            color: fwhite,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              //e mail
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'E- Mali',
                                    style: GoogleFonts.montserrat(
                                        color: fwhite.withOpacity(0.6),
                                        fontSize: 15),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.email_rounded,
                                          size: 20,
                                          color: fwhite,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          fitnessList[0]['E_MAIL'].toString(),
                                          style: GoogleFonts.montserrat(
                                            fontSize: 20,
                                            color: fwhite,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              //gender
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Gender',
                                    style: GoogleFonts.montserrat(
                                        color: fwhite.withOpacity(0.6),
                                        fontSize: 15),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Row(
                                      children: [
                                        fitnessList[0]['gender'] == 'Male'
                                            ? Icon(
                                                Icons.male_rounded,
                                                size: 20,
                                                color: fwhite,
                                              )
                                            : Icon(
                                                Icons.female_rounded,
                                                size: 20,
                                                color: fwhite,
                                              ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          fitnessList[0]['gender'].toString(),
                                          style: GoogleFonts.montserrat(
                                            fontSize: 20,
                                            color: fwhite,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              //height
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Height',
                                    style: GoogleFonts.montserrat(
                                        color: fwhite.withOpacity(0.6),
                                        fontSize: 15),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.architecture_rounded,
                                          size: 20,
                                          color: fwhite,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          fitnessmeasurement[0]['height']
                                              .toString(),
                                          style: GoogleFonts.montserrat(
                                            fontSize: 20,
                                            color: fwhite,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              //weight
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Weight',
                                    style: GoogleFonts.montserrat(
                                        color: fwhite.withOpacity(0.6),
                                        fontSize: 15),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.monitor_weight_rounded,
                                          size: 20,
                                          color: fwhite,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          fitnessmeasurement[0]['weight']
                                              .toString(),
                                          style: GoogleFonts.montserrat(
                                            fontSize: 20,
                                            color: fwhite,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(editscrnhw());
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 27),
                        child: Container(
                          height: screensize.height * 0.045,
                          width: screensize.width * 0.60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            //color: fcyan,
                          ),
                          child: Text(
                            "Change your height and weight",
                            style: GoogleFonts.montserrat(
                              fontSize: 17,
                              color: fwhite,
                              //fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // GestureDetector(
                    //   onTap: _deleteAccount,
                    //   child: Container(
                    //     height: screensize.height * 0.045,
                    //     width: screensize.width * 0.50,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(10),
                    //       //color: fcyan,
                    //     ),
                    //     child: Row(
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Text(
                    //           'Delete Account ',
                    //           style: GoogleFonts.montserrat(
                    //             fontSize: 17,
                    //             color: fred.withOpacity(0.8),
                    //             fontWeight: FontWeight.w600,
                    //           ),
                    //         ),
                    //         Icon(
                    //           Icons.delete_forever_rounded,
                    //           size: 25,
                    //           color: fred.withOpacity(0.8),
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 40,
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
