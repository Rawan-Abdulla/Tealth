import 'package:flutter/material.dart';
import 'package:tealth_project/examinatiomScreens/getExamination.dart';
import 'package:tealth_project/pateint/SearchLab.dart';
import 'package:tealth_project/pateint/appointemntList.dart';
import 'package:tealth_project/pateint/searchDoctor.dart';

import 'ScheduleTab.dart';
import 'getExamination.dart';
import 'homepage.dart';

class CatigoryW extends StatelessWidget {
  String image;
  String text;
  Color color;

  CatigoryW({required this.image, required this.text, required this.color});
  List pages = [
    searchDoctor(),
    getExamination(),
    searchLab(),
    MyAppointmentList()
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 160,
        width: 138,
        decoration: BoxDecoration(
          border: Border.all(color: Color.fromARGB(255, 58, 128, 248)),
          borderRadius: BorderRadius.circular(12),
          color: Color.fromARGB(159, 233, 237, 243),
        ),
        child: Column(
          children: [
            Image.asset(
              image,
              width: 120,
              height: 120,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              text,
              style: TextStyle(color: color, fontSize: 18),
            ),
          ],
        ),
      ),
      onTap: () {
        if (text == "Appointments") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => pages[3]),
          );
        }
        if (text == "Find Lab") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => pages[2]),
          );
        }
        if (text == "Find Doctor") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => pages[0]),
          );
        }
        if (text == "Examinations") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => pages[1]),
          );
        }
      },
    );
  }
}
