import 'package:fitness_tracker_app/constants/theme.dart';
import 'package:fitness_tracker_app/pages/BMIpage.dart';
import 'package:fitness_tracker_app/pages/account_page.dart';
import 'package:fitness_tracker_app/pages/home_page.dart';
//import 'package:fitness_tracker_app/pages/seven_days_progress_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  var currentIndex = 0;
  List<Widget> screen = [
    homepage(),
    BMI(),
    accpage(),
  ];
  @override
  Widget build(BuildContext context) {
    //final screensize = MediaQuery.sizeOf(context);
    double displayWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: fgreydark,
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(displayWidth * .05),
        height: displayWidth * .155,
        decoration: BoxDecoration(
          color: fgrey.withOpacity(0.3),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.06),
              blurRadius: 30,
              offset: Offset(0, 10),
            )
          ],
          borderRadius: BorderRadius.circular(50),
        ),
        child: ListView.builder(
          itemCount: 3,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: displayWidth * .02),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              setState(
                () {
                  currentIndex = index;
                  HapticFeedback.lightImpact();
                },
              );
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Stack(
              children: [
                AnimatedContainer(
                  duration: Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width: index == currentIndex
                      ? displayWidth * .32 //inner selection container weight
                      : displayWidth * .18,
                  alignment: Alignment.center,
                  child: AnimatedContainer(
                    duration: Duration(seconds: 1),
                    curve: Curves.fastLinearToSlowEaseIn,
                    height: index == currentIndex
                        ? displayWidth * .12
                        : 0, //inner selection container height
                    width: index == currentIndex ? displayWidth * .32 : 0,
                    decoration: BoxDecoration(
                      color: index == currentIndex
                          ? fcyan.withOpacity(.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width: index == currentIndex
                      ? displayWidth * .26
                      : displayWidth * .27,
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width:
                                index == currentIndex ? displayWidth * .13 : 0,
                          ),
                          AnimatedOpacity(
                            opacity: index == currentIndex ? 1 : 0,
                            duration: Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: Text(
                              index == currentIndex
                                  ? '${listOfString[index]}'
                                  : '',
                              style: TextStyle(
                                color: fcyan,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width:
                                index == currentIndex ? displayWidth * .03 : 30,
                          ),
                          Icon(
                            listOfIcons[index],
                            size: displayWidth * .076,
                            color: index == currentIndex ? fcyan : fwhitelite,
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: screen[currentIndex],
    );
  }

  List<String> listOfString = [
    'Home',
    'BMI',
    'Account',
  ];

  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.calculate,
    Icons.person_rounded,
  ];
}
