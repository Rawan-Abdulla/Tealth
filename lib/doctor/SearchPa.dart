// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tealth_project/doctor/SeListPa.dart';

class searchpa extends StatefulWidget {
  const searchpa({Key? key}) : super(key: key);

  @override
  _searchpaState createState() => _searchpaState();
}

class _searchpaState extends State<searchpa> {
  TextEditingController _patientName = TextEditingController();

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 70),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 1),
                      child:
                          NotificationListener<OverscrollIndicatorNotification>(
                        onNotification:
                            (OverscrollIndicatorNotification overscroll) {
                          overscroll.disallowGlow();
                          return true;
                        },
                        child: ListView(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          children: <Widget>[
                            Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding:
                                      EdgeInsets.only(left: 20, bottom: 25),
                                  child: Text(
                                    "Let's Find Your\nPatient",
                                    style: GoogleFonts.lato(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(20, 0, 20, 25),
                                  child: TextFormField(
                                    textInputAction: TextInputAction.search,
                                    controller: _patientName,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          left: 20, top: 10, bottom: 10),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0)),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                      hintText: 'Search Patient',
                                      hintStyle: GoogleFonts.lato(
                                        color: Colors.black26,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                      ),
                                      suffixIcon: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: IconButton(
                                          iconSize: 20,
                                          splashRadius: 20,
                                          color: Colors.white,
                                          icon: Icon(Icons.search),
                                          onPressed: () {},
                                        ),
                                      ),
                                    ),
                                    style: GoogleFonts.lato(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                    ),
                                    onFieldSubmitted: (String value) {
                                      setState(
                                        () {
                                          value.length == 0
                                              ? Container()
                                              : Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        SearchPa(
                                                      searchKey: value,
                                                    ),
                                                  ),
                                                );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
