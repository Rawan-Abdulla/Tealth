// ignore: file_names

// ignore_for_file: use_key_in_widget_constructors, camel_case_types

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:tealth_project/HomePageScreen.dart';

import 'package:tealth_project/doctor/DrHomePage.dart';
import 'package:tealth_project/doctor/doctorProfile.dart';
import 'package:typicons_flutter/typicons_flutter.dart';

class barDr extends StatefulWidget {
  @override
  _barDrState createState() => _barDrState();
}

class _barDrState extends State<barDr> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _selectedIndex = 0;
  List<Widget> _pages = [HomeScreenDr(), DoctorProfile()];

  FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;

  Future<void> _getUser() async {
    user = _auth.currentUser!;
  }

  _navigate(Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }

  String shortcut = "no action set";

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  signOut() async {
    await _auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        key: _scaffoldKey,
        body: _pages[_selectedIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.2),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
              child: GNav(
                curve: Curves.easeOutExpo,
                rippleColor: Color.fromARGB(255, 224, 224, 224),
                hoverColor: Color.fromARGB(255, 245, 245, 245),
                haptic: true,
                tabBorderRadius: 20,
                gap: 5,
                activeColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: Colors.blue.withOpacity(0.9),
                textStyle: GoogleFonts.lato(
                  color: Colors.white,
                ),
                tabs: [
                  GButton(
                    iconSize: _selectedIndex != 0 ? 28 : 25,
                    icon: _selectedIndex == 0
                        ? Typicons.home
                        : Typicons.home_outline,
                    text: 'Home',
                  ),
                  GButton(
                    iconSize: 29,
                    icon: _selectedIndex == 1
                        ? Typicons.user
                        : Typicons.user_outline,
                    text: 'Profile',
                  ),
                  GButton(
                    iconSize: 29,
                    icon: Typicons.arrow_back,
                    text: 'Logout',
                    onPressed: () {
                      //Future<void> logout(BuildContext context) async {
                      FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => HomePage()));
                      // }
                    },
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: _onItemTapped,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
