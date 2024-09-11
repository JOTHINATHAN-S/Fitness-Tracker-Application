import 'package:fitness_tracker_app/constants/theme.dart';
import 'package:fitness_tracker_app/database/fitness_SQFlite.dart';
//import 'package:fitness_tracker_app/pages/account_page.dart';
import 'package:fitness_tracker_app/pages/bottomnavar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class editscrn extends StatefulWidget {
  const editscrn({super.key});

  @override
  State<editscrn> createState() => _editscrnState();
}

class _editscrnState extends State<editscrn> {
  int selected = 0; //radio box variable
  bool isbuttonenabled = false;

  var nameController = TextEditingController();
  var ageController = TextEditingController();
  var phone_noController = TextEditingController();
  var e_mailController = TextEditingController();
  int userId = 1;

  @override
  void initState() {
    // TODO: implement initState

    //adding the listener
    super.initState();
    nameController.addListener(_validateform);
    ageController.addListener(_validateform);
    phone_noController.addListener(_validateform);
    e_mailController.addListener(_validateform);
    _fetchUserData();
    // Fetch existing user data and populate the fields
  }

  final FitnessDB = Get.put(
    fitnessDBSQFlite(),
  );

  void _validateform() {
    if (mounted) {
      setState(() {
        isbuttonenabled = nameController.text.isNotEmpty &&
            ageController.text.isNotEmpty &&
            phone_noController.text.isNotEmpty &&
            e_mailController.text.isNotEmpty &&
            selected != 0;
      });
    }
  }

