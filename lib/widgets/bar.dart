// ignore: file_names

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:tealth_project/Lab/LabHome.dart';
import 'package:tealth_project/Lab/LabPage.dart';
import 'package:tealth_project/login.dart';
import 'package:tealth_project/pateint/homepage.dart';
import 'package:typicons_flutter/typicons_flutter.dart';
import 'package:quick_actions/quick_actions.dart';

class bar extends StatefulWidget {
  @override
  _barState createState() => _barState();
}

class _barState extends State<bar> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  List<Widget> _pages = [HomeScreenLab(), LabPage(), LabPage()];

  FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;

  Future<void> _getUser() async {
    user = _auth.currentUser!;
  }

  signOut() async {
    await _auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
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
                tabBackgroundColor: Colors.blue.withOpacity(0.7),
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
                  // GButton(
                  //   icon: FlutterIcons.search1_ant,
                  //   text: 'Search',
                  // ),
                  GButton(
                    iconSize: 28,
                    icon: _selectedIndex == 1 ? Typicons.bell : Typicons.bell,
                    text: 'Notification',
                  ),
                  GButton(
                    iconSize: 29,
                    icon: _selectedIndex == 2
                        ? Typicons.user
                        : Typicons.user_outline,
                    text: 'Profile',
                  ),
                  GButton(
                    iconSize: 29,
                    icon: Typicons.arrow_back,
                    text: 'Logout',
                    onPressed: () {
                      //  Future _signOut() async {
                      signOut();
                      //  }
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
