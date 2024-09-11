import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:fitness_tracker_app/constants/theme.dart';

// Define a data model class to hold steps and calories data
class ProgressData {
  final int day;
  final int steps;
  final int calories;

  ProgressData(this.day, this.steps, this.calories);
}

class ProgressPage extends StatefulWidget {
  const ProgressPage({Key? key}) : super(key: key);

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  final List<ProgressData> data = [
    ProgressData(1, 5000, 200),
    ProgressData(2, 6000, 250),
    ProgressData(3, 5500, 220),
    ProgressData(4, 7000, 300),
    ProgressData(5, 8000, 350),
    ProgressData(6, 7500, 320),
    ProgressData(7, 9000, 400),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fgreydark,
      appBar: AppBar(
        backgroundColor: fgreydark,
        title: Padding(
          padding: const EdgeInsets.only(left: 75, top: 20),
          child: Text(
            'Progress',
            style: GoogleFonts.montserrat(
              color: fredmid,
              fontWeight: FontWeight.w700,
              fontSize: 30,
            ),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(top: 0),
          child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: 20,
              color: fwhite,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 300,
              padding: EdgeInsets.all(16.0),
              child: SfCartesianChart(
                plotAreaBorderColor: fgrey,
                primaryXAxis: NumericAxis(
                  title: AxisTitle(
                    text: 'Day',
                    textStyle: GoogleFonts.montserrat(
                      color: fwhite,
                    ),
                  ),
                  majorGridLines: MajorGridLines(color: fgrey),
                  labelStyle: TextStyle(color: fwhite),
                  minimum: 1,
                  maximum: 7,
                  interval: 1,
                ),
                primaryYAxis: NumericAxis(
                  majorGridLines:
                      MajorGridLines(color: Color.fromARGB(255, 66, 66, 66)),
                  labelStyle: TextStyle(color: fwhite),
                ),
                series: <CartesianSeries>[
                  LineSeries<ProgressData, int>(
                    dataSource: data,
                    xValueMapper: (ProgressData progress, _) => progress.day,
                    yValueMapper: (ProgressData progress, _) => progress.steps,
                    name: 'Steps',
                    color: fcyan,
                  ),
                ],
                legend: Legend(
                  isVisible: true,
                  textStyle: TextStyle(color: fwhite),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              '(You can change your goals and test your capability)',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                color: fwhitelite,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 300,
              padding: EdgeInsets.all(16.0),
              child: SfCartesianChart(
                plotAreaBorderColor: fgrey,
                primaryXAxis: NumericAxis(
                  title: AxisTitle(
                    text: 'Day',
                    textStyle: GoogleFonts.montserrat(color: fwhite),
                  ),
                  majorGridLines:
                      MajorGridLines(color: Color.fromARGB(255, 66, 66, 66)),
                  labelStyle: TextStyle(color: fwhite),
                  minimum: 1,
                  maximum: 7,
                  interval: 1,
                ),
                primaryYAxis: NumericAxis(
                  majorGridLines:
                      MajorGridLines(color: Color.fromARGB(255, 66, 66, 66)),
                  labelStyle: TextStyle(color: fwhite),
                ),
                series: <CartesianSeries>[
                  LineSeries<ProgressData, int>(
                    dataSource: data,
                    xValueMapper: (ProgressData progress, _) => progress.day,
                    yValueMapper: (ProgressData progress, _) =>
                        progress.calories,
                    name: 'Calories',
                    color: forange,
                  ),
                ],
                legend: Legend(
                  isVisible: true,
                  textStyle: TextStyle(color: fwhite),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
