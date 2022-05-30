import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';
import 'package:tealth_project/lab/SearchList.dart';

import '../main.dart';
import '../model/user_model.dart';
import '../widgets/bottombar.dart';
import 'LabPage.dart';

class HomeScreenLab extends StatefulWidget {
  const HomeScreenLab({Key? key}) : super(key: key);

  @override
  _HomeScreenLabState createState() => _HomeScreenLabState();
}

class _HomeScreenLabState extends State<HomeScreenLab> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final secondaryColor = const Color(0xff0095FF);

  TextEditingController _patientId = TextEditingController();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    String _message = "";
    DateTime now = DateTime.now();
    String _currentHour = DateFormat('kk').format(now);
    int hour = int.parse(_currentHour);

    setState(
      () {
        if (hour >= 5 && hour < 12) {
          _message = 'Good Morning';
        } else if (hour >= 12 && hour <= 17) {
          _message = 'Good Afternoon';
        } else {
          _message = 'Good Evening';
        }
      },
    );

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Transform.rotate(
                    origin: Offset(30, -60),
                    angle: 2.4,
                    child: Container(
                      margin: EdgeInsets.only(
                        left: 75,
                        top: 40,
                      ),
                      height: 350,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80),
                        gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          colors: [Color(0xff0095FF), Color(0xff0095FF)],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 70),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _message,
                          style: GoogleFonts.lato(
                            color: Colors.black54,
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        Text(
                          "${loggedInUser.firstName} ",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 1),
                          child: NotificationListener<
                              OverscrollIndicatorNotification>(
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
                                    SizedBox(
                                      height: 30,
                                    ),
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
                                      padding:
                                          EdgeInsets.fromLTRB(20, 0, 20, 25),
                                      child: TextFormField(
                                        textInputAction: TextInputAction.search,
                                        controller: _patientId,
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
                                              color: Color(0xff0095FF),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: IconButton(
                                              iconSize: 20,
                                              splashRadius: 20,
                                              color: Colors.white,
                                              icon: Icon(Icons.search),
                                              onPressed: () {
                                                // SearchListPatient(
                                                //     searchKey: );
                                              },
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
                                                              SearchListPatient(
                                                                searchKey:
                                                                    value,
                                                              )),
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
        ));
  }
}
