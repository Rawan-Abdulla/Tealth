import 'package:flutter/material.dart';
import 'package:tealth_project/doctor/SearchPa.dart';

class CatigoryDr extends StatelessWidget {
  String image;
  String text;
  Color color;

  CatigoryDr({required this.image, required this.text, required this.color});
  List pages = [searchpa()];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 160,
        width: 138,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Color.fromARGB(255, 58, 128, 248)),
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
            MaterialPageRoute(builder: (context) => pages[1]),
          );
        }

        if (text == "Find Patient") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => pages[0]),
          );
        }
      },
    );
  }
}
