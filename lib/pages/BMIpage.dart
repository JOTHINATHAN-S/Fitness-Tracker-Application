import 'package:fitness_tracker_app/constants/theme.dart';
import 'package:fitness_tracker_app/database/fitness_height_weight.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class BMI extends StatefulWidget {
  const BMI({super.key});

  @override
  State<BMI> createState() => _BMIState();
}

class _BMIState extends State<BMI> {
  //final fitnesshwdata = Get.put(fitnesshw());
  final fitnesshwdata = fitnesshw();
  double? bmi;

  //creating a empty list to append data

  List<Map<String, dynamic>> fitnessmeasurement = [];
  // File? _selectedImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retrievedata();
  }

  //fetching data frm backend
  Future<void> retrievedata() async {
    final List<Map<String, dynamic>> data =
        await fitnesshwdata.retrieve_datahw();
    fitnessmeasurement = data;
    if (data.isNotEmpty) {
      double height = data[0]['height'];
      double weight = data[0]['weight'];
      setState(() {
        bmi = weight / ((height / 100) * (height / 100));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.sizeOf(context);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: fgreydark,
        body: bmi != null
            ? SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 0, right: 180),
                          child: Container(
                              width: 200,
                              child: LottieBuilder.asset(
                                  'assets/body_mass_index(1).json')),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 178, left: 150),
                          child: Text(
                            'BMI',
                            style: GoogleFonts.josefinSans(
                              fontSize: 70,
                              fontWeight: FontWeight.w600,
                              color: fredmid,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 220, left: 260),
                          child: Text(
                            '(Body Mass Index)',
                            style: GoogleFonts.josefinSans(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: fcyan.withOpacity(0.6),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 270),
                          child: Column(
                            children: [
                              Text(
                                textAlign: TextAlign.center,
                                "This BMI(Body Mass Index) is calculated by your height and weight to track your health",
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  color: fwhite.withOpacity(0.6),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: screensize.height * 0.3,
                      width: screensize.width * 0.95,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: fgrey.withOpacity(0.3),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Color.fromARGB(255, 0, 0, 0).withOpacity(0.7),
                              blurRadius: 30,
                              offset: Offset(0, 0),
                            )
                          ]),
                      child: Column(
                        children: [
                          Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 45, top: 20),
                                  child: Text(
                                    "Your Height",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      color: fwhite,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 130, top: 20),
                                  child: Text(
                                    "Your Weight",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      color: fwhite,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 50, top: 20),
                                child: Text(
                                  fitnessmeasurement[0]['height'].toString(),
                                  style: GoogleFonts.montserrat(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w600,
                                    color: fcyan,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 150, top: 20),
                                child: Text(
                                  fitnessmeasurement[0]['weight'].toString(),
                                  style: GoogleFonts.montserrat(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w600,
                                    color: fcyan,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Column(
                            children: [
                              Text(
                                'Your BMI',
                                style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  color: fwhite,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              bmi != null
                                  ? Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Text(
                                        '${bmi!.toStringAsFixed(1)}',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 50,
                                          color: fredmid,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    )
                                  : CircularProgressIndicator(
                                      color: fcyan,
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 38,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Text(
                        textAlign: TextAlign.center,
                        '(The healthy range of BMI lies from 18.5 to 24.9. BMI of 25.0 or more is overweight)',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: fwhite.withOpacity(0.6),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        bmi! < 18.5
                            ? Padding(
                                padding:
                                    const EdgeInsets.only(top: 70, left: 60),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 100,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: LottieBuilder.asset(
                                            'assets/nah_emoji.json',
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 50),
                                          child: Text(
                                            'UnderWeight !',
                                            style: GoogleFonts.josefinSans(
                                              fontSize: 30,
                                              color: fcyan,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "Ensure your BMI is between 18.5  to 24.9. Maintain a proper diet to stay healthy",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 18,
                                        color: fwhite,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : bmi! >= 18.5 && bmi! <= 24.9
                                ? Column(
                                    children: [
                                      Row(
                                        children: [
                                          LottieBuilder.asset(
                                            'assets/meditation.json',
                                            height: 200,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 90,
                                            ),
                                            child: Text(
                                              'Healthy !',
                                              style: GoogleFonts.josefinSans(
                                                fontSize: 40,
                                                color: fcyan,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 18,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          "You are healthy. Follow the same diet to maintain your BMI",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 18,
                                            color: fwhite,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(
                                        top: 70, left: 60),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 100,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                              ),
                                              child: LottieBuilder.asset(
                                                'assets/nah_emoji.json',
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 50),
                                              child: Text(
                                                'OverWeighted !',
                                                style: GoogleFonts.josefinSans(
                                                  fontSize: 30,
                                                  color: fcyan,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "Ensure your BMI is between 18.5  to 24.9. Maintain a proper diet to stay healthy",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 18,
                                            color: fwhite,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                      ],
                    ),
                    const SizedBox(
                      height: 70,
                    )
                  ],
                ),
              )
            : CircularProgressIndicator(
                color: fcyan,
              ),
      ),
    );
  }
}