  void _fetchUserData() async {
    try {
      var userData = await FitnessDB.getUserById(userId);
      setState(() {
        nameController.text = userData['user_name'];
        ageController.text = userData['age'];
        phone_noController.text = userData['phone_number'];
        e_mailController.text = userData['E_MAIL'];
        selected = genderMap.keys
            .firstWhere((k) => genderMap[k] == userData['gender']);
      });
    } catch (e) {
      // Handle error
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose

    nameController.dispose();
    ageController.dispose();
    phone_noController.dispose();
    e_mailController.dispose();
    super.dispose();
  }

  // Map to link index to gender string values
  final Map<int, String> genderMap = {
    1: 'Male',
    2: 'Female',
    3: 'Others',
  };
  Widget customRadio(String text, int index) {
    //radio box widget
    return OutlinedButton(
      //radio box widget
      onPressed: () {
        setState(() {
          selected = index;
        });
        _validateform();
      },
      child: Text(
        text,
        style: GoogleFonts.montserrat(
          color: (selected == index) ? forange : fwhitelite,
        ),
      ),
      style: OutlinedButton.styleFrom(
        fixedSize: Size(100, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        side: BorderSide(
          color: (selected == index) ? forange : fwhitelite,
        ),
      ),
    );
  } //END OF THE RADIO WIDGET

  //dependency injection

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
              height: 70,
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
                          String? selectedGender = genderMap[selected];
                          Map<String, dynamic> data = {
                            'user_name': nameController.text,
                            'age': ageController.text,
                            'phone_number': phone_noController.text,
                            'E_MAIL': e_mailController.text,
                            'gender': selectedGender, //store the gender
                          };
                          // Update data from frontend to backend
                          print('Updating data...');
                          await FitnessDB.update_data(userId, data);
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
                child: Icon(
                  Icons.edit,
                  size: 50,
                  color: fcyan,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                'Edit Profile',
                style: GoogleFonts.montserrat(
                  fontSize: 33,
                  color: fredmid,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                //user name text field

                Container(
                  height: screensize.height * 0.050,
                  width: screensize.width * 0.50,
                  decoration: BoxDecoration(
                    color: fgrey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    controller: nameController,
                    cursorColor: fredmid,
                    style: GoogleFonts.montserrat(
                      color: fwhite,
                    ),
                    decoration: InputDecoration(
                      hintText: 'username',
                      hintStyle: GoogleFonts.montserrat(
                        color: fwhitelite,
                      ),
                      prefixIcon: Icon(
                        Icons.person_2_outlined,
                        size: 18,
                        color: fwhitelite,
                      ),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),

                //DOB text field

                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Container(
                    height: screensize.height * 0.050,
                    width: screensize.width * 0.32,
                    decoration: BoxDecoration(
                      color: fgrey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: ageController,
                      cursorColor: fredmid,
                      style: GoogleFonts.montserrat(
                        color: fwhite,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Age',
                        hintStyle: GoogleFonts.montserrat(
                          color: fwhitelite,
                        ),
                        prefixIcon: Icon(
                          Icons.date_range_outlined,
                          size: 18,
                          color: fwhitelite,
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            //phone number text field

            Padding(
              padding: const EdgeInsets.only(top: 50),
              // child: Container(
              //   height: screensize.height * 0.060,
              //   width: screensize.width * 0.80,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(20),
              //     //border: Border.all(color: fwhitelite, width: 1),
              //   ),
              child: IntlPhoneField(
                controller: phone_noController,
                cursorColor: fredmid,
                keyboardType: TextInputType.phone,
                dropdownTextStyle: GoogleFonts.montserrat(
                  fontSize: 20,
                  color: fwhite,
                ),
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  color: fwhite,
                ),
                decoration: InputDecoration(
                  labelText: '  Phone Number',
                  labelStyle: GoogleFonts.montserrat(
                    color: fwhitelite,
                  ),
                  // enabledBorder: OutlineInputBorder(
                  //     borderRadius: BorderRadius.circular(20),
                  //     borderSide: BorderSide(
                  //       color: fwhitelite,
                  //     )),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: fcyan,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: fwhite,
                    ),
                  ),
                ),
              ),
            ),
            //)

            //e-mail text field

            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Container(
                height: screensize.height * 0.070,
                width: screensize.width * 0.80,
                decoration: BoxDecoration(
                  color: fgrey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: e_mailController,
                    cursorColor: fredmid,
                    keyboardType: TextInputType.emailAddress,
                    style: GoogleFonts.montserrat(color: fwhite, fontSize: 15),
                    decoration: InputDecoration(
                      hintText: '   E-mail',
                      hintStyle: GoogleFonts.montserrat(color: fwhitelite),
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: fwhitelite,
                        size: 18,
                      ),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),

            //gender text widget

            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Text(
                'Choose your gender',
                style: GoogleFonts.montserrat(
                  fontSize: 15,
                  color: fwhite,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  customRadio('Male', 1),
                  customRadio('Female', 2),
                  customRadio('Others', 3),
                ],
              ),
            ),

            //terms and condition
            // Padding(
            //   padding: const EdgeInsets.only(top: 20),
            //   child: Row(
            //     children: [
            //       Checkbox(
            //         activeColor: forange,
            //         value: isChecked,
            //         onChanged: (bool? newval) {
            //           setState(() {
            //             isChecked = newval!;
            //           });
            //         },
            //       ),
            //       Text(
            //         'I agree to the',
            //         style: GoogleFonts.montserrat(
            //           fontSize: 14,
            //           color: fwhite,
            //         ),
            //       ),
            //       Container(
            //         child: Text(
            //           ' terms and conditions',
            //           style: GoogleFonts.montserrat(
            //             fontSize: 14,
            //             color: forange,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            const SizedBox(
              height: 50,
            ),

            const SizedBox(
              height: 50,
            ),

            //pushing database
            // Center(
            //   child: GestureDetector(
            //     onTap: isbuttonenabled
            //         ? () async {
            //             String? selectedGender = genderMap[selected];
            //             Map<String, dynamic> data = {
            //               'user_name': nameController.text,
            //               'age': ageController.text,
            //               'phone_number': phone_noController.text,
            //               'E_MAIL': e_mailController.text,
            //               'gender': selectedGender, //store the gender
            //             };
            //             //insert data from frontend - backend
            //             await FitnessDB.insertdata(data);
            //           }
            //         : () {
            //             showDialog(
            //               context: context,
            //               builder: (context) => AlertDialog(
            //                 backgroundColor:
            //                     const Color.fromARGB(255, 34, 34, 34),
            //                 title: Text(
            //                   'Sorry!',
            //                   style: GoogleFonts.montserrat(
            //                     fontSize: 25,
            //                     fontWeight: FontWeight.w600,
            //                     color: Colors.redAccent,
            //                   ),
            //                 ),
            //                 content: Text(
            //                   textAlign: TextAlign.center,
            //                   'Please fill all the required fields to Continue !',
            //                   style: GoogleFonts.montserrat(
            //                     fontSize: 20,
            //                     fontWeight: FontWeight.w600,
            //                     color: fwhite,
            //                   ),
            //                 ),
            //                 actions: [
            //                   TextButton(
            //                     onPressed: () {
            //                       Navigator.of(context).pop();
            //                     },
            //                     child: Text(
            //                       'OK!',
            //                       style: GoogleFonts.montserrat(
            //                         fontSize: 15,
            //                         fontWeight: FontWeight.w600,
            //                         color: fwhite,
            //                       ),
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             );
            //           },
            //     child: Container(
            //       height: screensize.height * 0.060,
            //       width: screensize.width * 0.30,
            //       decoration: BoxDecoration(
            //         color: isbuttonenabled ? fredmid : Colors.transparent,
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //       alignment: Alignment.center,
            //       child: Row(
            //         children: [
            //           Text(
            //             'SAVE',
            //             style: GoogleFonts.montserrat(
            //               fontSize: 20,
            //               color: fwhite,
            //               fontWeight: FontWeight.w600,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: 100,
            ),
          ]),
        ),
      ),
    );
  }
}